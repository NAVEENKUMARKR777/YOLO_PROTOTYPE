import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import '../../models/need_model.dart';

class AzureVisionService {
  static const String _endpoint = 'https://your-vision-resource.cognitiveservices.azure.com';
  static const String _apiKey = 'your-api-key'; // In production, get this securely
  
  // Vision API endpoints
  static const String _analyzeEndpoint = '/vision/v3.2/analyze';
  static const String _ocrEndpoint = '/vision/v3.2/read/analyze';
  static const String _barcodeEndpoint = '/vision/v3.2/read/analyze';
  static const String _customVisionEndpoint = '/customvision/v3.0/Prediction/your-project-id/classify/iterations/your-iteration-id/image';

  // Analyze image and extract information
  Future<VisionAnalysisResult> analyzeImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse('$_endpoint$_analyzeEndpoint'),
        headers: {
          'Content-Type': 'application/octet-stream',
          'Ocp-Apim-Subscription-Key': _apiKey,
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return VisionAnalysisResult.fromJson(data);
      } else {
        throw Exception('Failed to analyze image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error analyzing image: $e');
    }
  }

  // Extract text from image (OCR)
  Future<OCRResult> extractTextFromImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();

      // Start OCR analysis
      final startResponse = await http.post(
        Uri.parse('$_endpoint$_ocrEndpoint'),
        headers: {
          'Content-Type': 'application/octet-stream',
          'Ocp-Apim-Subscription-Key': _apiKey,
        },
        body: bytes,
      );

      if (startResponse.statusCode == 202) {
        final operationLocation = startResponse.headers['operation-location'];
        if (operationLocation != null) {
          // Poll for results
          return await _pollOCRResults(operationLocation);
        }
      }

      throw Exception('Failed to start OCR: ${startResponse.statusCode}');
    } catch (e) {
      throw Exception('Error extracting text: $e');
    }
  }

  // Extract barcodes from image
  Future<List<BarcodeResult>> extractBarcodes(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();

      final response = await http.post(
        Uri.parse('$_endpoint$_barcodeEndpoint'),
        headers: {
          'Content-Type': 'application/octet-stream',
          'Ocp-Apim-Subscription-Key': _apiKey,
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _parseBarcodeResults(data);
      } else {
        throw Exception('Failed to extract barcodes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error extracting barcodes: $e');
    }
  }

  // Analyze image for need detection using Custom Vision
  Future<CustomVisionResult> analyzeNeedImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();

      final response = await http.post(
        Uri.parse('$_endpoint$_customVisionEndpoint'),
        headers: {
          'Content-Type': 'application/octet-stream',
          'Prediction-Key': _apiKey,
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CustomVisionResult.fromJson(data);
      } else {
        throw Exception('Failed to analyze need image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error analyzing need image: $e');
    }
  }

  // Detect objects in image
  Future<List<DetectedObject>> detectObjects(File imageFile) async {
    try {
      final analysis = await analyzeImage(imageFile);
      return analysis.objects ?? [];
    } catch (e) {
      throw Exception('Error detecting objects: $e');
    }
  }

  // Detect faces in image
  Future<List<DetectedFace>> detectFaces(File imageFile) async {
    try {
      final analysis = await analyzeImage(imageFile);
      return analysis.faces ?? [];
    } catch (e) {
      throw Exception('Error detecting faces: $e');
    }
  }

  // Generate image description
  Future<String> generateImageDescription(File imageFile) async {
    try {
      final analysis = await analyzeImage(imageFile);
      return analysis.description?.captions?.firstOrNull?.text ?? 'No description available';
    } catch (e) {
      throw Exception('Error generating description: $e');
    }
  }

  // Extract tags from image
  Future<List<String>> extractTags(File imageFile) async {
    try {
      final analysis = await analyzeImage(imageFile);
      return analysis.tags?.map((tag) => tag.name).toList() ?? [];
    } catch (e) {
      throw Exception('Error extracting tags: $e');
    }
  }

  // Analyze image for need categorization
  Future<NeedCategory> categorizeNeedFromImage(File imageFile) async {
    try {
      final customVisionResult = await analyzeNeedImage(imageFile);
      final tags = await extractTags(imageFile);
      
      // Combine Custom Vision and general analysis for better categorization
      return _determineNeedCategory(customVisionResult, tags);
    } catch (e) {
      throw Exception('Error categorizing need: $e');
    }
  }

  // Poll OCR results
  Future<OCRResult> _pollOCRResults(String operationLocation) async {
    int attempts = 0;
    const maxAttempts = 10;
    const delaySeconds = 1;

    while (attempts < maxAttempts) {
      await Future.delayed(Duration(seconds: delaySeconds));
      
      final response = await http.get(
        Uri.parse(operationLocation),
        headers: {
          'Ocp-Apim-Subscription-Key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['status'] == 'succeeded') {
          return OCRResult.fromJson(data);
        } else if (data['status'] == 'failed') {
          throw Exception('OCR analysis failed');
        }
        // Continue polling if status is 'running'
      }

      attempts++;
    }

    throw Exception('OCR analysis timed out');
  }

  // Parse barcode results
  List<BarcodeResult> _parseBarcodeResults(Map<String, dynamic> data) {
    final results = <BarcodeResult>[];
    
    if (data['readResult'] != null) {
      for (final result in data['readResult']) {
        if (result['lines'] != null) {
          for (final line in result['lines']) {
            if (line['text'] != null) {
              results.add(BarcodeResult(
                text: line['text'],
                confidence: line['confidence']?.toDouble() ?? 0.0,
                boundingBox: _parseBoundingBox(line['boundingBox']),
              ));
            }
          }
        }
      }
    }

    return results;
  }

  // Parse bounding box
  BoundingBox? _parseBoundingBox(List<dynamic>? boundingBox) {
    if (boundingBox == null || boundingBox.length != 4) return null;
    
    return BoundingBox(
      x: boundingBox[0].toDouble(),
      y: boundingBox[1].toDouble(),
      width: boundingBox[2].toDouble(),
      height: boundingBox[3].toDouble(),
    );
  }

  // Determine need category based on analysis
  NeedCategory _determineNeedCategory(CustomVisionResult customVisionResult, List<String> tags) {
    // Priority to Custom Vision predictions
    if (customVisionResult.predictions.isNotEmpty) {
      final topPrediction = customVisionResult.predictions.first;
      if (topPrediction.probability > 0.7) {
        return _mapPredictionToCategory(topPrediction.tagName);
      }
    }

    // Fallback to tag analysis
    for (final tag in tags) {
      final category = _mapTagToCategory(tag);
      if (category != NeedCategory.other) {
        return category;
      }
    }

    return NeedCategory.other;
  }

  // Map Custom Vision prediction to need category
  NeedCategory _mapPredictionToCategory(String tagName) {
    switch (tagName.toLowerCase()) {
      case 'food':
      case 'groceries':
      case 'meal':
        return NeedCategory.food;
      case 'transport':
      case 'transportation':
      case 'ride':
        return NeedCategory.transport;
      case 'healthcare':
      case 'medical':
      case 'medicine':
        return NeedCategory.healthcare;
      case 'housing':
      case 'shelter':
      case 'home':
        return NeedCategory.housing;
      case 'clothing':
      case 'clothes':
        return NeedCategory.clothing;
      case 'education':
      case 'learning':
        return NeedCategory.education;
      case 'technology':
      case 'tech':
        return NeedCategory.technology;
      default:
        return NeedCategory.other;
    }
  }

  // Map general tags to need category
  NeedCategory _mapTagToCategory(String tag) {
    switch (tag.toLowerCase()) {
      case 'food':
      case 'groceries':
      case 'meal':
      case 'restaurant':
        return NeedCategory.food;
      case 'transport':
      case 'transportation':
      case 'car':
      case 'bus':
      case 'train':
        return NeedCategory.transport;
      case 'healthcare':
      case 'medical':
      case 'medicine':
      case 'hospital':
        return NeedCategory.healthcare;
      case 'housing':
      case 'shelter':
      case 'home':
      case 'apartment':
        return NeedCategory.housing;
      case 'clothing':
      case 'clothes':
      case 'shirt':
      case 'pants':
        return NeedCategory.clothing;
      case 'education':
      case 'learning':
      case 'school':
      case 'book':
        return NeedCategory.education;
      case 'technology':
      case 'tech':
      case 'computer':
      case 'phone':
        return NeedCategory.technology;
      default:
        return NeedCategory.other;
    }
  }
}

