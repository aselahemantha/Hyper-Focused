import 'package:flutter/material.dart';
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
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.surfaceDark, // Dark grey background
          borderRadius: BorderRadius.circular(35),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(0, Icons.home, AppStrings.navHome),
            _buildNavItem(1, Icons.notifications, AppStrings.navPlan),
            _buildNavItem(2, Icons.sentiment_satisfied_alt, AppStrings.navCheck),
            _buildNavItem(3, Icons.list, AppStrings.navApproved),
            _buildNavItem(4, Icons.shopping_cart, AppStrings.navSettings),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () => _onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
            : const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [AppColors.navItemGradientStart, AppColors.navItemGradientEnd], // Green to Blue gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: 28,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
