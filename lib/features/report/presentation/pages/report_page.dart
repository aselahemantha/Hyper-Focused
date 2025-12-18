import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/presentation/widgets/week_calendar.dart';
import 'package:hyper_focused/features/report/presentation/widgets/report_card.dart';
import 'package:hyper_focused/features/report/presentation/widgets/report_filter.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // Calendar is open by default, Filter is closed
  bool _isCalendarOpen = true; 
  bool _isFilterOpen = false;
  DateTime _selectedDate = DateTime(2025, 12, 16); // Default as per image

  void _toggleCalendar() {
    setState(() {
      _isCalendarOpen = !_isCalendarOpen;
      if (_isCalendarOpen) {
        _isFilterOpen = false;
      }
    });
  }

  void _toggleFilter() {
    setState(() {
      _isFilterOpen = !_isFilterOpen;
      if (_isFilterOpen) {
        _isCalendarOpen = false;
      }
    });
  }

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
                  _buildListHeader(),
                  const SizedBox(height: 16),
                  const ReportCard(),
                  const ReportCard(),
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
                  child: const Icon(Icons.assignment_outlined, color: AppColors.primary, size: 20),
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
                      'Your reports',
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
                  isActive: _isCalendarOpen,
                  onTap: _toggleCalendar,
                ),
                const SizedBox(width: 8),
                _buildCircleButton(
                  icon: Icons.filter_list, 
                  isActive: _isFilterOpen,
                  onTap: _toggleFilter,
                ),
                const SizedBox(width: 8),
                _buildCircleButton(
                  icon: Icons.search, 
                  isActive: false,
                  onTap: () {
                    // Not functioning as requested
                  },
                ),
              ],
            ),
          ),

          // Collapsible Content (Calendar or Filter)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                if (_isCalendarOpen) ...[
                   _buildCalendarView(),
                   const SizedBox(height: 16),
                ],
                if (_isFilterOpen) ...[
                  const ReportFilter(),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarView() {
    return Column(
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
      ],
    );
  }

  Widget _buildCircleButton({
    required IconData icon, 
    required bool isActive,
    VoidCallback? onTap,
  }) {
    final bgColor = isActive ? AppColors.primary : Colors.white;
    final iconColor = isActive ? Colors.white : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            if (!isActive)
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

  Widget _buildListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Most Recent',
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
