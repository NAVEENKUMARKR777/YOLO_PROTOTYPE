import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/need_model.dart';
import '../models/enums.dart';
import '../services/azure/azure_cosmos.dart';
import 'auth_provider.dart';
import 'app_provider.dart';

part 'needs_provider.freezed.dart';

// Cosmos service provider
final cosmosServiceProvider = Provider<AzureCosmosService>((ref) {
  return AzureCosmosService();
});

// Needs state provider
final needsProvider = StateNotifierProvider<NeedsNotifier, NeedsState>((ref) {
  final cosmosService = ref.watch(cosmosServiceProvider);
  final authState = ref.watch(authStateProvider);
  return NeedsNotifier(cosmosService, authState.accessToken);
});

// Alias for backward compatibility
final needsStateProvider = needsProvider;

// User's needs provider (filtered by current user)
final userNeedsProvider = Provider<List<Need>>((ref) {
  final needsState = ref.watch(needsProvider);
  final currentUser = ref.watch(currentUserProvider);
  
  if (currentUser == null) return [];
  
  return needsState.needs
      .where((need) => need.seekerId == currentUser.id)
      .toList();
});

// Community needs provider (public needs)
final communityNeedsProvider = Provider<List<Need>>((ref) {
  final needsState = ref.watch(needsProvider);
  
  return needsState.needs
      .where((need) => need.visibility == NeedVisibility.public)
      .toList();
});

// Active needs provider
final activeNeedsProvider = Provider<List<Need>>((ref) {
  final needsState = ref.watch(needsProvider);
  
  return needsState.needs
      .where((need) => need.status == NeedStatus.active)
      .toList();
});

// Trending needs provider
final trendingNeedsProvider = Provider<List<Need>>((ref) {
  final communityNeeds = ref.watch(communityNeedsProvider);
  
  // Sort by engagement score and creation date
  final trending = List<Need>.from(communityNeeds);
  trending.sort((a, b) {
    final aScore = (a.helpersCount * 2) + a.commentsCount + a.viewsCount;
    final bScore = (b.helpersCount * 2) + b.commentsCount + b.viewsCount;
    
    if (aScore != bScore) {
      return bScore.compareTo(aScore); // Higher score first
    }
    
    return b.createdAt.compareTo(a.createdAt); // Newer first
  });
  
  return trending.take(20).toList();
});

// Single need provider by ID
final needByIdProvider = Provider.family<Need?, String>((ref, needId) {
  final needsState = ref.watch(needsProvider);
  
  try {
    return needsState.needs.firstWhere((need) => need.id == needId);
  } catch (e) {
    return null;
  }
});

// Needs state model
@freezed
class NeedsState with _$NeedsState {
  const factory NeedsState({
    @Default(false) bool isLoading,
    @Default([]) List<Need> needs,
    @Default([]) List<Need> userNeeds,
    @Default([]) List<Need> communityNeeds,
    Need? currentNeed,
    @Default(0) int totalNeeds,
    @Default(0) int helpedCount,
    @Default(true) bool hasMore,
    NeedFilter? currentFilter,
    String? error,
  }) = _NeedsState;
}

// Needs state notifier
class NeedsNotifier extends StateNotifier<NeedsState> {
  final AzureCosmosService _cosmosService;
  String? _accessToken;
  
  NeedsNotifier(this._cosmosService, this._accessToken) : super(const NeedsState()) {
    if (_accessToken != null) {
      _initializeService();
      loadNeeds();
    }
  }
  
  void _initializeService() async {
    if (_accessToken != null) {
      await _cosmosService.initialize(_accessToken!);
    }
  }
  
  /// Load needs with optional filter
  Future<void> loadNeeds({
    NeedFilter? filter,
    bool refresh = false,
  }) async {
    if (refresh) {
      state = state.copyWith(needs: [], hasMore: true);
    }
    
    if (state.isLoading) return;
    
    state = state.copyWith(
      isLoading: true,
      currentFilter: filter ?? state.currentFilter,
    );
    
    try {
      final loadedNeeds = await _cosmosService.getNeeds(
        filter: state.currentFilter,
        limit: 20,
        offset: refresh ? 0 : state.needs.length,
      );
      
      final updatedNeeds = refresh 
          ? loadedNeeds
          : [...state.needs, ...loadedNeeds];
      
      state = state.copyWith(
        needs: updatedNeeds,
        isLoading: false,
        hasMore: loadedNeeds.length >= 20,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to load needs: $e',
        isLoading: false,
      );
    }
  }
  
  /// Create a new need
  Future<bool> createNeed(Need need) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final createdNeed = await _cosmosService.createNeed(need);
      
      // Add to the beginning of the list
      final updatedNeeds = [createdNeed, ...state.needs];
      
