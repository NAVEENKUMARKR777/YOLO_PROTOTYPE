import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:audioplayers/audioplayers.dart';

class AzureSpeechService {
  static const String _endpoint = 'https://your-speech-resource.cognitiveservices.azure.com';
  static const String _apiKey = 'your-api-key'; // In production, get this securely
  
  // Speech API endpoints
  static const String _speechToTextEndpoint = '/speechtotext/v3.0/recognize';
  static const String _textToSpeechEndpoint = '/tts/v1';
  static const String _translationEndpoint = '/translator/text/batch/v1.0';
  
  final stt.SpeechToText _speechToText = stt.SpeechToText.instance;
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  bool _isInitialized = false;
  bool _isListening = false;
  
  // Initialize speech service
  Future<void> initialize() async {
    try {
      final available = await _speechToText.initialize(
        onError: (error) => print('Speech recognition error: $error'),
        onStatus: (status) => print('Speech recognition status: $status'),
      );
      
      if (available) {
        _isInitialized = true;
        print('Speech recognition initialized successfully');
      } else {
        throw Exception('Speech recognition not available');
      }
    } catch (e) {
      throw Exception('Failed to initialize speech recognition: $e');
    }
  }

  // Start listening for voice input
  Future<void> startListening({
    required Function(String text) onResult,
    required Function(String error) onError,
    String? languageCode,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (_isListening) {
      await stopListening();
    }

    try {
      _isListening = true;
      
      await _speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
            _isListening = false;
          }
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: languageCode ?? 'en_US',
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    } catch (e) {
      _isListening = false;
      onError('Failed to start listening: $e');
    }
  }

