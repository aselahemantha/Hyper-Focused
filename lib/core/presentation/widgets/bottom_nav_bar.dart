import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavBar({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    if (index == 4) {
      // Menu button is index 4, which maps to Settings in our loop but we handle it specifically if needed.
      // But standard goBranch works fine if routes are set up.
      // Index 4 is Settings.
    }
    
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Floating Pill for first 4 items
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neutralDark.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(0, Icons.home_outlined, Icons.home, AppStrings.navHome),
                        _buildNavItem(1, Icons.calendar_today_outlined, Icons.calendar_month, 'Schedule'), 
                        _buildNavItem(2, Icons.assignment_outlined, Icons.assignment, 'Reports'),
                        _buildNavItem(3, Icons.location_on_outlined, Icons.location_on, 'Map'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Menu Button (Settings)
            GestureDetector(
              onTap: () => _onTap(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite.withOpacity(0.3),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neutralDark.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.menu,
                        color: navigationShell.currentIndex == 4 ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    // Current route index
    final isSelected = navigationShell.currentIndex == index;
    
    // Based on the image:
    // Selected item is a black pill with text + icon
    // Unselected items are just icons
    
    return GestureDetector(
      onTap: () => _onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
            : const EdgeInsets.all(12),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.black, // Dark/Black active background
                borderRadius: BorderRadius.circular(30),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 26,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
