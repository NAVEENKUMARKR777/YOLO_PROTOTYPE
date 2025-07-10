import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'assets_constants.dart';

/// Utility class for loading and managing assets in the YOLO Need App
class AssetLoader {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  /// Load an image asset
  static Image loadImage(String assetPath, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Color? color,
  }) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.image_not_supported),
        );
      },
    );
  }

  /// Load an SVG icon
  static Widget loadSvgIcon(String assetPath, {
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  /// Load a Lottie animation
  static Widget loadLottieAnimation(String assetPath, {
    double? width,
    double? height,
    bool repeat = true,
    bool autoplay = true,
  }) {
    return Lottie.asset(
      assetPath,
      width: width,
      height: height,
      repeat: repeat,
    );
  }

  /// Play an audio asset
  static Future<void> playAudio(String assetPath) async {
    try {
      await _audioPlayer.play(AssetSource(assetPath));
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }

  /// Stop audio playback
  static Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
  }

  /// Load a font asset
  static Future<FontLoader> loadFont(String fontFamily, List<String> fontPaths) async {
    final fontLoader = FontLoader(fontFamily);
    for (final path in fontPaths) {
      fontLoader.addFont(rootBundle.load(path));
    }
    await fontLoader.load();
    return fontLoader;
  }

  /// Preload all assets for better performance
  static Future<void> preloadAssets() async {
    try {
      // Preload images
      for (final imagePath in AssetsConstants.allImages) {
        // Note: precacheImage requires a BuildContext, so this should be called from a widget
        debugPrint('Asset preload requested: $imagePath');
      }

      // Preload audio files
      for (final audioPath in AssetsConstants.allAudio) {
        await _audioPlayer.setSource(AssetSource(audioPath));
      }

      debugPrint('Assets preloaded successfully');
    } catch (e) {
      debugPrint('Error preloading assets: $e');
    }
  }

  /// Get asset path based on theme (for dark/light mode specific assets)
  static String getThemedAssetPath(String basePath, bool isDarkMode) {
    final extension = basePath.split('.').last;
    final nameWithoutExtension = basePath.substring(0, basePath.lastIndexOf('.'));
    
    if (isDarkMode) {
      final darkPath = '${nameWithoutExtension}_dark.$extension';
      return darkPath;
    }
    
    return basePath;
  }

  /// Validate if an asset exists
  static Future<bool> assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get asset size information
  static Future<Size?> getAssetSize(String assetPath) async {
    try {
      final data = await rootBundle.load(assetPath);
      // Note: instantiateImageCodec is not available in this context
      // This would need to be implemented differently for image size detection
      debugPrint('Asset size detection requested: $assetPath');
      return null;
    } catch (e) {
      debugPrint('Error getting asset size: $e');
      return null;
    }
  }
}

/// Extension for easier asset loading
extension AssetLoaderExtension on BuildContext {
  /// Load an image asset with context
  Widget loadImage(String assetPath, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Color? color,
  }) {
    return AssetLoader.loadImage(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  /// Load an SVG icon with context
  Widget loadSvgIcon(String assetPath, {
    double? width,
    double? height,
    Color? color,
  }) {
    return AssetLoader.loadSvgIcon(
      assetPath,
      width: width,
      height: height,
      color: color,
    );
  }

  /// Load a Lottie animation with context
  Widget loadLottieAnimation(String assetPath, {
    double? width,
    double? height,
    bool repeat = true,
    bool autoplay = true,
  }) {
    return AssetLoader.loadLottieAnimation(
      assetPath,
      width: width,
      height: height,
      repeat: repeat,
    );
  }
} 