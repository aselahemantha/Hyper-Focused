import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/presentation/widgets/week_calendar.dart';
import 'package:hyper_focused/features/report/presentation/widgets/report_card.dart';
import 'package:hyper_focused/features/report/presentation/widgets/report_filter.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool _isCalendarOpen = true;
  bool _isFilterOpen = false;
  DateTime _selectedDate = DateTime.now();

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
                padding: EdgeInsets.all(16.w),
                children: [
                  _buildListHeader(),
                  SizedBox(height: 16.h),
                  const ReportCard(),
                  const ReportCard(),
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
        border: Border(
           bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
        )
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
                    'assets/images/svg/report_icon.svg',
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
                      AppStrings.yourReports,
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
                  isActive: _isCalendarOpen,
                  onTap: _toggleCalendar,
                ),
                SizedBox(width: 8.w),
                _buildCircleButton(
                  icon: Icons.filter_list, 
                  isActive: _isFilterOpen,
                  onTap: _toggleFilter,
                ),
                SizedBox(width: 8.w),
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
                   SizedBox(height: 16.h),
                ],
                if (_isFilterOpen) ...[
                  const ReportFilter(),
                  SizedBox(height: 16.h),
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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, size: 16.w),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Text(
                '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward, size: 16.w),
                onPressed: () {},
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
        width: 40.w,
        height: 40.w,
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
        child: Icon(icon, color: iconColor, size: 20.w),
      ),
    );
  }

  Widget _buildListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.mostRecent,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
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
            AppStrings.syncChanges,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
        )
      ],
    );
  }


  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
