import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jose/jose.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import '../../models/user_model.dart';
import '../../models/enums.dart';

class AzureAuthService {
  static const String _clientId = 'YOUR_AZURE_B2C_CLIENT_ID';
  static const String _tenantName = 'YOUR_TENANT_NAME';
  static const String _policyName = 'B2C_1_SignUpSignIn';
  static const String _redirectUri = 'msauth://yolo.need.app/auth';
  static const String _scope = 'openid profile offline_access';
  
  // Azure B2C Endpoints
  static const String _authority = 'https://$_tenantName.b2clogin.com/$_tenantName.onmicrosoft.com/$_policyName/v2.0';
  static const String _authorizationEndpoint = '$_authority/oauth2/authorize';
  static const String _tokenEndpoint = '$_authority/oauth2/token';
  static const String _jwksUri = '$_authority/discovery/keys';
  
  // Storage keys
  static const String _accessTokenKey = 'azure_access_token';
  static const String _refreshTokenKey = 'azure_refresh_token';
  static const String _userKey = 'azure_user';
  static const String _tokenExpiryKey = 'azure_token_expiry';
  
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;
  
  User? _currentUser;
  oauth2.Client? _oauthClient;
  
  AzureAuthService({
    Dio? dio,
    FlutterSecureStorage? secureStorage,
  }) : _dio = dio ?? Dio(),
       _secureStorage = secureStorage ?? const FlutterSecureStorage();

  // Getters
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null && _oauthClient != null;
  String? get accessToken => _oauthClient?.credentials.accessToken;
  
  /// Initialize the authentication service
  Future<void> initialize() async {
    try {
      await _loadStoredCredentials();
      if (_oauthClient != null) {
        await _refreshTokenIfNeeded();
      }
    } catch (e) {
      print('AzureAuth: Failed to initialize - $e');
      await signOut();
    }
  }
  
  /// Sign in with Azure B2C
  Future<User> signIn() async {
    try {
      // Create authorization URL
      final authorizationUrl = Uri.parse(_authorizationEndpoint).replace(
        queryParameters: {
          'client_id': _clientId,
          'response_type': 'code',
          'redirect_uri': _redirectUri,
          'scope': _scope,
          'state': _generateState(),
          'nonce': _generateNonce(),
        },
      );
      
      // This would typically launch a web view or browser
      // For demo purposes, we'll simulate the flow
      final authorizationCode = await _launchAuthFlow(authorizationUrl);
      
      // Exchange authorization code for tokens
      final client = await _exchangeCodeForTokens(authorizationCode);
      _oauthClient = client;
      
      // Get user info from token
      final user = await _getUserFromToken(client.credentials.accessToken);
      _currentUser = user;
      
      // Store credentials securely
      await _storeCredentials(client.credentials, user);
      
      return user;
    } catch (e) {
      throw AzureAuthException('Sign in failed: $e');
    }
  }
  
  /// Sign up new user
  Future<User> signUp(String email, String password, String displayName) async {
    try {
      // Use B2C sign-up policy
      const signUpPolicy = 'B2C_1_SignUp';
      final signUpAuthority = 'https://$_tenantName.b2clogin.com/$_tenantName.onmicrosoft.com/$signUpPolicy/v2.0';
      final signUpEndpoint = '$signUpAuthority/oauth2/authorize';
      
      final authorizationUrl = Uri.parse(signUpEndpoint).replace(
        queryParameters: {
          'client_id': _clientId,
          'response_type': 'code',
          'redirect_uri': _redirectUri,
          'scope': _scope,
          'state': _generateState(),
          'nonce': _generateNonce(),
        },
      );
      
      final authorizationCode = await _launchAuthFlow(authorizationUrl);
      final client = await _exchangeCodeForTokens(authorizationCode);
      _oauthClient = client;
      
      final user = await _getUserFromToken(client.credentials.accessToken);
      _currentUser = user;
      
      await _storeCredentials(client.credentials, user);
      
      return user;
    } catch (e) {
      throw AzureAuthException('Sign up failed: $e');
    }
  }
  
