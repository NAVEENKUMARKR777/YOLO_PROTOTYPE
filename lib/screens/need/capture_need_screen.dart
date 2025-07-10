import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

import '../../providers/needs_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/need_model.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';

class CaptureNeedScreen extends ConsumerStatefulWidget {
  const CaptureNeedScreen({super.key});

  @override
  ConsumerState<CaptureNeedScreen> createState() => _CaptureNeedScreenState();
}

class _CaptureNeedScreenState extends ConsumerState<CaptureNeedScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _pageController = PageController();

  int _currentStep = 0;
  String _selectedCategory = '';
  NeedUrgency _selectedUrgency = NeedUrgency.medium;
  final List<XFile> _selectedImages = [];
  bool _isVoiceRecording = false;
  bool _isSubmitting = false;

  final List<String> _categories = [
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

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final needsState = ref.watch(needsStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Need'),
        actions: [
          if (_currentStep > 0)
            TextButton(
              onPressed: _previousStep,
              child: const Text('Back'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildBasicInfoStep(),
            _buildDetailsStep(),
            _buildMediaStep(),
            _buildReviewStep(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Progress indicator
            Expanded(
              child: LinearProgressIndicator(
                value: (_currentStep + 1) / 4,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
            const SizedBox(width: 16),
            
            // Action button
            ElevatedButton(
              onPressed: _isSubmitting ? null : _handleNextStep,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_currentStep == 3 ? 'Create Need' : 'Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell us about your need',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Provide a clear title and description to help others understand how they can help.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Title field
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title *',
              hintText: 'e.g., Need help with groceries',
              prefixIcon: Icon(Icons.title),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a title';
              }
              if (value.trim().length < 5) {
                return 'Title must be at least 5 characters';
              }
              return null;
            },
            textCapitalization: TextCapitalization.sentences,
          ),

          const SizedBox(height: 16),

          // Description field with AI suggestions
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description *',
              hintText: 'Describe your need in detail...',
              prefixIcon: const Icon(Icons.description),
              suffixIcon: IconButton(
                icon: const Icon(Icons.mic),
                onPressed: _toggleVoiceRecording,
                color: _isVoiceRecording ? Colors.red : null,
              ),
            ),
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a description';
              }
              if (value.trim().length < 20) {
                return 'Description must be at least 20 characters';
              }
              return null;
            },
            textCapitalization: TextCapitalization.sentences,
          ),

          if (_isVoiceRecording) ...[
            const SizedBox(height: 16),
            Card(
              color: Colors.red.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.mic, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Recording... Tap the mic icon again to stop',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 24),

          // AI suggestions
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AI Suggestions',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Be specific about:\n'
                    '• What exactly you need\n'
                    '• When you need it\n'
                    '• Your location or preferred area\n'
                    '• Any special requirements',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Details',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Help others find and prioritize your need with these details.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Category selection
          Text(
            'Category *',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((category) => FilterChip(
              label: Text(category),
              selected: _selectedCategory == category,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = selected ? category : '';
                });
              },
            )).toList(),
          ),

          const SizedBox(height: 24),

          // Urgency selection
          Text(
            'Urgency Level *',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: NeedUrgency.values.map((urgency) {
              return RadioListTile<NeedUrgency>(
                title: Text(_getUrgencyTitle(urgency)),
                subtitle: Text(_getUrgencyDescription(urgency)),
                value: urgency,
                groupValue: _selectedUrgency,
                onChanged: (value) {
                  setState(() {
                    _selectedUrgency = value!;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Location field
          TextFormField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'Location',
              hintText: 'City, neighborhood, or specific address',
              prefixIcon: const Icon(Icons.location_on),
              suffixIcon: IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: _getCurrentLocation,
              ),
            ),
            textCapitalization: TextCapitalization.words,
          ),
        ],
      ),
    );
  }

  Widget _buildMediaStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Photos (Optional)',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Photos help others understand your need better.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Image selection grid
          if (_selectedImages.isNotEmpty) ...[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(_selectedImages[index].path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red,
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 12),
                          color: Colors.white,
                          onPressed: () => _removeImage(index),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
          ],

          // Add photo buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Take Photo'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('From Gallery'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Barcode scanning
          OutlinedButton.icon(
            onPressed: _scanBarcode,
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Scan Barcode/QR Code'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
            ),
          ),

          const SizedBox(height: 24),

          // AI image analysis info
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AI Image Analysis',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Our AI will analyze your photos to:\n'
                    '• Extract text information\n'
                    '• Identify objects and items\n'
                    '• Suggest relevant categories\n'
                    '• Enhance your need description',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review Your Need',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please review your need before submitting.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Preview card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _titleController.text,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(_descriptionController.text),
                  const SizedBox(height: 16),

                  // Metadata
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (_selectedCategory.isNotEmpty)
                        Chip(
                          label: Text(_selectedCategory),
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      Chip(
                        label: Text(_getUrgencyTitle(_selectedUrgency)),
                        backgroundColor: _getUrgencyColor(_selectedUrgency).withOpacity(0.1),
                      ),
                      if (_locationController.text.isNotEmpty)
                        Chip(
                          icon: const Icon(Icons.location_on, size: 16),
                          label: Text(_locationController.text),
                        ),
                    ],
                  ),

                  // Images
                  if (_selectedImages.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Photos (${_selectedImages.length})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_selectedImages[index].path),
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
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
          ),

          const SizedBox(height: 24),

          // Terms and privacy
          Card(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Before you submit:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Your need will be visible to the community\n'
                    '• Others can offer to help and contact you\n'
                    '• You can edit or delete your need anytime\n'
                    '• Be respectful and provide accurate information',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNextStep() {
    if (_currentStep < 3) {
      if (_validateCurrentStep()) {
        _nextStep();
      }
    } else {
      _submitNeed();
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _formKey.currentState?.validate() ?? false;
      case 1:
        if (_selectedCategory.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a category')),
          );
          return false;
        }
        return true;
      case 2:
      case 3:
        return true;
      default:
        return false;
    }
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitNeed() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      final authState = ref.read(authStateProvider);
      if (authState.user == null) {
        throw Exception('User not authenticated');
      }

      // Create need object
      final need = Need(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        urgency: _selectedUrgency,
        location: _locationController.text.trim(),
        requesterId: authState.user!.id,
        requesterName: '${authState.user!.firstName} ${authState.user!.lastName}',
        status: NeedStatus.open,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        imageUrls: [], // Will be populated after image upload
        tags: _generateTags(),
        helpRequestsCount: 0,
      );

      // Submit need
      await ref.read(needsStateProvider.notifier).createNeed(need, _selectedImages);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Need created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating need: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  List<String> _generateTags() {
    final tags = <String>[];
    
    // Add category as tag
    if (_selectedCategory.isNotEmpty) {
      tags.add(_selectedCategory.toLowerCase());
    }
    
    // Add urgency as tag
    tags.add(_selectedUrgency.name);
    
    // Extract tags from title and description
    final text = '${_titleController.text} ${_descriptionController.text}'.toLowerCase();
    final words = text.split(RegExp(r'\W+'));
    
    // Add meaningful words as tags
    for (final word in words) {
      if (word.length > 3 && !tags.contains(word)) {
        tags.add(word);
      }
    }
    
    return tags.take(10).toList(); // Limit to 10 tags
  }

  String _getUrgencyTitle(NeedUrgency urgency) {
    switch (urgency) {
      case NeedUrgency.low:
        return 'Low - Can wait a few days';
      case NeedUrgency.medium:
        return 'Medium - Needed within 24 hours';
      case NeedUrgency.high:
        return 'High - Needed within a few hours';
      case NeedUrgency.critical:
        return 'Critical - Emergency situation';
    }
  }

  String _getUrgencyDescription(NeedUrgency urgency) {
    switch (urgency) {
      case NeedUrgency.low:
        return 'Not time-sensitive, flexible timing';
      case NeedUrgency.medium:
        return 'Moderately important, some flexibility';
      case NeedUrgency.high:
        return 'Important and time-sensitive';
      case NeedUrgency.critical:
        return 'Urgent emergency requiring immediate help';
    }
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

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: source);
      
      if (image != null) {
        setState(() {
          _selectedImages.add(image);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _toggleVoiceRecording() {
    setState(() {
      _isVoiceRecording = !_isVoiceRecording;
    });
    
    // TODO: Implement voice recording with Azure Speech-to-Text
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isVoiceRecording 
            ? 'Voice recording started' 
            : 'Voice recording stopped'),
      ),
    );
  }

  void _getCurrentLocation() {
    // TODO: Implement location detection
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location detection coming soon!')),
    );
  }

  void _scanBarcode() {
    // TODO: Implement barcode scanning with Azure Vision
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barcode scanning coming soon!')),
    );
  }
} 