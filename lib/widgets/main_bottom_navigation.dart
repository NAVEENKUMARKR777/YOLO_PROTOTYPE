import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../models/enums.dart';

class MainBottomNavigation extends ConsumerWidget {
  const MainBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authStateProvider).user;
    final currentLocation = GoRouterState.of(context).uri.path;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _getCurrentIndex(currentLocation),
      onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Community',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: 'Gamification',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        if (currentUser?.role == UserRole.admin)
          const BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
      ],
    );
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/community')) return 1;
    if (location.startsWith('/chat')) return 2;
    if (location.startsWith('/gamification')) return 3;
    if (location.startsWith('/profile')) return 4;
    if (location.startsWith('/admin')) return 5;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/community');
        break;
      case 2:
        context.go('/chat');
        break;
      case 3:
        context.go('/gamification');
        break;
      case 4:
        context.go('/profile');
        break;
      case 5:
        context.go('/admin');
        break;
    }
  }
} 