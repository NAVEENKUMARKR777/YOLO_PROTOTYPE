import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AzureBarcodeService {
  static const String _endpoint = 'https://your-vision-resource.cognitiveservices.azure.com';
  static const String _apiKey = 'your-api-key'; // In production, get this securely
  
  // Barcode API endpoints
  static const String _barcodeEndpoint = '/vision/v3.2/read/analyze';
  
  // Barcode types supported
  static const List<String> _supportedBarcodeTypes = [
    'QR_CODE',
    'CODE_128',
    'CODE_39',
    'EAN_13',
    'EAN_8',
    'UPC_A',
    'UPC_E',
    'PDF_417',
    'AZTEC',
    'DATA_MATRIX',
  ];

  // Scan barcode from image using Azure Computer Vision
  Future<List<BarcodeResult>> scanBarcodeFromImage(File imageFile) async {
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

      if (response.statusCode == 202) {
        // Get operation location for polling
        final operationLocation = response.headers['operation-location'];
        if (operationLocation != null) {
          return await _pollBarcodeResults(operationLocation);
        }
      }

      throw Exception('Failed to start barcode analysis: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error scanning barcode from image: $e');
    }
  }

  // Poll for barcode analysis results
  Future<List<BarcodeResult>> _pollBarcodeResults(String operationLocation) async {
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
          return _parseBarcodeResults(data);
        } else if (data['status'] == 'failed') {
          throw Exception('Barcode analysis failed');
        }
        // Continue polling if status is 'running'
      }

      attempts++;
    }

    throw Exception('Barcode analysis timed out');
  }

  // Parse barcode results from Azure response
  List<BarcodeResult> _parseBarcodeResults(Map<String, dynamic> data) {
    final results = <BarcodeResult>[];
    
    if (data['analyzeResult'] != null && data['analyzeResult']['readResults'] != null) {
      for (final result in data['analyzeResult']['readResults']) {
        if (result['lines'] != null) {
          for (final line in result['lines']) {
            if (line['text'] != null) {
              results.add(BarcodeResult(
                text: line['text'],
                format: _detectBarcodeFormat(line['text']),
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

  // Parse bounding box coordinates
  BoundingBox? _parseBoundingBox(List<dynamic>? boundingBox) {
    if (boundingBox == null || boundingBox.length != 4) return null;
    
    return BoundingBox(
      x: boundingBox[0].toDouble(),
      y: boundingBox[1].toDouble(),
      width: boundingBox[2].toDouble(),
      height: boundingBox[3].toDouble(),
    );
  }

  // Detect barcode format from text pattern
  String _detectBarcodeFormat(String text) {
    final cleanText = text.replaceAll(RegExp(r'[^\w]'), '');
    
    // Check for QR code pattern (alphanumeric with specific length)
    if (cleanText.length > 20 && RegExp(r'^[A-Za-z0-9]+$').hasMatch(cleanText)) {
      return 'QR_CODE';
    }
    
    // Check for numeric barcodes
    if (RegExp(r'^\d+$').hasMatch(cleanText)) {
      switch (cleanText.length) {
        case 8:
          return 'EAN_8';
        case 12:
          return 'UPC_A';
        case 13:
          return 'EAN_13';
        case 6:
          return 'UPC_E';
        default:
          return 'CODE_128';
      }
    }
    
    // Check for Code 39 pattern (alphanumeric with asterisks)
    if (cleanText.contains('*') && cleanText.startsWith('*') && cleanText.endsWith('*')) {
      return 'CODE_39';
    }
    
    return 'UNKNOWN';
  }

  // Validate barcode format
  bool isValidBarcodeFormat(String format) {
    return _supportedBarcodeTypes.contains(format);
  }

  // Generate barcode data for different formats
  Map<String, dynamic> generateBarcodeData(String text, String format) {
    switch (format) {
      case 'QR_CODE':
        return {
          'type': 'QR_CODE',
          'data': text,
          'format': format,
        };
      case 'EAN_13':
        return {
          'type': 'EAN_13',
          'data': text,
          'countryCode': _extractCountryCode(text),
          'manufacturerCode': _extractManufacturerCode(text),
          'productCode': _extractProductCode(text),
          'checkDigit': _calculateCheckDigit(text),
        };
      case 'UPC_A':
        return {
          'type': 'UPC_A',
          'data': text,
          'manufacturerCode': text.substring(1, 6),
          'productCode': text.substring(6, 11),
          'checkDigit': text.substring(11),
        };
      default:
        return {
          'type': format,
          'data': text,
          'format': format,
        };
    }
  }

  // Extract country code from EAN-13
  String _extractCountryCode(String ean13) {
    if (ean13.length >= 3) {
      final firstThree = ean13.substring(0, 3);
      // This is a simplified mapping - in reality, EAN-13 country codes are more complex
      switch (firstThree) {
        case '000':
        case '001':
        case '002':
        case '003':
        case '004':
        case '005':
        case '006':
        case '007':
        case '008':
        case '009':
          return 'USA';
        case '400':
        case '401':
        case '402':
        case '403':
        case '404':
        case '405':
        case '406':
        case '407':
        case '408':
        case '409':
          return 'Germany';
        case '500':
        case '501':
        case '502':
        case '503':
        case '504':
        case '505':
        case '506':
        case '507':
        case '508':
        case '509':
          return 'UK';
        default:
          return 'Unknown';
      }
    }
    return 'Unknown';
  }

  // Extract manufacturer code from EAN-13
  String _extractManufacturerCode(String ean13) {
    if (ean13.length >= 8) {
      return ean13.substring(3, 8);
    }
    return '';
  }

  // Extract product code from EAN-13
  String _extractProductCode(String ean13) {
    if (ean13.length >= 12) {
      return ean13.substring(8, 12);
    }
    return '';
  }

  // Calculate check digit for EAN-13
  String _calculateCheckDigit(String ean13) {
    if (ean13.length == 13) {
      return ean13.substring(12);
    }
    return '';
  }

  // Process barcode for need categorization
  NeedCategory categorizeNeedFromBarcode(BarcodeResult barcode) {
    final data = barcode.text.toLowerCase();
    
    // Check for food-related barcodes
    if (data.contains('food') || data.contains('grocery') || data.contains('meal')) {
      return NeedCategory.food;
    }
    
    // Check for transport-related barcodes
    if (data.contains('transport') || data.contains('ride') || data.contains('uber') || data.contains('lyft')) {
      return NeedCategory.transport;
    }
    
    // Check for healthcare-related barcodes
    if (data.contains('medical') || data.contains('health') || data.contains('medicine') || data.contains('pharmacy')) {
      return NeedCategory.healthcare;
    }
    
    // Check for housing-related barcodes
    if (data.contains('housing') || data.contains('shelter') || data.contains('rent')) {
      return NeedCategory.housing;
    }
    
    // Check for clothing-related barcodes
    if (data.contains('clothing') || data.contains('clothes') || data.contains('shirt') || data.contains('pants')) {
      return NeedCategory.clothing;
    }
    
    // Check for education-related barcodes
    if (data.contains('education') || data.contains('school') || data.contains('book') || data.contains('course')) {
      return NeedCategory.education;
    }
    
    // Check for technology-related barcodes
    if (data.contains('tech') || data.contains('computer') || data.contains('phone') || data.contains('device')) {
      return NeedCategory.technology;
    }
    
    return NeedCategory.other;
  }

  // Validate barcode data
  bool validateBarcode(String text, String format) {
    switch (format) {
      case 'EAN_13':
        return _validateEAN13(text);
      case 'UPC_A':
        return _validateUPCA(text);
      case 'QR_CODE':
        return _validateQRCode(text);
      default:
        return text.isNotEmpty;
    }
  }

  // Validate EAN-13 barcode
  bool _validateEAN13(String text) {
    if (text.length != 13 || !RegExp(r'^\d+$').hasMatch(text)) {
      return false;
    }
    
    // Calculate check digit
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      int digit = int.parse(text[i]);
      sum += digit * (i % 2 == 0 ? 1 : 3);
    }
    
    int checkDigit = (10 - (sum % 10)) % 10;
    return checkDigit == int.parse(text[12]);
  }

  // Validate UPC-A barcode
  bool _validateUPCA(String text) {
    if (text.length != 12 || !RegExp(r'^\d+$').hasMatch(text)) {
      return false;
    }
    
    // Calculate check digit
    int sum = 0;
    for (int i = 0; i < 11; i++) {
      int digit = int.parse(text[i]);
      sum += digit * (i % 2 == 0 ? 3 : 1);
    }
    
    int checkDigit = (10 - (sum % 10)) % 10;
    return checkDigit == int.parse(text[11]);
  }

  // Validate QR code
  bool _validateQRCode(String text) {
    // QR codes can contain any data, so we just check if it's not empty
    return text.isNotEmpty && text.length > 0;
  }

  // Get barcode scanner configuration
  MobileScannerController getScannerController() {
    return MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  // Get QR scanner configuration
  QrViewController getQRScannerController() {
    // This would be used with qr_code_scanner package
    // Implementation depends on the specific QR scanner widget
    throw UnimplementedError('QR scanner controller not implemented');
  }

  // Process scanned barcode data
  Future<ProcessedBarcodeData> processBarcodeData(BarcodeResult barcode) async {
    final category = categorizeNeedFromBarcode(barcode);
    final isValid = validateBarcode(barcode.text, barcode.format);
    final data = generateBarcodeData(barcode.text, barcode.format);
    
    return ProcessedBarcodeData(
      originalBarcode: barcode,
      category: category,
      isValid: isValid,
      processedData: data,
      confidence: barcode.confidence,
    );
  }
}

// Barcode result class
class BarcodeResult {
  final String text;
  final String format;
  final double confidence;
  final BoundingBox? boundingBox;

  BarcodeResult({
    required this.text,
    required this.format,
    required this.confidence,
    this.boundingBox,
  });
}

// Bounding box class
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
}

// Processed barcode data class
class ProcessedBarcodeData {
  final BarcodeResult originalBarcode;
  final NeedCategory category;
  final bool isValid;
  final Map<String, dynamic> processedData;
  final double confidence;

  ProcessedBarcodeData({
    required this.originalBarcode,
    required this.category,
    required this.isValid,
    required this.processedData,
    required this.confidence,
  });
}

// Need category enum (import from need_model.dart)
enum NeedCategory {
  food,
  transport,
  healthcare,
  housing,
  clothing,
  education,
  technology,
  other,
} 