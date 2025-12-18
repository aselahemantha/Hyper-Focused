import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/schedule/presentation/widgets/schedule_card.dart';
import 'package:hyper_focused/core/presentation/widgets/week_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _isCalendarOpen = true; // Default to open as per screen
  DateTime _selectedDate = DateTime(2025, 12, 13); // Default to Fri 13

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopSection(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildDateHeader(),
                  const SizedBox(height: 16),
                  const ScheduleCard(),
                  const ScheduleCard(),
                  // Padding for bottom nav
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.green.withOpacity(0.1),
            Colors.white.withOpacity(0.5),
          ],
        ),
        border: Border(
           bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Title Area
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F2F1), // Light teal
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.calendar_today_outlined, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Viewing',
                      style: TextStyle(
                        color: AppColors.neutral500,
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      'Your schedule',
                      style: TextStyle(
                        color: AppColors.neutralDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                
                // Buttons
                _buildCircleButton(
                  icon: Icons.calendar_month, 
                  color: AppColors.primary, 
                  iconColor: Colors.white,
                  onTap: () {
                    setState(() {
                      _isCalendarOpen = !_isCalendarOpen;
                    });
                  },
                ),
                const SizedBox(width: 8),
                _buildCircleButton(
                  icon: Icons.add, 
                  color: Colors.white, 
                  iconColor: AppColors.primary,
                  onTap: () {
                    context.go('/schedule/create');
                  },
                ),
                const SizedBox(width: 8),
                _buildCircleButton(
                  icon: Icons.search, 
                  color: Colors.white, 
                  iconColor: AppColors.primary,
                  onTap: () {
                    // Not functioning as requested
                  },
                ),
              ],
            ),
          ),

          // Calendar Area (Collapsible)
          AnimatedCrossFade(
            firstChild: Container(height: 0), // Closed state
            secondChild: Column(
              children: [
                // Month Selector
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 16),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const Text(
                        'December 2025',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward, size: 16),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                WeekCalendar(
                  selectedDate: _selectedDate, 
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                ),
                const SizedBox(height: 16),
              ],
            ),
            crossFadeState: _isCalendarOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon, 
    required Color color, 
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            if (color == Colors.white)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
          ]
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _buildDateHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '13 December 2025',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.neutralDark,
          ),
        ),
        TextButton(
          onPressed: () {}, 
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Sync Changes',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
