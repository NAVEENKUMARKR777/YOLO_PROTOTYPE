import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as path;

class AzureBlobStorageService {
  static const String _accountName = 'YOUR_STORAGE_ACCOUNT_NAME';
  static const String _accountKey = 'YOUR_STORAGE_ACCOUNT_KEY';
  static const String _baseUrl = 'https://$_accountName.blob.core.windows.net';
  
  // Container names
  static const String _needImagesContainer = 'need-images';
  static const String _proofDocsContainer = 'proof-docs';
  static const String _profileImagesContainer = 'profile-images';
  static const String _chatFilesContainer = 'chat-files';
  static const String _avatarsContainer = 'avatars';
  
  final Dio _dio;
  
  AzureBlobStorageService({Dio? dio}) : _dio = dio ?? Dio();
  
  /// Initialize the blob storage service
  Future<void> initialize() async {
    _dio.options.baseUrl = _baseUrl;
  }
  
  /// Upload file to blob storage
  Future<String> uploadFile({
    required String containerName,
    required String fileName,
    required Uint8List fileData,
    String? contentType,
    Map<String, String>? metadata,
  }) async {
    try {
      final blobName = _generateBlobName(fileName);
      final url = '$_baseUrl/$containerName/$blobName';
      
      final headers = _buildUploadHeaders(
        containerName,
        blobName,
        fileData,
        contentType ?? _getMimeType(fileName),
        metadata,
      );
      
      await _dio.put(
        url,
        data: fileData,
        options: Options(headers: headers),
      );
      
      return url;
    } catch (e) {
      throw BlobStorageException('Failed to upload file: $e');
    }
  }
  
  /// Upload file from file path
  Future<String> uploadFileFromPath({
    required String containerName,
    required String filePath,
    String? customFileName,
    Map<String, String>? metadata,
  }) async {
    try {
      final file = File(filePath);
      final fileData = await file.readAsBytes();
      final fileName = customFileName ?? path.basename(filePath);
      
      return await uploadFile(
        containerName: containerName,
        fileName: fileName,
        fileData: fileData,
        contentType: _getMimeType(fileName),
        metadata: metadata,
      );
    } catch (e) {
      throw BlobStorageException('Failed to upload file from path: $e');
    }
  }
  
  /// Download file from blob storage
  Future<Uint8List> downloadFile({
    required String containerName,
    required String blobName,
  }) async {
    try {
      final url = '$_baseUrl/$containerName/$blobName';
      final headers = _buildDownloadHeaders(containerName, blobName);
      
      final response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          responseType: ResponseType.bytes,
        ),
      );
      
