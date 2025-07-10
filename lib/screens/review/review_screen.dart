import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../models/user.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  final String helperId;
  final String needId;
  final String? existingReviewId;

  const ReviewScreen({
    super.key,
    required this.helperId,
    required this.needId,
    this.existingReviewId,
  });

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reviewController = TextEditingController();
  
  int _overallRating = 0;
  int _communicationRating = 0;
  int _reliabilityRating = 0;
  int _qualityRating = 0;
  bool _wouldRecommend = true;
  bool _isSubmitting = false;

  final List<String> _selectedTags = [];
  final List<String> _availableTags = [
    'Helpful',
    'Professional',
    'Punctual',
    'Friendly',
    'Knowledgeable',
    'Patient',
    'Reliable',
    'Quick Response',
    'Goes Above & Beyond',
    'Great Communication',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingReviewId != null) {
      _loadExistingReview();
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _loadExistingReview() {
    // TODO: Load existing review data
    // This would populate the form fields with existing review data
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final isEditing = widget.existingReviewId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Review' : 'Leave a Review'),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteReview,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Helper info card
              _buildHelperInfoCard(),
              
              const SizedBox(height: 24),

              // Overall rating
              _buildOverallRating(),
              
              const SizedBox(height: 24),

              // Detailed ratings
              _buildDetailedRatings(),
              
              const SizedBox(height: 24),

              // Review text
              _buildReviewText(),
              
              const SizedBox(height: 24),

              // Tags selection
              _buildTagsSelection(),
              
              const SizedBox(height: 24),

              // Recommendation
              _buildRecommendation(),
              
              const SizedBox(height: 24),

              // Privacy notice
              _buildPrivacyNotice(),
              
              const SizedBox(height: 32),

              // Submit button
              _buildSubmitButton(isEditing),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelperInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text('H'), // TODO: Replace with actual helper info
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Helper Name', // TODO: Replace with actual helper name
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.volunteer_activism,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Community Helper',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '4.8 (23 reviews)', // TODO: Replace with actual rating
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overall Rating',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'How would you rate your overall experience?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => _overallRating = index + 1),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  index < _overallRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 40,
                ),
              ),
            );
          }),
        ),
        if (_overallRating > 0)
          Center(
            child: Text(
              _getRatingText(_overallRating),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: _getRatingColor(_overallRating),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailedRatings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Ratings',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildRatingRow('Communication', _communicationRating, (rating) {
          setState(() => _communicationRating = rating);
        }),
        
        const SizedBox(height: 12),
        
        _buildRatingRow('Reliability', _reliabilityRating, (rating) {
          setState(() => _reliabilityRating = rating);
        }),
        
        const SizedBox(height: 12),
        
        _buildRatingRow('Quality of Help', _qualityRating, (rating) {
          setState(() => _qualityRating = rating);
        }),
      ],
    );
  }

  Widget _buildRatingRow(String label, int rating, Function(int) onRatingChanged) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => onRatingChanged(index + 1),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 24,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Review',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Share your experience to help others in the community',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _reviewController,
          decoration: const InputDecoration(
            hintText: 'Describe your experience...',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
          maxLength: 500,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please share your experience';
            }
            if (value.trim().length < 10) {
              return 'Review must be at least 10 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTagsSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags (Optional)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Select tags that describe this helper',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _availableTags.map((tag) {
            final isSelected = _selectedTags.contains(tag);
            return FilterChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTags.add(tag);
                  } else {
                    _selectedTags.remove(tag);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecommendation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendation',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(
              Icons.thumb_up,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Would you recommend this helper to others?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Switch(
              value: _wouldRecommend,
              onChanged: (value) => setState(() => _wouldRecommend = value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrivacyNotice() {
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'Privacy Notice',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Your review will be visible to other community members and will help them make informed decisions. '
              'You can edit or delete your review anytime from your profile.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(bool isEditing) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _overallRating > 0 && !_isSubmitting ? _submitReview : null,
        child: _isSubmitting
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(isEditing ? 'Update Review' : 'Submit Review'),
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }

  Color _getRatingColor(int rating) {
    if (rating <= 2) return Colors.red;
    if (rating == 3) return Colors.orange;
    return Colors.green;
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      // TODO: Submit review to backend
      final reviewData = {
        'helperId': widget.helperId,
        'needId': widget.needId,
        'overallRating': _overallRating,
        'communicationRating': _communicationRating,
        'reliabilityRating': _reliabilityRating,
        'qualityRating': _qualityRating,
        'reviewText': _reviewController.text.trim(),
        'tags': _selectedTags,
        'wouldRecommend': _wouldRecommend,
      };

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.existingReviewId != null 
                ? 'Review updated successfully!' 
                : 'Review submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting review: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _deleteReview() {
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
              // TODO: Delete review
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Review deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              context.pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
} 