// Result classes
class VisionAnalysisResult {
  final List<DetectedObject>? objects;
  final List<DetectedFace>? faces;
  final ImageDescription? description;
  final List<ImageTag>? tags;
  final List<DetectedBrand>? brands;
  final List<DetectedLandmark>? landmarks;

  VisionAnalysisResult({
    this.objects,
    this.faces,
    this.description,
    this.tags,
    this.brands,
    this.landmarks,
  });

  factory VisionAnalysisResult.fromJson(Map<String, dynamic> json) {
    return VisionAnalysisResult(
      objects: json['objects']?.map((obj) => DetectedObject.fromJson(obj)).toList(),
      faces: json['faces']?.map((face) => DetectedFace.fromJson(face)).toList(),
      description: json['description'] != null ? ImageDescription.fromJson(json['description']) : null,
      tags: json['tags']?.map((tag) => ImageTag.fromJson(tag)).toList(),
      brands: json['brands']?.map((brand) => DetectedBrand.fromJson(brand)).toList(),
      landmarks: json['landmarks']?.map((landmark) => DetectedLandmark.fromJson(landmark)).toList(),
    );
  }
}

class OCRResult {
  final List<TextLine> lines;
  final String fullText;

  OCRResult({
    required this.lines,
    required this.fullText,
  });

