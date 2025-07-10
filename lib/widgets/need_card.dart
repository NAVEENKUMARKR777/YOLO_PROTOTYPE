import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/need_model.dart';
import '../models/enums.dart';

class NeedCard extends StatelessWidget {
  final Need need;
  final VoidCallback? onTap;
  final bool showActions;
  final VoidCallback? onHelp;
  final VoidCallback? onShare;

  const NeedCard({
    super.key,
    required this.need,
    this.onTap,
    this.showActions = false,
    this.onHelp,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image if available
            if (need.imageUrls.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  need.imageUrls.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status badge and category
                  Row(
                    children: [
                      _buildStatusChip(context),
                      const Spacer(),
                      if (need.category.isNotEmpty)
                        Chip(
                          label: Text(
                            need.category,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    need.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    need.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),

                  // Metadata row
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timeago.format(need.createdAt),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                      if (need.urgency != NeedUrgency.low)
                        Row(
                          children: [
                            Icon(
                              Icons.priority_high,
                              size: 16,
                              color: _getUrgencyColor(need.urgency),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              need.urgency.name.toUpperCase(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: _getUrgencyColor(need.urgency),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Action buttons
                  if (showActions) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (need.status == NeedStatus.open) ...[
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: onHelp,
                              icon: const Icon(Icons.volunteer_activism, size: 18),
                              label: const Text('Help'),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        OutlinedButton.icon(
                          onPressed: onShare,
                          icon: const Icon(Icons.share, size: 18),
                          label: const Text('Share'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (need.status) {
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
            need.status.name.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getUrgencyColor(NeedUrgency urgency) {
    switch (urgency) {
      case NeedUrgency.low:
        return Colors.green;
      case NeedUrgency.medium:
        return Colors.orange;
      case NeedUrgency.high:
        return Colors.red;
      case NeedUrgency.critical:
        return Colors.purple;
    }
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
} 