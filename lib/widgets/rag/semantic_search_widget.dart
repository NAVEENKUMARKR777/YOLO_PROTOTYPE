import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../providers/rag_provider.dart';
import '../../models/vector_store_model.dart';
import '../../models/enums.dart';
import '../../models/need_model.dart';
import '../../providers/auth_provider.dart';
import '../../utils/assets_constants.dart';

class SemanticSearchWidget extends ConsumerStatefulWidget {
  final VoidCallback? onResultSelected;
  final List<DocumentType>? allowedTypes;
  final List<NeedCategory>? allowedCategories;
  final bool showFilters;
  final bool compactMode;

  const SemanticSearchWidget({
    super.key,
    this.onResultSelected,
    this.allowedTypes,
    this.allowedCategories,
    this.showFilters = true,
    this.compactMode = false,
  });

  @override
  ConsumerState<SemanticSearchWidget> createState() => _SemanticSearchWidgetState();
}

class _SemanticSearchWidgetState extends ConsumerState<SemanticSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  
  // Filter states
  Set<DocumentType> _selectedTypes = {};
  Set<NeedCategory> _selectedCategories = {};
  double _similarityThreshold = 0.7;
  int _maxResults = 10;

  @override
  void initState() {
    super.initState();
    _selectedTypes = widget.allowedTypes?.toSet() ?? {};
    _selectedCategories = widget.allowedCategories?.toSet() ?? {};
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchState = ref.watch(semanticSearchProvider);
    final user = ref.watch(authProvider).user;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.search_outlined,
                  color: theme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Semantic Search',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (searchState.searchHistory.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.history),
                    onPressed: _showSearchHistory,
                    tooltip: 'Search History',
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Search Input
            TextField(
              controller: _searchController,
              focusNode: _searchFocus,
              decoration: InputDecoration(
                hintText: 'Search for needs, solutions, or knowledge...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _clearSearch();
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: _startVoiceSearch,
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: _performSearch,
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 12),

            // Filters
            if (widget.showFilters && !widget.compactMode)
              _buildFilters(theme),

            // Search Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: searchState.isSearching || _searchController.text.isEmpty
                    ? null
                    : () => _performSearch(_searchController.text),
                child: searchState.isSearching
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 8),
                          Text('Searching...'),
                        ],
                      )
                    : const Text('Search'),
              ),
            ),
            const SizedBox(height: 16),

            // Results
            if (searchState.isSearching)
              _buildLoadingState()
            else if (searchState.error != null)
              _buildErrorState(searchState.error!, theme)
            else if (searchState.currentResult != null)
              _buildResults(searchState.currentResult!, theme)
            else
              _buildEmptyState(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(ThemeData theme) {
    return Card(
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search Filters',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Document Types
            Text('Document Types:', style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: DocumentType.values.map((type) {
                final isSelected = _selectedTypes.contains(type);
                return FilterChip(
                  label: Text(type.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedTypes.add(type);
                      } else {
                        _selectedTypes.remove(type);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            // Categories
            Text('Categories:', style: theme.textTheme.bodySmall),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: NeedCategory.values.map((category) {
                final isSelected = _selectedCategories.contains(category);
                return FilterChip(
                  label: Text(category.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedCategories.add(category);
                      } else {
                        _selectedCategories.remove(category);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            // Similarity Threshold
            Row(
              children: [
                Text('Similarity: ${(_similarityThreshold * 100).round()}%'),
                Expanded(
                  child: Slider(
                    value: _similarityThreshold,
                    min: 0.3,
                    max: 1.0,
                    divisions: 14,
                    onChanged: (value) {
                      setState(() {
                        _similarityThreshold = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            // Max Results
            Row(
              children: [
                Text('Max Results: $_maxResults'),
                Expanded(
                  child: Slider(
                    value: _maxResults.toDouble(),
                    min: 5,
                    max: 50,
                    divisions: 9,
                    onChanged: (value) {
                      setState(() {
                        _maxResults = value.round();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AssetConstants.loadingAnimation,
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 16),
          const Text('Searching knowledge base...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Search failed: $error',
              style: TextStyle(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _performSearch(_searchController.text),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(SemanticSearchResult result, ThemeData theme) {
    if (result.results.isEmpty) {
      return _buildEmptyState(theme);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${result.results.length} results found',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Search time: ${result.searchTime}ms',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Results List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: result.results.length,
          itemBuilder: (context, index) {
            final item = result.results[index];
            return _buildResultItem(item, theme);
          },
        ),
      ],
    );
  }

  Widget _buildResultItem(SearchResultItem item, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _selectResult(item),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.documentType.name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.category?.name ?? 'General',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getSimilarityColor(item.similarity, theme),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${(item.similarity * 100).round()}%',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title
              if (item.title != null) ...[
                Text(
                  item.title!,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
              ],

              // Content snippet
              Text(
                item.snippet,
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              // Keywords
              if (item.keywords.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  children: item.keywords.take(5).map((keyword) {
                    return Chip(
                      label: Text(keyword),
                      labelStyle: theme.textTheme.bodySmall,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or adjust filters',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSimilarityColor(double similarity, ThemeData theme) {
    if (similarity >= 0.9) return Colors.green;
    if (similarity >= 0.8) return Colors.lightGreen;
    if (similarity >= 0.7) return Colors.orange;
    return Colors.red;
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;
    
    final user = ref.read(authProvider).user;
    if (user == null) return;

    ref.read(semanticSearchProvider.notifier).search(
      query: query.trim(),
      userId: user.id,
      maxResults: _maxResults,
      similarityThreshold: _similarityThreshold,
      documentTypes: _selectedTypes.isEmpty ? null : _selectedTypes.toList(),
      categories: _selectedCategories.isEmpty ? null : _selectedCategories.toList(),
    );
  }

  void _clearSearch() {
    ref.read(semanticSearchProvider.notifier).clearResults();
  }

  void _selectResult(SearchResultItem item) {
    widget.onResultSelected?.call();
    // Handle result selection - navigate or show details
  }

  void _showSearchHistory() {
    final history = ref.read(semanticSearchProvider).searchHistory;
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search History',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final result = history[index];
                  return ListTile(
                    title: Text(result.query),
                    subtitle: Text('${result.results.length} results'),
                    trailing: Text(
                      '${result.searchTime}ms',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _searchController.text = result.query;
                      ref.read(semanticSearchProvider.notifier).search(
                        query: result.query,
                        userId: result.userId,
                        maxResults: result.maxResults,
                        similarityThreshold: result.similarityThreshold,
                        documentTypes: result.documentTypes,
                        categories: result.categories,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startVoiceSearch() {
    // TODO: Implement voice search using Azure Speech service
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voice search coming soon!'),
      ),
    );
  }
} 