  factory OCRResult.fromJson(Map<String, dynamic> json) {
    final lines = <TextLine>[];
    String fullText = '';

    if (json['analyzeResult'] != null && json['analyzeResult']['readResults'] != null) {
      for (final readResult in json['analyzeResult']['readResults']) {
        if (readResult['lines'] != null) {
          for (final line in readResult['lines']) {
            final textLine = TextLine.fromJson(line);
            lines.add(textLine);
            fullText += '${textLine.text}\n';
          }
        }
      }
    }

    return OCRResult(
      lines: lines,
      fullText: fullText.trim(),
    );
  }
}

class BarcodeResult {
  final String text;
  final double confidence;
  final BoundingBox? boundingBox;

  BarcodeResult({
    required this.text,
    required this.confidence,
    this.boundingBox,
  });
}

class CustomVisionResult {
  final List<Prediction> predictions;
  final String projectId;
  final String iterationId;

  CustomVisionResult({
    required this.predictions,
    required this.projectId,
    required this.iterationId,
  });

  factory CustomVisionResult.fromJson(Map<String, dynamic> json) {
    return CustomVisionResult(
      predictions: json['predictions']?.map((pred) => Prediction.fromJson(pred)).toList() ?? [],
      projectId: json['projectId'] ?? '',
      iterationId: json['iterationId'] ?? '',
    );
  }
}

// Supporting classes
class DetectedObject {
  final String name;
  final double confidence;
  final BoundingBox? boundingBox;

  DetectedObject({
    required this.name,
    required this.confidence,
    this.boundingBox,
  });

  factory DetectedObject.fromJson(Map<String, dynamic> json) {
    return DetectedObject(
      name: json['name'] ?? '',
      confidence: json['confidence']?.toDouble() ?? 0.0,
      boundingBox: json['rectangle'] != null ? BoundingBox.fromJson(json['rectangle']) : null,
    );
  }
}