  // Stop listening
  Future<void> stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      _isListening = false;
    }
  }

  // Check if currently listening
  bool get isListening => _isListening;

  // Convert speech to text using Azure Speech Service
  Future<String> convertSpeechToText(File audioFile) async {
    try {
      final bytes = await audioFile.readAsBytes();

      final response = await http.post(
        Uri.parse('$_endpoint$_speechToTextEndpoint'),
        headers: {
          'Ocp-Apim-Subscription-Key': _apiKey,
          'Content-Type': 'audio/wav',
          'Accept': 'application/json',
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['DisplayText'] ?? '';
      } else {
        throw Exception('Failed to convert speech to text: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error converting speech to text: $e');
    }
  }

  // Convert text to speech using Azure Speech Service
  Future<Uint8List> convertTextToSpeech({
    required String text,
    String voice = 'en-US-JennyNeural',
    String language = 'en-US',
  }) async {
    try {
      final ssml = '''
        <speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="$language">
          <voice name="$voice">
            $text
          </voice>
        </speak>
      ''';

      final response = await http.post(
        Uri.parse('$_endpoint$_textToSpeechEndpoint'),
        headers: {
          'Ocp-Apim-Subscription-Key': _apiKey,
          'Content-Type': 'application/ssml+xml',
          'X-Microsoft-OutputFormat': 'audio-16khz-128kbitrate-mono-mp3',
        },
        body: ssml,
      );

      if (response.statusCode == 200) {
        return Uint8List.fromList(response.bodyBytes);
      } else {
        throw Exception('Failed to convert text to speech: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error converting text to speech: $e');
    }
  }

  // Play synthesized speech
  Future<void> playTextToSpeech({
    required String text,
    String voice = 'en-US-JennyNeural',
    String language = 'en-US',
  }) async {
    try {
      final audioData = await convertTextToSpeech(
        text: text,
        voice: voice,
        language: language,
      );

      // Save to temporary file
      final tempFile = File('${Directory.systemTemp.path}/tts_${DateTime.now().millisecondsSinceEpoch}.mp3');
      await tempFile.writeAsBytes(audioData);

      // Play the audio
      await _audioPlayer.play(DeviceFileSource(tempFile.path));
    } catch (e) {
      throw Exception('Error playing text to speech: $e');
    }
  }

  // Translate speech in real-time
  Future<String> translateSpeech({
    required File audioFile,
    required String fromLanguage,
    required String toLanguage,
  }) async {
    try {
      final bytes = await audioFile.readAsBytes();

      final response = await http.post(
        Uri.parse('$_endpoint$_translationEndpoint'),
        headers: {
          'Ocp-Apim-Subscription-Key': _apiKey,
          'Content-Type': 'audio/wav',
          'Accept': 'application/json',
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['translations']?.first?['text'] ?? '';
      } else {
        throw Exception('Failed to translate speech: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error translating speech: $e');
    }
  }

  // Get available voices
  Future<List<VoiceInfo>> getAvailableVoices() async {
    try {
      final response = await http.get(
        Uri.parse('$_endpoint/tts/v1/voices'),
        headers: {
          'Ocp-Apim-Subscription-Key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data as List).map((voice) => VoiceInfo.fromJson(voice)).toList();
      } else {
        throw Exception('Failed to get available voices: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting available voices: $e');
    }
  }

  // Get available languages for speech recognition
  Future<List<LanguageInfo>> getAvailableLanguages() async {
    try {
      final response = await http.get(
        Uri.parse('$_endpoint/speechtotext/v3.0/languages'),
        headers: {
          'Ocp-Apim-Subscription-Key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data as List).map((lang) => LanguageInfo.fromJson(lang)).toList();
      } else {
        throw Exception('Failed to get available languages: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting available languages: $e');
    }
  }

  // Analyze speech sentiment
  Future<SentimentAnalysisResult> analyzeSpeechSentiment(File audioFile) async {
    try {
      final bytes = await audioFile.readAsBytes();

      final response = await http.post(
        Uri.parse('$_endpoint/speechtotext/v3.0/recognize?sentiment=true'),
        headers: {
          'Ocp-Apim-Subscription-Key': _apiKey,
          'Content-Type': 'audio/wav',
          'Accept': 'application/json',
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SentimentAnalysisResult.fromJson(data);
      } else {
        throw Exception('Failed to analyze speech sentiment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error analyzing speech sentiment: $e');
    }
  }

  // Detect language from speech
  Future<String> detectLanguageFromSpeech(File audioFile) async {
    try {
      final bytes = await audioFile.readAsBytes();

      final response = await http.post(
        Uri.parse('$_endpoint/speechtotext/v3.0/recognize?languageDetection=true'),
        headers: {
          'Ocp-Apim-Subscription-Key': _apiKey,
          'Content-Type': 'audio/wav',
          'Accept': 'application/json',
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['language'] ?? 'en-US';
      } else {
        throw Exception('Failed to detect language: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error detecting language: $e');
    }
  }

  // Create custom speech model
  Future<void> createCustomSpeechModel({
    required String modelName,
    required String description,
    required String baseModel,
    required List<String> trainingDataUrls,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_endpoint/speechtotext/v3.0/models'),
        headers: {
          'Ocp-Apim-Subscription-Key': _apiKey,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'modelName': modelName,
          'description': description,
          'baseModel': baseModel,
          'trainingDataUrls': trainingDataUrls,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create custom speech model: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating custom speech model: $e');
    }
  }

  // Get speech recognition confidence
  double getRecognitionConfidence() {
    // This would typically come from the speech recognition result
    // For now, returning a default value
    return 0.85;
  }

  // Check if speech recognition is available
  bool get isAvailable => _isInitialized;

  // Dispose resources
  void dispose() {
    _audioPlayer.dispose();
  }
}

// Supporting classes
class VoiceInfo {
  final String name;
  final String locale;
  final String gender;
  final String style;
  final String sampleRateHertz;

  VoiceInfo({
    required this.name,
    required this.locale,
    required this.gender,
    required this.style,
    required this.sampleRateHertz,
  });

  factory VoiceInfo.fromJson(Map<String, dynamic> json) {
    return VoiceInfo(
      name: json['Name'] ?? '',
      locale: json['Locale'] ?? '',
      gender: json['Gender'] ?? '',
      style: json['Style'] ?? '',
      sampleRateHertz: json['SampleRateHertz'] ?? '',
    );
  }
}

class LanguageInfo {
  final String language;
  final String locale;
  final String name;

  LanguageInfo({
    required this.language,
    required this.locale,
    required this.name,
  });

  factory LanguageInfo.fromJson(Map<String, dynamic> json) {
    return LanguageInfo(
      language: json['language'] ?? '',
      locale: json['locale'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class SentimentAnalysisResult {
  final String text;
  final String sentiment;
  final double positiveScore;
  final double neutralScore;
  final double negativeScore;

  SentimentAnalysisResult({
    required this.text,
    required this.sentiment,
    required this.positiveScore,
    required this.neutralScore,
    required this.negativeScore,
  });

  factory SentimentAnalysisResult.fromJson(Map<String, dynamic> json) {
    return SentimentAnalysisResult(
      text: json['text'] ?? '',
      sentiment: json['sentiment'] ?? '',
      positiveScore: json['positiveScore']?.toDouble() ?? 0.0,
      neutralScore: json['neutralScore']?.toDouble() ?? 0.0,
      negativeScore: json['negativeScore']?.toDouble() ?? 0.0,
    );
  }
} 