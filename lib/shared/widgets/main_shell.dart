import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainShell extends ConsumerWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true, // Allows the body to scroll behind the floating bar
      body: child,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withValues(alpha: isDarkMode ? 0.6 : 0.8),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _calculateSelectedIndex(location),
                onTap: (index) => _onTap(context, index),
                elevation: 0,
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                selectedItemColor: const Color(0xFF6366F1),
                unselectedItemColor: Theme.of(context).disabledColor,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_outlined, size: 22),
                    activeIcon: Icon(Icons.dashboard, size: 22),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt_outlined, size: 22),
                    activeIcon: Icon(Icons.list_alt, size: 22),
                    label: 'Bank',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_outline, size: 22),
                    activeIcon: Icon(Icons.chat_bubble, size: 22),
                    label: 'Mock AI',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_outlined, size: 22),
                    activeIcon: Icon(Icons.calendar_month, size: 22),
                    label: 'Planner',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline, size: 22),
                    activeIcon: Icon(Icons.person, size: 22),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/bank')) return 1;
    if (location.startsWith('/mock')) return 2;
    if (location.startsWith('/tracker')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/bank');
        break;
      case 2:
        context.go('/mock');
        break;
      case 3:
        context.go('/tracker');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }
}