  /// Sign out user
  Future<void> signOut() async {
    try {
      _currentUser = null;
      _oauthClient = null;
      
      // Clear stored credentials
      await _secureStorage.deleteAll();
      
      // Optional: Revoke tokens with Azure
      // await _revokeTokens();
    } catch (e) {
      print('AzureAuth: Sign out error - $e');
    }
  }
  
  /// Refresh access token if needed
  Future<void> _refreshTokenIfNeeded() async {
    if (_oauthClient == null) return;
    
    final credentials = _oauthClient!.credentials;
    if (credentials.isExpired) {
      try {
        final newCredentials = await credentials.refresh(
          identifier: _clientId,
          secret: null, // Public client
          tokenEndpoint: Uri.parse(_tokenEndpoint),
        );
        
        _oauthClient = oauth2.Client(
          newCredentials,
          identifier: _clientId,
        );
        
        // Update stored credentials
        await _storeCredentials(newCredentials, _currentUser!);
      } catch (e) {
        print('AzureAuth: Token refresh failed - $e');
        await signOut();
        throw AzureAuthException('Token refresh failed');
      }
    }
  }
  
  /// Get user information from JWT token
  Future<User> _getUserFromToken(String accessToken) async {
    try {
      // Decode JWT token
      final jwt = JsonWebToken.unverified(accessToken);
      final claims = jwt.claims;
      
      // Extract user information
      final objectId = claims['sub'] as String?;
      final email = claims['emails']?.first as String? ?? claims['email'] as String?;
      final displayName = claims['name'] as String? ?? claims['given_name'] as String?;
      final firstName = claims['given_name'] as String?;
      final lastName = claims['family_name'] as String?;
      
      // Determine user role from claims
      final roleClaim = claims['extension_Role'] as String? ?? 'seeker';
      final role = _parseUserRole(roleClaim);
      
      return User(
        id: objectId ?? '',
        email: email ?? '',
        displayName: displayName ?? '',
        firstName: firstName,
        lastName: lastName,
        role: role,
        status: UserStatus.active,
        azureObjectId: objectId,
        accessToken: accessToken,
        tokenExpiry: DateTime.fromMillisecondsSinceEpoch(
          (claims['exp'] as int) * 1000,
        ),
        claims: Map<String, dynamic>.from(claims.toJson()),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );
    } catch (e) {
      throw AzureAuthException('Failed to parse user token: $e');
    }
  }
  
  /// Parse user role from claims
  UserRole _parseUserRole(String roleClaim) {
    switch (roleClaim.toLowerCase()) {
      case 'helper':
        return UserRole.helper;
      case 'admin':
        return UserRole.admin;
      case 'business':
        return UserRole.business;
      default:
        return UserRole.seeker;
    }
  }
  
  /// Store credentials securely
  Future<void> _storeCredentials(oauth2.Credentials credentials, User user) async {
    await Future.wait([
      _secureStorage.write(key: _accessTokenKey, value: credentials.accessToken),
      if (credentials.refreshToken != null)
        _secureStorage.write(key: _refreshTokenKey, value: credentials.refreshToken!),
      _secureStorage.write(key: _userKey, value: jsonEncode(user.toJson())),
      if (credentials.expiration != null)
        _secureStorage.write(
          key: _tokenExpiryKey,
          value: credentials.expiration!.millisecondsSinceEpoch.toString(),
        ),
    ]);
  }
  
  /// Load stored credentials
  Future<void> _loadStoredCredentials() async {
    final values = await Future.wait([
      _secureStorage.read(key: _accessTokenKey),
      _secureStorage.read(key: _refreshTokenKey),
      _secureStorage.read(key: _userKey),
      _secureStorage.read(key: _tokenExpiryKey),
    ]);
    
    final accessToken = values[0];
    final refreshToken = values[1];
    final userJson = values[2];
    final expiryString = values[3];
    
    if (accessToken == null || userJson == null) return;
    
    DateTime? expiry;
    if (expiryString != null) {
      expiry = DateTime.fromMillisecondsSinceEpoch(int.parse(expiryString));
    }
    
    final credentials = oauth2.Credentials(
      accessToken,
      refreshToken: refreshToken,
      idToken: null,
      tokenEndpoint: Uri.parse(_tokenEndpoint),
      scopes: _scope.split(' '),
      expiration: expiry,
    );
    
    _oauthClient = oauth2.Client(credentials, identifier: _clientId);
    _currentUser = User.fromJson(jsonDecode(userJson));
  }
  
