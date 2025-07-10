import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:go_router/go_router.dart';

import '../../providers/needs_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/chat_provider.dart';
import '../../models/need_model.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';

class NeedTimelineScreen extends ConsumerStatefulWidget {
  final String needId;

  const NeedTimelineScreen({
    super.key,
    required this.needId,
  });

  @override
  ConsumerState<NeedTimelineScreen> createState() => _NeedTimelineScreenState();
}

class _NeedTimelineScreenState extends ConsumerState<NeedTimelineScreen> {
  final TextEditingController _updateController = TextEditingController();
  bool _isSubmittingUpdate = false;

  @override
  void initState() {
    super.initState();
    // Load need details when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(needsStateProvider.notifier).loadNeedDetails(widget.needId);
    });
  }

  @override
  void dispose() {
    _updateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final needsState = ref.watch(needsStateProvider);
    final authState = ref.watch(authStateProvider);
    final need = needsState.currentNeed;

    if (needsState.isLoading || need == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isOwner = need.requesterId == authState.user?.id;
    final canHelp = !isOwner && need.status == NeedStatus.open;

    return Scaffold(
      appBar: AppBar(
        title: Text(need.title),
        actions: [
          if (isOwner)
            PopupMenuButton<String>(
              onSelected: (value) => _handleMenuAction(value, need),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit Need'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'mark_complete',
                  child: ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text('Mark Complete'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'cancel',
                  child: ListTile(
                    leading: Icon(Icons.cancel),
                    title: Text('Cancel Need'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text('Delete Need'),
                  ),
                ),
              ],
            ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareNeed(need),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(needsStateProvider.notifier).loadNeedDetails(widget.needId),
        child: CustomScrollView(
          slivers: [
            // Need details header
            SliverToBoxAdapter(
              child: _buildNeedHeader(need),
            ),

            // Status timeline
            SliverToBoxAdapter(
              child: _buildStatusTimeline(need),
            ),

            // Help offers section
            if (need.helpOffers.isNotEmpty)
              SliverToBoxAdapter(
                child: _buildHelpOffersSection(need),
              ),

            // Updates section
            SliverToBoxAdapter(
              child: _buildUpdatesSection(need, isOwner),
            ),

            // Add update section (for owner)
            if (isOwner && need.status != NeedStatus.completed && need.status != NeedStatus.cancelled)
              SliverToBoxAdapter(
                child: _buildAddUpdateSection(),
              ),

            // Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      bottomNavigationBar: canHelp ? _buildActionBar(need) : null,
    );
  }

  Widget _buildNeedHeader(Need need) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status and category badges
            Row(
              children: [
                _buildStatusChip(need.status),
                const SizedBox(width: 8),
                if (need.category.isNotEmpty)
                  Chip(
                    label: Text(need.category),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                const Spacer(),
                _buildUrgencyChip(need.urgency),
              ],
            ),

            const SizedBox(height: 16),

            // Title and description
            Text(
              need.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              need.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 16),

            // Metadata
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  need.requesterName,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  timeago.format(need.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            // Location if available
            if (need.location.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      need.location,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],

            // Images if available
            if (need.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: need.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          need.imageUrls[index],
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 120,
                            height: 120,
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(Need need) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress Timeline',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Status steps
              Column(
                children: [
                  _buildTimelineItem(
                    'Need Created',
                    need.createdAt,
                    Icons.add_circle,
                    true,
                    isCompleted: true,
                  ),
                  _buildTimelineItem(
                    'Help Offered',
                    need.helpOffers.isNotEmpty ? need.helpOffers.first.createdAt : null,
                    Icons.volunteer_activism,
                    need.helpOffers.isNotEmpty,
                    isCompleted: need.helpOffers.isNotEmpty,
                  ),
                  _buildTimelineItem(
                    'In Progress',
                    need.status == NeedStatus.inProgress ? need.updatedAt : null,
                    Icons.hourglass_empty,
                    need.status == NeedStatus.inProgress || need.status == NeedStatus.completed,
                    isCompleted: need.status == NeedStatus.inProgress || need.status == NeedStatus.completed,
                  ),
                  _buildTimelineItem(
                    'Completed',
                    need.status == NeedStatus.completed ? need.updatedAt : null,
                    Icons.check_circle,
                    need.status == NeedStatus.completed,
                    isCompleted: need.status == NeedStatus.completed,
                    isLast: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
    String title,
    DateTime? timestamp,
    IconData icon,
    bool isActive,
    {required bool isCompleted, bool isLast = false}
  ) {
    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: isCompleted 
                  ? Colors.green 
                  : isActive 
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceVariant,
              child: Icon(
                icon,
                size: 16,
                color: isCompleted || isActive ? Colors.white : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted 
                    ? Colors.green 
                    : Theme.of(context).colorScheme.surfaceVariant,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isActive ? FontWeight.bold : null,
                ),
              ),
              if (timestamp != null)
                Text(
                  timeago.format(timestamp),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHelpOffersSection(Need need) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help Offers (${need.helpOffers.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: need.helpOffers.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final offer = need.helpOffers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(offer.helperName[0].toUpperCase()),
                    ),
                    title: Text(offer.helperName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (offer.message.isNotEmpty)
                          Text(offer.message),
                        const SizedBox(height: 4),
                        Text(
                          timeago.format(offer.createdAt),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: need.requesterId == ref.read(authStateProvider).user?.id
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chat),
                                onPressed: () => _startChat(offer.helperId),
                              ),
                              IconButton(
                                icon: const Icon(Icons.check),
                                onPressed: () => _acceptOffer(offer),
                              ),
                            ],
                          )
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdatesSection(Need need, bool isOwner) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Updates',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              if (need.updates.isEmpty)
                Text(
                  'No updates yet.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: need.updates.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final update = need.updates[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          update.type == 'status_change' 
                              ? Icons.info 
                              : Icons.chat_bubble,
                        ),
                      ),
                      title: Text(update.message),
                      subtitle: Text(timeago.format(update.createdAt)),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddUpdateSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Update',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              TextField(
                controller: _updateController,
                decoration: const InputDecoration(
                  hintText: 'Share an update with your helpers...',
                ),
                maxLines: 3,
              ),
              
              const SizedBox(height: 12),
              
              ElevatedButton(
                onPressed: _isSubmittingUpdate ? null : _addUpdate,
                child: _isSubmittingUpdate
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Post Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionBar(Need need) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _offerHelp(need),
              icon: const Icon(Icons.volunteer_activism),
              label: const Text('Offer Help'),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton.icon(
            onPressed: () => _startChat(need.requesterId),
            icon: const Icon(Icons.chat),
            label: const Text('Message'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(NeedStatus status) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (status) {
      case NeedStatus.open:
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        icon = Icons.circle;
        break;
      case NeedStatus.inProgress:
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        icon = Icons.hourglass_empty;
        break;
      case NeedStatus.completed:
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        icon = Icons.check_circle;
        break;
      case NeedStatus.cancelled:
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            status.name.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrgencyChip(NeedUrgency urgency) {
    Color color;
    switch (urgency) {
      case NeedUrgency.low:
        color = Colors.green;
        break;
      case NeedUrgency.medium:
        color = Colors.orange;
        break;
      case NeedUrgency.high:
        color = Colors.red;
        break;
      case NeedUrgency.critical:
        color = Colors.purple;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.priority_high, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            urgency.name.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(NeedStatus status) {
    switch (status) {
      case NeedStatus.draft:
        return Colors.grey;
      case NeedStatus.pending:
        return Colors.orange;
      case NeedStatus.active:
        return Colors.green;
      case NeedStatus.inProgress:
        return Colors.blue;
      case NeedStatus.completed:
        return Colors.purple;
      case NeedStatus.cancelled:
        return Colors.red;
      case NeedStatus.expired:
        return Colors.grey;
    }
  }

  void _handleMenuAction(String action, Need need) {
    switch (action) {
      case 'edit':
        _editNeed(need);
        break;
      case 'mark_complete':
        _markComplete(need);
        break;
      case 'cancel':
        _cancelNeed(need);
        break;
      case 'delete':
        _deleteNeed(need);
        break;
    }
  }

  void _editNeed(Need need) {
    // TODO: Navigate to edit need screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit functionality coming soon!')),
    );
  }

  void _markComplete(Need need) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark as Complete'),
        content: const Text('Are you sure this need has been fulfilled?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(needsStateProvider.notifier).updateNeedStatus(
                need.id,
                NeedStatus.completed,
              );
            },
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }

  void _cancelNeed(Need need) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Need'),
        content: const Text('Are you sure you want to cancel this need?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(needsStateProvider.notifier).updateNeedStatus(
                need.id,
                NeedStatus.cancelled,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Cancel Need'),
          ),
        ],
      ),
    );
  }

  void _deleteNeed(Need need) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Need'),
        content: const Text('This action cannot be undone. Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(needsStateProvider.notifier).deleteNeed(need.id);
              context.go('/home');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _offerHelp(Need need) {
    showDialog(
      context: context,
      builder: (context) {
        final messageController = TextEditingController();
        return AlertDialog(
          title: const Text('Offer Help'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Offer to help with "${need.title}"'),
              const SizedBox(height: 16),
              TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  labelText: 'Message (optional)',
                  hintText: 'How can you help?',
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
                Navigator.of(context).pop();
                ref.read(needsStateProvider.notifier).offerHelp(
                  need.id,
                  messageController.text,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Help offer sent!')),
                );
              },
              child: const Text('Send Offer'),
            ),
          ],
        );
      },
    );
  }

  void _startChat(String userId) {
    ref.read(chatStateProvider.notifier).createOrGetDirectChat(userId);
    context.push('/chat/room/$userId');
  }

  void _acceptOffer(HelpOffer offer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accept Help Offer'),
        content: Text('Accept help from ${offer.helperName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(needsStateProvider.notifier).acceptHelpOffer(
                widget.needId,
                offer.id,
              );
            },
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }

  Future<void> _addUpdate() async {
    if (_updateController.text.trim().isEmpty) return;

    setState(() {
      _isSubmittingUpdate = true;
    });

    try {
      await ref.read(needsStateProvider.notifier).addNeedUpdate(
        widget.needId,
        _updateController.text.trim(),
      );
      
      _updateController.clear();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Update posted!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error posting update: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmittingUpdate = false;
        });
      }
    }
  }

  void _shareNeed(Need need) {
    // TODO: Implement need sharing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing feature coming soon!')),
    );
  }
} 