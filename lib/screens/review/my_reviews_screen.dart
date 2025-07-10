import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../providers/auth_provider.dart';
import '../../models/user.dart';

class MyReviewsScreen extends ConsumerStatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  ConsumerState<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends ConsumerState<MyReviewsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Sample data - in real app, this would come from state management
  final List<Map<String, dynamic>> _reviewsGiven = [
    {
      'id': '1',
      'helperName': 'John Helper',
      'helperId': 'helper1',
      'needTitle': 'Help with grocery shopping',
      'needId': 'need1',
      'overallRating': 5,
      'reviewText': 'John was incredibly helpful with my grocery shopping. He was prompt, communicative, and even helped me carry the bags to my apartment. Highly recommend!',
      'tags': ['Helpful', 'Professional', 'Punctual'],
      'wouldRecommend': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
      'canEdit': true,
    },
    {
      'id': '2',
      'helperName': 'Sarah Volunteer',
      'helperId': 'helper2',
      'needTitle': 'Moving assistance',
      'needId': 'need2',
      'overallRating': 4,
      'reviewText': 'Great help with moving some furniture. Sarah arrived on time and was very careful with my items.',
      'tags': ['Reliable', 'Professional'],
      'wouldRecommend': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 10)),
      'canEdit': true,
    },
  ];

  final List<Map<String, dynamic>> _reviewsReceived = [
    {
      'id': '1',
      'reviewerName': 'Mike R.',
      'reviewerId': 'user1',
      'needTitle': 'Tech support for laptop',
      'needId': 'need3',
      'overallRating': 5,
      'reviewText': 'Amazing help with my laptop issues. Very knowledgeable and patient. Solved the problem quickly!',
      'tags': ['Knowledgeable', 'Patient', 'Great Communication'],
      'wouldRecommend': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '2',
      'reviewerName': 'Lisa K.',
      'reviewerId': 'user2',
      'needTitle': 'Help with cooking',
      'needId': 'need4',
      'overallRating': 4,
      'reviewText': 'Great cooking assistance. Very helpful and friendly. Would recommend!',
      'tags': ['Friendly', 'Helpful'],
      'wouldRecommend': true,
      'createdAt': DateTime.now().subtract(const Duration(days: 5)),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reviews'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.rate_review),
                  const SizedBox(width: 8),
                  Text('Given (${_reviewsGiven.length})'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star),
                  const SizedBox(width: 8),
                  Text('Received (${_reviewsReceived.length})'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildReviewsGivenTab(),
          _buildReviewsReceivedTab(),
        ],
      ),
    );
  }

  Widget _buildReviewsGivenTab() {
    if (_reviewsGiven.isEmpty) {
      return _buildEmptyState(
        'No Reviews Given',
        'You haven\'t given any reviews yet. When you receive help from others, you\'ll be able to leave reviews here.',
        Icons.rate_review,
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshReviewsGiven,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _reviewsGiven.length,
        itemBuilder: (context, index) {
          final review = _reviewsGiven[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildReviewGivenCard(review),
          );
        },
      ),
    );
  }

  Widget _buildReviewsReceivedTab() {
    if (_reviewsReceived.isEmpty) {
      return _buildEmptyState(
        'No Reviews Received',
        'You haven\'t received any reviews yet. Start helping others to earn reviews and build your reputation!',
        Icons.star,
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshReviewsReceived,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _reviewsReceived.length,
        itemBuilder: (context, index) {
          final review = _reviewsReceived[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildReviewReceivedCard(review),
          );
        },
      ),
    );
  }

  Widget _buildReviewGivenCard(Map<String, dynamic> review) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Helper info and rating
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(review['helperName'][0]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['helperName'],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        timeago.format(review['createdAt']),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review['overallRating'] ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Need title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Help with: ${review['needTitle']}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Review text
            Text(
              review['reviewText'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 12),

            // Tags
            if (review['tags'].isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: (review['tags'] as List<String>).map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tag,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 12),

            // Actions
            Row(
              children: [
                if (review['wouldRecommend'])
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Recommended',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                if (review['canEdit'])
                  TextButton(
                    onPressed: () => _editReview(review),
                    child: const Text('Edit'),
                  ),
                TextButton(
                  onPressed: () => _deleteReview(review),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewReceivedCard(Map<String, dynamic> review) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reviewer info and rating
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: Text(review['reviewerName'][0]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['reviewerName'],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        timeago.format(review['createdAt']),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review['overallRating'] ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Need title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Help with: ${review['needTitle']}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Review text
            Text(
              review['reviewText'],
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 12),

            // Tags
            if (review['tags'].isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: (review['tags'] as List<String>).map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tag,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  );
                }).toList(),
              ),

            const SizedBox(height: 12),

            // Actions
            Row(
              children: [
                if (review['wouldRecommend'])
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Recommended',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => _reportReview(review),
                  style: TextButton.styleFrom(foregroundColor: Colors.orange),
                  child: const Text('Report'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String message, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (_tabController.index == 0) // Reviews Given tab
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to needs timeline to find needs to review
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navigate to your needs to leave reviews')),
                  );
                },
                child: const Text('View My Needs'),
              ),
            if (_tabController.index == 1) // Reviews Received tab
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to community feed to help others
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Start helping others to earn reviews')),
                  );
                },
                child: const Text('Help Others'),
              ),
          ],
        ),
      ),
    );
  }

  void _editReview(Map<String, dynamic> review) {
    // Navigate to review screen with existing review data
    context.push('/review', extra: {
      'helperId': review['helperId'],
      'needId': review['needId'],
      'existingReviewId': review['id'],
    });
  }

  void _deleteReview(Map<String, dynamic> review) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Review'),
        content: const Text('Are you sure you want to delete this review? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Delete review from backend
              setState(() {
                _reviewsGiven.remove(review);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Review deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _reportReview(Map<String, dynamic> review) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Review'),
        content: const Text('Are you sure you want to report this review? It will be reviewed by our moderation team.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Report review to backend
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Review reported successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshReviewsGiven() async {
    // TODO: Refresh reviews given data
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _refreshReviewsReceived() async {
    // TODO: Refresh reviews received data
    await Future.delayed(const Duration(seconds: 1));
  }
} 