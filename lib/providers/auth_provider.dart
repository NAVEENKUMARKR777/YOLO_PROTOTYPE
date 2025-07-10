import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/azure/azure_auth.dart';

// Authentication service provider
final authServiceProvider = Provider<AzureAuthService>((ref) {
  return AzureAuthService();
});

// Authentication state provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});

// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.user;
});

// Is authenticated provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isAuthenticated;
});

// User role provider
final userRoleProvider = Provider<UserRole?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.role;
});

// Is admin provider
final isAdminProvider = Provider<bool>((ref) {
  final role = ref.watch(userRoleProvider);
  return role == UserRole.admin;
});

// Is business provider
final isBusinessProvider = Provider<bool>((ref) {
  final role = ref.watch(userRoleProvider);
  return role == UserRole.business;
});

// Auth state model
class AuthState {
  final User? user;
  final String? accessToken;
  final String? idToken;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;
  
  const AuthState({
    this.user,
    this.accessToken,
    this.idToken,
    this.isLoading = false,
    this.error,
  }) : isAuthenticated = user != null && accessToken != null;
  
  AuthState copyWith({
    User? user,
    String? accessToken,
    String? idToken,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return AuthState(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      idToken: idToken ?? this.idToken,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
  
  // Clear user session
  AuthState clear() {
    return const AuthState();
  }
}

// Auth state notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AzureAuthService _authService;
  
  AuthNotifier(this._authService) : super(const AuthState()) {
    _initializeAuth();
  }
  
  /// Initialize authentication on app start
  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _authService.initialize();
      
      // Check if user is already signed in
      final user = await _authService.getCurrentUser();
      if (user != null) {
        final accessToken = await _authService.getAccessToken();
        state = state.copyWith(
          user: user,
          accessToken: accessToken,
          isLoading: false,
          clearError: true,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to initialize authentication: $e',
        isLoading: false,
      );
    }
  }
  
  /// Sign in with email and password
  Future<bool> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final result = await _authService.signInWithEmailPassword(
        email: email,
        password: password,
      );
      
      if (result.user != null) {
        state = state.copyWith(
          user: result.user,
          accessToken: result.accessToken,
          idToken: result.idToken,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          error: 'Failed to sign in',
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Sign in failed: $e',
        isLoading: false,
      );
      return false;
    }
  }
  
  /// Sign up with email and password
  Future<bool> signUpWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
    UserRole role = UserRole.seeker,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final result = await _authService.signUpWithEmailPassword(
        email: email,
        password: password,
        displayName: displayName,
        role: role,
      );
      
      if (result.user != null) {
        state = state.copyWith(
          user: result.user,
          accessToken: result.accessToken,
          idToken: result.idToken,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          error: 'Failed to create account',
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Sign up failed: $e',
        isLoading: false,
      );
      return false;
    }
  }
  
  /// Sign in with phone number
  Future<bool> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final result = await _authService.signInWithPhoneNumber(
        phoneNumber: phoneNumber,
      );
      
      if (result.user != null) {
        state = state.copyWith(
          user: result.user,
          accessToken: result.accessToken,
          idToken: result.idToken,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          error: 'Failed to sign in with phone',
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Phone sign in failed: $e',
        isLoading: false,
      );
      return false;
    }
  }
  
  /// Sign in with Microsoft account
  Future<bool> signInWithMicrosoft() async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final result = await _authService.signInWithMicrosoft();
      
      if (result.user != null) {
        state = state.copyWith(
          user: result.user,
          accessToken: result.accessToken,
          idToken: result.idToken,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          error: 'Failed to sign in with Microsoft',
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Microsoft sign in failed: $e',
        isLoading: false,
      );
      return false;
    }
  }
  
  /// Reset password
  Future<bool> resetPassword({required String email}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      await _authService.resetPassword(email: email);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        error: 'Password reset failed: $e',
        isLoading: false,
      );
      return false;
    }
  }
  
  /// Update user profile
  Future<bool> updateProfile({
    String? displayName,
    String? phoneNumber,
    String? photoUrl,
    Map<String, dynamic>? customClaims,
  }) async {
    if (state.user == null) return false;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final updatedUser = await _authService.updateUserProfile(
        displayName: displayName,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
        customClaims: customClaims,
      );
      
      if (updatedUser != null) {
        state = state.copyWith(
          user: updatedUser,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          error: 'Failed to update profile',
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Profile update failed: $e',
        isLoading: false,
      );
      return false;
    }
  }
  
  /// Refresh access token
  Future<void> refreshToken() async {
    try {
      final newToken = await _authService.refreshAccessToken();
      if (newToken != null) {
        state = state.copyWith(accessToken: newToken);
      }
    } catch (e) {
      // Handle token refresh error - might need to re-authenticate
      await signOut();
    }
  }
  
  /// Check if current user has specific role
  bool hasRole(UserRole role) {
    return state.user?.role == role;
  }
  
  /// Check if current user has any of the specified roles
  bool hasAnyRole(List<UserRole> roles) {
    return state.user != null && roles.contains(state.user!.role);
  }
  
  /// Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      await _authService.signOut();
      state = state.clear();
    } catch (e) {
      // Even if sign out fails, clear local state
      state = state.clear().copyWith(
        error: 'Sign out warning: $e',
      );
    }
  }
  
  /// Clear error
  void clearError() {
    state = state.copyWith(clearError: true);
  }
} 