class DetectedFace {
  final int age;
  final String gender;
  final BoundingBox? boundingBox;

  DetectedFace({
    required this.age,
    required this.gender,
    this.boundingBox,
  });

  factory DetectedFace.fromJson(Map<String, dynamic> json) {
    return DetectedFace(
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      boundingBox: json['faceRectangle'] != null ? BoundingBox.fromJson(json['faceRectangle']) : null,
    );
  }
}

class ImageDescription {
  final List<Caption> captions;
  final List<String> tags;

  ImageDescription({
    required this.captions,
    required this.tags,
  });

  factory ImageDescription.fromJson(Map<String, dynamic> json) {
    return ImageDescription(
      captions: json['captions']?.map((cap) => Caption.fromJson(cap)).toList() ?? [],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}

class Caption {
  final String text;
  final double confidence;

  Caption({
    required this.text,
    required this.confidence,
  });

  factory Caption.fromJson(Map<String, dynamic> json) {
    return Caption(
      text: json['text'] ?? '',
      confidence: json['confidence']?.toDouble() ?? 0.0,
    );
  }
}

class ImageTag {
  final String name;
  final double confidence;

  ImageTag({
    required this.name,
    required this.confidence,
  });

  factory ImageTag.fromJson(Map<String, dynamic> json) {
    return ImageTag(
      name: json['name'] ?? '',
      confidence: json['confidence']?.toDouble() ?? 0.0,
    );
  }
}

class DetectedBrand {
  final String name;
  final double confidence;
  final BoundingBox? boundingBox;

  DetectedBrand({
    required this.name,
    required this.confidence,
    this.boundingBox,
  });

  factory DetectedBrand.fromJson(Map<String, dynamic> json) {
    return DetectedBrand(
      name: json['name'] ?? '',
      confidence: json['confidence']?.toDouble() ?? 0.0,
      boundingBox: json['rectangle'] != null ? BoundingBox.fromJson(json['rectangle']) : null,
    );
  }
}

class DetectedLandmark {
  final String name;
  final double confidence;
  final BoundingBox? boundingBox;

  DetectedLandmark({
    required this.name,
    required this.confidence,
    this.boundingBox,
  });

  factory DetectedLandmark.fromJson(Map<String, dynamic> json) {
    return DetectedLandmark(
      name: json['name'] ?? '',
      confidence: json['confidence']?.toDouble() ?? 0.0,
      boundingBox: json['rectangle'] != null ? BoundingBox.fromJson(json['rectangle']) : null,
    );
  }
}

class TextLine {
  final String text;
  final double confidence;
  final BoundingBox? boundingBox;

  TextLine({
    required this.text,
    required this.confidence,
    this.boundingBox,
  });

  factory TextLine.fromJson(Map<String, dynamic> json) {
    return TextLine(
      text: json['text'] ?? '',
      confidence: json['confidence']?.toDouble() ?? 0.0,
      boundingBox: json['boundingBox'] != null ? BoundingBox.fromJson(json['boundingBox']) : null,
    );
  }
}

class Prediction {
  final String tagName;
  final double probability;
  final BoundingBox? boundingBox;

  Prediction({
    required this.tagName,
    required this.probability,
    this.boundingBox,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      tagName: json['tagName'] ?? '',
      probability: json['probability']?.toDouble() ?? 0.0,
      boundingBox: json['boundingBox'] != null ? BoundingBox.fromJson(json['boundingBox']) : null,
    );
  }
}

class BoundingBox {
  final double x;
  final double y;
  final double width;
  final double height;

  BoundingBox({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory BoundingBox.fromJson(Map<String, dynamic> json) {
    return BoundingBox(
      x: json['x']?.toDouble() ?? 0.0,
      y: json['y']?.toDouble() ?? 0.0,
      width: json['w']?.toDouble() ?? json['width']?.toDouble() ?? 0.0,
      height: json['h']?.toDouble() ?? json['height']?.toDouble() ?? 0.0,
    );
  }
} 