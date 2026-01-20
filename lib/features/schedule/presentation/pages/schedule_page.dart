import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/schedule/presentation/widgets/schedule_card.dart';
import 'package:hyper_focused/core/presentation/widgets/week_calendar.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _isCalendarOpen = true;
  DateTime _selectedDate = DateTime.now();

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
                padding: EdgeInsets.all(16.w),
                children: [
                  _buildDateHeader(),
                  SizedBox(height: 16.h),
                  const ScheduleCard(),
                  const ScheduleCard(),
                  SizedBox(height: 80.h),
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
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                // Title Area
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/svg/schedule_icon.svg',
                    height: 24,
                    placeholderBuilder: (context) => const Icon(
                      Icons.calendar_today_outlined,
                      size: 24,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.viewing,
                      style: TextStyle(
                        color: AppColors.textBody,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      AppStrings.yourSchedule,
                      style: TextStyle(
                        color: AppColors.neutralDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                
                // Buttons
                _buildCircleButton(
                  icon: Icons.calendar_today_outlined,
                  color: AppColors.primary, 
                  iconColor: AppColors.neutralWhite,
                  onTap: () {
                    setState(() {
                      _isCalendarOpen = !_isCalendarOpen;
                    });
                  },
                ),
                SizedBox(width: 8.w),
                _buildCircleButton(
                  icon: Icons.add, 
                  color: AppColors.neutralWhite,
                  iconColor: AppColors.primary,
                  onTap: () {
                    context.go('/schedule/create');
                  },
                ),
                SizedBox(width: 8.w),
                _buildCircleButton(
                  icon: Icons.search, 
                  color: AppColors.neutralWhite,
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
            firstChild: Container(height: 0),
            secondChild: Column(
              children: [
                // Month Selector
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 16.w),
                        onPressed: () {
                          setState(() {
                             _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(_selectedDate),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward, size: 16.w),
                        onPressed: () {
                           setState(() {
                             _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                WeekCalendar(
                  selectedDate: _selectedDate, 
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                ),
                SizedBox(height: 16.h),
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
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            if (color == AppColors.neutralWhite)
              BoxShadow(
                color: AppColors.neutralDark.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
          ]
        ),
        child: Icon(icon, color: iconColor, size: 20.w),
      ),
    );
  }

  Widget _buildDateHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('d MMMM yyyy').format(_selectedDate),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
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
          child: Text(
            'Sync Changes',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        )
      ],
    );
  }
}