      return Uint8List.fromList(response.data);
    } catch (e) {
      throw BlobStorageException('Failed to download file: $e');
    }
  }
  
  /// Get file URL with SAS token
  Future<String> getFileUrlWithSas({
    required String containerName,
    required String blobName,
    Duration? validFor,
  }) async {
    try {
      final expiry = DateTime.now().add(validFor ?? const Duration(hours: 1));
      final sasToken = _generateSasToken(
        containerName,
        blobName,
        expiry,
        'r', // read permission
      );
      
      return '$_baseUrl/$containerName/$blobName?$sasToken';
    } catch (e) {
      throw BlobStorageException('Failed to generate SAS URL: $e');
    }
  }
  
  /// Delete file from blob storage
  Future<void> deleteFile({
    required String containerName,
    required String blobName,
  }) async {
    try {
      final url = '$_baseUrl/$containerName/$blobName';
      final headers = _buildDeleteHeaders(containerName, blobName);
      
      await _dio.delete(url, options: Options(headers: headers));
    } catch (e) {
      throw BlobStorageException('Failed to delete file: $e');
    }
  }
  
  /// List files in container
  Future<List<BlobInfo>> listFiles({
    required String containerName,
    String? prefix,
    int? maxResults,
  }) async {
    try {
      final queryParams = <String, String>{
        'restype': 'container',
        'comp': 'list',
      };
      
      if (prefix != null) queryParams['prefix'] = prefix;
      if (maxResults != null) queryParams['maxresults'] = maxResults.toString();
      
      final url = '$_baseUrl/$containerName';
      final headers = _buildListHeaders(containerName);
      
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      
      return _parseBlobList(response.data);
    } catch (e) {
      throw BlobStorageException('Failed to list files: $e');
    }
  }
  
  /// Upload image for need
  Future<String> uploadNeedImage({
    required String needId,
    required Uint8List imageData,
    required String fileName,
  }) async {
    final customFileName = '${needId}_${DateTime.now().millisecondsSinceEpoch}_$fileName';
    
    return await uploadFile(
      containerName: _needImagesContainer,
      fileName: customFileName,
      fileData: imageData,
      contentType: _getMimeType(fileName),
      metadata: {
        'needId': needId,
        'uploadedAt': DateTime.now().toIso8601String(),
      },
    );
  }
  
  /// Upload profile image
  Future<String> uploadProfileImage({
    required String userId,
    required Uint8List imageData,
    required String fileName,
  }) async {
    final customFileName = '${userId}_profile_${DateTime.now().millisecondsSinceEpoch}_$fileName';
    
    return await uploadFile(
      containerName: _profileImagesContainer,
      fileName: customFileName,
      fileData: imageData,
      contentType: _getMimeType(fileName),
      metadata: {
        'userId': userId,
        'type': 'profile',
        'uploadedAt': DateTime.now().toIso8601String(),
      },
    );
  }
  
  /// Upload chat file
  Future<String> uploadChatFile({
    required String chatRoomId,
    required String senderId,
    required Uint8List fileData,
    required String fileName,
  }) async {
    final customFileName = '${chatRoomId}_${senderId}_${DateTime.now().millisecondsSinceEpoch}_$fileName';
    
    return await uploadFile(
      containerName: _chatFilesContainer,
      fileName: customFileName,
      fileData: fileData,
      contentType: _getMimeType(fileName),
      metadata: {
        'chatRoomId': chatRoomId,
        'senderId': senderId,
        'uploadedAt': DateTime.now().toIso8601String(),
      },
    );
  }
  
  /// Upload proof document
  Future<String> uploadProofDocument({
    required String needId,
    required String userId,
    required Uint8List fileData,
    required String fileName,
  }) async {
    final customFileName = '${needId}_proof_${userId}_${DateTime.now().millisecondsSinceEpoch}_$fileName';
    
    return await uploadFile(
      containerName: _proofDocsContainer,
      fileName: customFileName,
      fileData: fileData,
      contentType: _getMimeType(fileName),
      metadata: {
        'needId': needId,
        'userId': userId,
        'type': 'proof',
        'uploadedAt': DateTime.now().toIso8601String(),
      },
    );
  }
  
  /// Generate unique blob name
  String _generateBlobName(String fileName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = path.extension(fileName);
    final nameWithoutExt = path.basenameWithoutExtension(fileName);
    
    return '${nameWithoutExt}_$timestamp$extension';
  }
  
  /// Build headers for upload operation
  Map<String, String> _buildUploadHeaders(
    String containerName,
    String blobName,
    Uint8List data,
    String contentType,
    Map<String, String>? metadata,
  ) {
    final headers = <String, String>{
      'x-ms-version': '2020-10-02',
      'x-ms-date': _getFormattedDate(),
      'x-ms-blob-type': 'BlockBlob',
      'Content-Type': contentType,
      'Content-Length': data.length.toString(),
    };
    
    // Add metadata headers
    if (metadata != null) {
      for (final entry in metadata.entries) {
        headers['x-ms-meta-${entry.key}'] = entry.value;
      }
    }
    
    // Add authorization header
    headers['Authorization'] = _generateAuthHeader(
      'PUT',
      containerName,
      blobName,
      headers,
    );
    
    return headers;
  }
  
  /// Build headers for download operation
  Map<String, String> _buildDownloadHeaders(String containerName, String blobName) {
    final headers = <String, String>{
      'x-ms-version': '2020-10-02',
      'x-ms-date': _getFormattedDate(),
    };
    
    headers['Authorization'] = _generateAuthHeader(
      'GET',
      containerName,
      blobName,
      headers,
    );
    
    return headers;
  }
  
  /// Build headers for delete operation
  Map<String, String> _buildDeleteHeaders(String containerName, String blobName) {
    final headers = <String, String>{
      'x-ms-version': '2020-10-02',
      'x-ms-date': _getFormattedDate(),
    };
    
    headers['Authorization'] = _generateAuthHeader(
      'DELETE',
      containerName,
      blobName,
      headers,
    );
    
    return headers;
  }
  
  /// Build headers for list operation
  Map<String, String> _buildListHeaders(String containerName) {
    final headers = <String, String>{
      'x-ms-version': '2020-10-02',
      'x-ms-date': _getFormattedDate(),
    };
    
    headers['Authorization'] = _generateAuthHeader(
      'GET',
      containerName,
      '',
      headers,
      queryString: 'restype=container&comp=list',
    );
    
    return headers;
  }
  
  /// Generate authorization header
  String _generateAuthHeader(
    String method,
    String containerName,
    String blobName,
    Map<String, String> headers, {
    String? queryString,
  }) {
    final canonicalizedHeaders = _getCanonicalizedHeaders(headers);
    final canonicalizedResource = _getCanonicalizedResource(
      containerName,
      blobName,
      queryString,
    );
    
    final stringToSign = [
      method,
      '', // Content-Encoding
      '', // Content-Language
      headers['Content-Length'] ?? '',
      '', // Content-MD5
      headers['Content-Type'] ?? '',
      '', // Date
      '', // If-Modified-Since
      '', // If-Match
      '', // If-None-Match
      '', // If-Unmodified-Since
      '', // Range
      canonicalizedHeaders,
      canonicalizedResource,
    ].join('\n');
    
    final key = base64.decode(_accountKey);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(utf8.encode(stringToSign));
    final signature = base64.encode(digest.bytes);
    
    return 'SharedKey $_accountName:$signature';
  }
  
  /// Get canonicalized headers
  String _getCanonicalizedHeaders(Map<String, String> headers) {
    final msHeaders = <String>[];
    
    for (final entry in headers.entries) {
      if (entry.key.toLowerCase().startsWith('x-ms-')) {
        msHeaders.add('${entry.key.toLowerCase()}:${entry.value}');
      }
    }
    
    msHeaders.sort();
    return msHeaders.join('\n');
  }
  
  /// Get canonicalized resource
  String _getCanonicalizedResource(
    String containerName,
    String blobName,
    String? queryString,
  ) {
    final resource = '/$_accountName/$containerName${blobName.isNotEmpty ? '/$blobName' : ''}';
    
    if (queryString != null && queryString.isNotEmpty) {
      final params = queryString.split('&');
      params.sort();
      return '$resource\n${params.map((p) => p.replaceAll('=', ':')).join('\n')}';
    }
    
    return resource;
  }
  
  /// Get formatted date for Azure
  String _getFormattedDate() {
    final now = DateTime.now().toUtc();
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    final dayName = days[now.weekday - 1];
    final day = now.day.toString().padLeft(2, '0');
    final month = months[now.month - 1];
    final year = now.year;
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    
    return '$dayName, $day $month $year $hour:$minute:$second GMT';
  }
  
  /// Generate SAS token
  String _generateSasToken(
    String containerName,
    String blobName,
    DateTime expiry,
    String permissions,
  ) {
    final signedVersion = '2020-10-02';
    final signedResource = 'b'; // blob
    final signedExpiry = expiry.toUtc().toIso8601String().replaceAll('Z', '');
    final signedPermissions = permissions;
    
    final stringToSign = [
      signedPermissions,
      '', // signedStart
      signedExpiry,
      '/$_accountName/$containerName/$blobName',
      '', // signedIdentifier
      '', // signedIP
      '', // signedProtocol
      signedVersion,
      signedResource,
      '', // signedSnapshotTime
      '', // signedEncryptionScope
      '', // signedCacheControl
      '', // signedContentDisposition
      '', // signedContentEncoding
      '', // signedContentLanguage
      '', // signedContentType
    ].join('\n');
    
    final key = base64.decode(_accountKey);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(utf8.encode(stringToSign));
    final signature = base64.encode(digest.bytes);
    
    return 'sv=$signedVersion&sr=$signedResource&sp=$signedPermissions&se=$signedExpiry&sig=${Uri.encodeComponent(signature)}';
  }
  
  /// Get MIME type from file extension
  String _getMimeType(String fileName) {
    final extension = path.extension(fileName).toLowerCase();
    
    const mimeTypes = {
      '.jpg': 'image/jpeg',
      '.jpeg': 'image/jpeg',
      '.png': 'image/png',
      '.gif': 'image/gif',
      '.bmp': 'image/bmp',
      '.webp': 'image/webp',
      '.pdf': 'application/pdf',
      '.doc': 'application/msword',
      '.docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      '.txt': 'text/plain',
      '.mp4': 'video/mp4',
      '.mp3': 'audio/mpeg',
      '.wav': 'audio/wav',
      '.zip': 'application/zip',
    };
    
    return mimeTypes[extension] ?? 'application/octet-stream';
  }
  
  /// Parse blob list from XML response
  List<BlobInfo> _parseBlobList(String xmlData) {
    // This is a simplified parser
    // In a real implementation, you'd use an XML parser
    final blobs = <BlobInfo>[];
    
    final blobPattern = RegExp(r'<Blob>(.*?)</Blob>', dotAll: true);
    final namePattern = RegExp(r'<Name>(.*?)</Name>');
    final sizePattern = RegExp(r'<Content-Length>(\d+)</Content-Length>');
    final modifiedPattern = RegExp(r'<Last-Modified>(.*?)</Last-Modified>');
    
    final blobMatches = blobPattern.allMatches(xmlData);
    
    for (final blobMatch in blobMatches) {
      final blobXml = blobMatch.group(1) ?? '';
      
      final nameMatch = namePattern.firstMatch(blobXml);
      final sizeMatch = sizePattern.firstMatch(blobXml);
      final modifiedMatch = modifiedPattern.firstMatch(blobXml);
      
      if (nameMatch != null) {
        blobs.add(BlobInfo(
          name: nameMatch.group(1) ?? '',
          size: int.tryParse(sizeMatch?.group(1) ?? '0') ?? 0,
          lastModified: DateTime.tryParse(modifiedMatch?.group(1) ?? ''),
        ));
      }
    }
    
    return blobs;
  }
}

/// Blob information model
class BlobInfo {
  final String name;
  final int size;
  final DateTime? lastModified;
  
  BlobInfo({
    required this.name,
    required this.size,
    this.lastModified,
  });
}

/// Custom exception for blob storage operations
class BlobStorageException implements Exception {
  final String message;
  
  const BlobStorageException(this.message);
  
  @override
  String toString() => 'BlobStorageException: $message';
} 