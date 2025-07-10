import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/needs_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/need_model.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';
import '../../widgets/need_card.dart';

class CommunityFeedScreen extends ConsumerStatefulWidget {
  const CommunityFeedScreen({super.key});

  @override
  ConsumerState<CommunityFeedScreen> createState() => _CommunityFeedScreenState();
}

class _CommunityFeedScreenState extends ConsumerState<CommunityFeedScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  NeedUrgency? _selectedUrgency;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Load community needs when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(needsStateProvider.notifier).loadCommunityNeeds();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final needsState = ref.watch(needsStateProvider);
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Trending', icon: Icon(Icons.trending_up)),
            Tab(text: 'Recent', icon: Icon(Icons.access_time)),
            Tab(text: 'Urgent', icon: Icon(Icons.priority_high)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search needs in your community...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch();
                        },
                      )
                    : null,
              ),
              onChanged: (_) => _performSearch(),
            ),
          ),

          // Filter chips
          if (_hasActiveFilters())
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _buildFilterChips(),
              ),
            ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTrendingTab(needsState),
                _buildRecentTab(needsState),
                _buildUrgentTab(needsState),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: authState.user?.role == UserRole.seeker
          ? FloatingActionButton(
              onPressed: () => context.push('/home/capture-need'),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildTrendingTab(NeedsState state) {
    final trendingNeeds = _filterNeeds(state.communityNeeds)
        .where((need) => need.helpRequestsCount > 0)
        .toList()
      ..sort((a, b) => b.helpRequestsCount.compareTo(a.helpRequestsCount));

    return _buildNeedsList(trendingNeeds, state.isLoading);
  }

  Widget _buildRecentTab(NeedsState state) {
    final recentNeeds = _filterNeeds(state.communityNeeds).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return _buildNeedsList(recentNeeds, state.isLoading);
  }

  Widget _buildUrgentTab(NeedsState state) {
    final urgentNeeds = _filterNeeds(state.communityNeeds)
        .where((need) => 
            need.urgency == NeedUrgency.high || 
            need.urgency == NeedUrgency.critical)
        .toList()
      ..sort((a, b) => _getUrgencyWeight(b.urgency).compareTo(_getUrgencyWeight(a.urgency)));

    return _buildNeedsList(urgentNeeds, state.isLoading);
  }

  Widget _buildNeedsList(List<Need> needs, bool isLoading) {
    if (isLoading && needs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (needs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No needs found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters or check back later',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(needsStateProvider.notifier).loadCommunityNeeds(),
      child: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: needs.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final need = needs[index];
          return NeedCard(
            need: need,
            showActions: true,
            onTap: () => context.push('/home/need-timeline/${need.id}'),
            onHelp: () => _offerHelp(need),
            onShare: () => _shareNeed(need),
          );
        },
      ),
    );
  }

  List<Need> _filterNeeds(List<Need> needs) {
    var filteredNeeds = needs.where((need) => need.status == NeedStatus.open);

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      final searchTerm = _searchController.text.toLowerCase();
      filteredNeeds = filteredNeeds.where((need) =>
          need.title.toLowerCase().contains(searchTerm) ||
          need.description.toLowerCase().contains(searchTerm) ||
          need.category.toLowerCase().contains(searchTerm));
    }

    // Apply category filter
    if (_selectedCategory != 'All') {
      filteredNeeds = filteredNeeds.where((need) => need.category == _selectedCategory);
    }

    // Apply urgency filter
    if (_selectedUrgency != null) {
      filteredNeeds = filteredNeeds.where((need) => need.urgency == _selectedUrgency);
    }

    return filteredNeeds.toList();
  }

  bool _hasActiveFilters() {
    return _selectedCategory != 'All' || 
           _selectedUrgency != null || 
           _searchController.text.isNotEmpty;
  }

  List<Widget> _buildFilterChips() {
    final chips = <Widget>[];

    if (_searchController.text.isNotEmpty) {
      chips.add(
        FilterChip(
          label: Text('Search: ${_searchController.text}'),
          onSelected: (_) {
            _searchController.clear();
            _performSearch();
          },
        ),
      );
    }

    if (_selectedCategory != 'All') {
      chips.add(
        FilterChip(
          label: Text('Category: $_selectedCategory'),
          onSelected: (_) {
            setState(() => _selectedCategory = 'All');
          },
        ),
      );
    }

    if (_selectedUrgency != null) {
      chips.add(
        FilterChip(
          label: Text('Urgency: ${_selectedUrgency!.name}'),
          onSelected: (_) {
            setState(() => _selectedUrgency = null);
          },
        ),
      );
    }

    return chips
        .map((chip) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: chip,
            ))
        .toList();
  }

  void _performSearch() {
    setState(() {}); // Trigger rebuild with new search term
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filters',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),

              // Category filter
              Text(
                'Category',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _getCategories()
                    .map((category) => FilterChip(
                          label: Text(category),
                          selected: _selectedCategory == category,
                          onSelected: (selected) {
                            setModalState(() {
                              setState(() {
                                _selectedCategory = selected ? category : 'All';
                              });
                            });
                          },
                        ))
                    .toList(),
              ),

              const SizedBox(height: 16),

              // Urgency filter
              Text(
                'Urgency',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: NeedUrgency.values
                    .map((urgency) => FilterChip(
                          label: Text(urgency.name),
                          selected: _selectedUrgency == urgency,
                          onSelected: (selected) {
                            setModalState(() {
                              setState(() {
                                _selectedUrgency = selected ? urgency : null;
                              });
                            });
                          },
                        ))
                    .toList(),
              ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setModalState(() {
                          setState(() {
                            _selectedCategory = 'All';
                            _selectedUrgency = null;
                            _searchController.clear();
                          });
                        });
                      },
                      child: const Text('Clear All'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getCategories() {
    return [
      'All',
      'Food & Groceries',
      'Transportation',
      'Healthcare',
      'Housing',
      'Education',
      'Technology',
      'Clothing',
      'Childcare',
      'Pet Care',
      'Home Services',
      'Financial',
      'Other',
    ];
  }

  int _getUrgencyWeight(NeedUrgency urgency) {
    switch (urgency) {
      case NeedUrgency.low:
        return 1;
      case NeedUrgency.medium:
        return 2;
      case NeedUrgency.high:
        return 3;
      case NeedUrgency.critical:
        return 4;
    }
  }

  void _offerHelp(Need need) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Offer Help'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Would you like to offer help for "${need.title}"?'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Message (optional)',
                hintText: 'Let them know how you can help...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement help offering
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help offer sent!')),
              );
            },
            child: const Text('Send Offer'),
          ),
        ],
      ),
    );
  }

  void _shareNeed(Need need) {
    // TODO: Implement need sharing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing feature coming soon!')),
    );
  }
} 