  /// Exchange authorization code for tokens
  Future<oauth2.Client> _exchangeCodeForTokens(String authorizationCode) async {
    try {
      final response = await _dio.post(
        _tokenEndpoint,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
        data: {
          'client_id': _clientId,
          'grant_type': 'authorization_code',
          'code': authorizationCode,
          'redirect_uri': _redirectUri,
          'scope': _scope,
        },
      );
      
      final data = response.data;
      final credentials = oauth2.Credentials(
        data['access_token'],
        refreshToken: data['refresh_token'],
        idToken: data['id_token'],
        tokenEndpoint: Uri.parse(_tokenEndpoint),
        scopes: _scope.split(' '),
        expiration: DateTime.now().add(
          Duration(seconds: data['expires_in'] ?? 3600),
        ),
      );
      
      return oauth2.Client(credentials, identifier: _clientId);
    } catch (e) {
      throw AzureAuthException('Token exchange failed: $e');
    }
  }
  
  /// Launch authentication flow (platform specific)
  Future<String> _launchAuthFlow(Uri authorizationUrl) async {
    // This is a simplified implementation
    // In a real app, you'd use platform-specific code or a plugin
    // like flutter_web_auth or url_launcher
    
    if (Platform.isAndroid || Platform.isIOS) {
      // Mobile implementation would use flutter_web_auth or similar
      throw UnimplementedError('Mobile auth flow not implemented');
    } else {
      // Web implementation would use redirects
      throw UnimplementedError('Web auth flow not implemented');
    }
  }
  
  /// Generate random state for OAUTH flow
  String _generateState() {
    final bytes = List<int>.generate(32, (i) => 
        DateTime.now().millisecondsSinceEpoch % 256);
    return base64Url.encode(bytes);
  }
  
  /// Generate random nonce for OAUTH flow
  String _generateNonce() {
    final bytes = List<int>.generate(32, (i) => 
        DateTime.now().microsecondsSinceEpoch % 256);
    return base64Url.encode(bytes);
  }
  
  /// Check if user has specific role
  bool hasRole(UserRole role) {
    return _currentUser?.role == role;
  }
  
  /// Check if user has any of the specified roles
  bool hasAnyRole(List<UserRole> roles) {
    return _currentUser != null && roles.contains(_currentUser!.role);
  }
  
  /// Update user profile
  Future<User> updateProfile(Map<String, dynamic> updates) async {
    if (_currentUser == null) {
      throw AzureAuthException('No authenticated user');
    }
    
    try {
      // Update via Microsoft Graph API
      final response = await _dio.patch(
        'https://graph.microsoft.com/v1.0/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${_oauthClient!.credentials.accessToken}',
            'Content-Type': 'application/json',
          },
        ),
        data: updates,
      );
      
      // Update local user object
      _currentUser = _currentUser!.copyWith(
        displayName: updates['displayName'] ?? _currentUser!.displayName,
        firstName: updates['givenName'] ?? _currentUser!.firstName,
        lastName: updates['surname'] ?? _currentUser!.lastName,
        updatedAt: DateTime.now(),
      );
      
      // Store updated user
      await _secureStorage.write(
        key: _userKey,
        value: jsonEncode(_currentUser!.toJson()),
      );
      
      return _currentUser!;
    } catch (e) {
      throw AzureAuthException('Profile update failed: $e');
    }
  }
}

/// Custom exception for Azure authentication errors
class AzureAuthException implements Exception {
  final String message;
  
  const AzureAuthException(this.message);
  
  @override
  String toString() => 'AzureAuthException: $message';
} 