      state = state.copyWith(
        needs: updatedNeeds,
        isLoading: false,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to create need: $e',
        isLoading: false,
      );
      return false;
    }
  }
  
  /// Update an existing need
  Future<bool> updateNeed(String needId, Map<String, dynamic> updates) async {
    try {
      final updatedNeed = await _cosmosService.updateNeed(needId, updates);
      
      final updatedNeeds = state.needs.map((need) {
        return need.id == needId ? updatedNeed : need;
      }).toList();
      
      state = state.copyWith(needs: updatedNeeds);
      
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to update need: $e');
      return false;
    }
  }
  
  /// Delete a need
  Future<bool> deleteNeed(String needId) async {
    try {
      await _cosmosService.deleteNeed(needId);
      
      final updatedNeeds = state.needs
          .where((need) => need.id != needId)
          .toList();
      
      state = state.copyWith(needs: updatedNeeds);
      
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to delete need: $e');
      return false;
    }
  }
  
  /// Add a helper to a need
  Future<bool> addHelper(String needId, String helperId) async {
    try {
      final need = state.needs.firstWhere((n) => n.id == needId);
      
      if (need.helpers.contains(helperId)) {
        return true; // Already helping
      }
      
      final updates = {
        'helpers': [...need.helpers, helperId],
        'helpersCount': need.helpersCount + 1,
      };
      
      return await updateNeed(needId, updates);
    } catch (e) {
      state = state.copyWith(error: 'Failed to add helper: $e');
      return false;
    }
  }
  
  /// Remove a helper from a need
  Future<bool> removeHelper(String needId, String helperId) async {
    try {
      final need = state.needs.firstWhere((n) => n.id == needId);
      
      final updatedHelpers = need.helpers
          .where((id) => id != helperId)
          .toList();
      
      final updates = {
        'helpers': updatedHelpers,
        'helpersCount': updatedHelpers.length,
      };
      
      return await updateNeed(needId, updates);
    } catch (e) {
      state = state.copyWith(error: 'Failed to remove helper: $e');
      return false;
    }
  }
  
  /// Update need status
  Future<bool> updateNeedStatus(String needId, NeedStatus status) async {
    final updates = {
      'status': status.toString().split('.').last,
      'updatedAt': DateTime.now().toIso8601String(),
    };
    
    if (status == NeedStatus.completed) {
      updates['completedAt'] = DateTime.now().toIso8601String();
    }
    
    return await updateNeed(needId, updates);
  }
  
  /// Increment views count
  Future<void> incrementViews(String needId) async {
    try {
      final need = state.needs.firstWhere((n) => n.id == needId);
      
      final updates = {
        'viewsCount': need.viewsCount + 1,
      };
      
      await updateNeed(needId, updates);
    } catch (e) {
      // Silently fail for view counts
    }
  }
  
  /// Add a comment to a need
  Future<bool> addComment(String needId, NeedComment comment) async {
    try {
      await _cosmosService.addNeedComment(needId, comment);
      
      final need = state.needs.firstWhere((n) => n.id == needId);
      final updates = {
        'commentsCount': need.commentsCount + 1,
      };
      
      return await updateNeed(needId, updates);
    } catch (e) {
      state = state.copyWith(error: 'Failed to add comment: $e');
      return false;
    }
  }
  
  /// Search needs by text
  Future<void> searchNeeds(String query) async {
    if (query.trim().isEmpty) {
      await loadNeeds(refresh: true);
      return;
    }
    
    state = state.copyWith(
      isLoading: true,
      searchQuery: query,
      clearError: true,
    );
    
    try {
      final searchResults = await _cosmosService.searchNeeds(query);
      
      state = state.copyWith(
        needs: searchResults,
        isLoading: false,
        hasMore: false, // Search results don't support pagination
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Search failed: $e',
        isLoading: false,
      );
    }
  }
  
  /// Apply filter to needs
  Future<void> applyFilter(NeedFilter filter) async {
    await loadNeeds(filter: filter, refresh: true);
  }
  
  /// Clear current filter
  Future<void> clearFilter() async {
    await loadNeeds(filter: null, refresh: true);
  }
  
  /// Refresh needs list
  Future<void> refresh() async {
    await loadNeeds(refresh: true);
  }
  
  /// Load more needs (pagination)
  Future<void> loadMore() async {
    if (state.hasMore && !state.isLoading) {
      await loadNeeds();
    }
  }
  
  /// Get needs by category
  Future<void> getNeedsByCategory(NeedCategory category) async {
    final filter = NeedFilter(category: category);
    await applyFilter(filter);
  }
  
  /// Get needs by urgency level
  Future<void> getNeedsByUrgency(UrgencyLevel urgency) async {
    final filter = NeedFilter(urgencyLevel: urgency);
    await applyFilter(filter);
  }
  
  /// Get needs by location (nearby)
  Future<void> getNearbyNeeds({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  }) async {
    final filter = NeedFilter(
      location: NeedLocation(
        latitude: latitude,
        longitude: longitude,
        address: '',
      ),
      radius: radiusKm,
    );
    await applyFilter(filter);
  }
  
  /// Mark need as favorite
  Future<bool> toggleFavorite(String needId) async {
    try {
      final need = state.needs.firstWhere((n) => n.id == needId);
      
      // This would typically involve updating user preferences
      // For now, we'll update a local flag
      final updates = {
        'isFavorited': !need.tags.contains('favorited'),
      };
      
      if (updates['isFavorited'] == true) {
        updates['tags'] = [...need.tags, 'favorited'];
      } else {
        updates['tags'] = need.tags.where((tag) => tag != 'favorited').toList();
      }
      
      return await updateNeed(needId, updates);
    } catch (e) {
      state = state.copyWith(error: 'Failed to toggle favorite: $e');
      return false;
    }
  }
  
  /// Report a need
  Future<bool> reportNeed(String needId, String reason) async {
    try {
      // This would typically involve creating a report record
      final updates = {
        'isReported': true,
        'reportReason': reason,
        'reportedAt': DateTime.now().toIso8601String(),
      };
      
      return await updateNeed(needId, updates);
    } catch (e) {
      state = state.copyWith(error: 'Failed to report need: $e');
      return false;
    }
  }
  
  /// Clear error
  void clearError() {
    state = state.copyWith(clearError: true);
  }
  
  /// Update access token
  void updateAccessToken(String? accessToken) {
    _accessToken = accessToken;
    if (accessToken != null) {
      _initializeService();
    }
  }
} 