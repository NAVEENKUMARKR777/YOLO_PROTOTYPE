import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/assets_constants.dart';
import '../utils/asset_loader.dart';

/// Demo widget showing how to use different types of assets
class AssetDemoWidget extends ConsumerWidget {
  const AssetDemoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () => _playDemoAudio(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Images'),
            _buildImageSection(context),
            
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Icons'),
            _buildIconSection(context),
            
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Animations'),
            _buildAnimationSection(context),
            
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Audio Controls'),
            _buildAudioSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // App Logo
            _buildAssetItem(
              context,
              'App Logo',
              AssetLoader.loadImage(
                AssetsConstants.appLogo,
                width: 80,
                height: 80,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Placeholder Avatar
            _buildAssetItem(
              context,
              'User Avatar',
              AssetLoader.loadImage(
                AssetsConstants.placeholderAvatar,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Community Hero
            _buildAssetItem(
              context,
              'Community Hero',
              AssetLoader.loadImage(
                AssetsConstants.communityHero,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildIconItem(
              context,
              'YOLO Warrior',
              AssetsConstants.yoloWarriorIcon,
              Colors.orange,
            ),
            _buildIconItem(
              context,
              'Need Capture',
              AssetsConstants.needCaptureIcon,
              Colors.blue,
            ),
            _buildIconItem(
              context,
              'Community Help',
              AssetsConstants.communityHelpIcon,
              Colors.green,
            ),
            _buildIconItem(
              context,
              'AI Chat',
              AssetsConstants.aiChatIcon,
              Colors.purple,
            ),
            _buildIconItem(
              context,
              'Badge',
              AssetsConstants.badgeAchievementIcon,
              Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAnimationItem(
              context,
              'Loading Animation',
              AssetsConstants.loadingAnimation,
            ),
            
            const SizedBox(height: 16),
            
            _buildAnimationItem(
              context,
              'Success Animation',
              AssetsConstants.successAnimation,
            ),
            
            const SizedBox(height: 16),
            
            _buildAnimationItem(
              context,
              'Celebration Animation',
              AssetsConstants.celebrationAnimation,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAudioButton(
              context,
              'Play Notification Sound',
              AssetsConstants.notificationSound,
            ),
            
            const SizedBox(height: 8),
            
            _buildAudioButton(
              context,
              'Play Achievement Sound',
              AssetsConstants.achievementSound,
            ),
            
            const SizedBox(height: 8),
            
            _buildAudioButton(
              context,
              'Play Voice Input Sound',
              AssetsConstants.voiceInputStartSound,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetItem(BuildContext context, String label, Widget asset) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        asset,
      ],
    );
  }

  Widget _buildIconItem(
    BuildContext context,
    String label,
    String iconPath,
    Color color,
  ) {
    return Column(
      children: [
        AssetLoader.loadSvgIcon(
          iconPath,
          width: 48,
          height: 48,
          color: color,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAnimationItem(
    BuildContext context,
    String label,
    String animationPath,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: AssetLoader.loadLottieAnimation(
            animationPath,
            width: 100,
            height: 100,
            repeat: true,
          ),
        ),
      ],
    );
  }

  Widget _buildAudioButton(
    BuildContext context,
    String label,
    String audioPath,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => AssetLoader.playAudio(audioPath),
        icon: const Icon(Icons.play_arrow),
        label: Text(label),
      ),
    );
  }

  void _playDemoAudio(BuildContext context) {
    // Play a sequence of audio files
    AssetLoader.playAudio(AssetsConstants.notificationSound);
    
    Future.delayed(const Duration(milliseconds: 500), () {
      AssetLoader.playAudio(AssetsConstants.achievementSound);
    });
    
    Future.delayed(const Duration(milliseconds: 1000), () {
      AssetLoader.playAudio(AssetsConstants.voiceInputStartSound);
    });
  }
} 