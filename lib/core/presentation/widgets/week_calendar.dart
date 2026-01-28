import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../utils/responsive_size.dart';

class WeekCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const WeekCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final days = List.generate(
      9, 
      (index) => selectedDate.subtract(const Duration(days: 4)).add(Duration(days: index))
    );

    final peachColor = AppColors.statusCalender;

    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final date = days[index];
          final isSelected = date.day == selectedDate.day;

          // Hardcoded event logic for demo
          final hasEvent = [13, 16, 19].contains(date.day);

          // Style logic
          final isPeach = [16, 18, 19].contains(date.day);
          final bgColor = isSelected
              ? AppColors.primary
              : (isPeach ? peachColor : AppColors.neutralWhite);

          final textColor = isSelected
              ? AppColors.neutralWhite
              : isPeach
              ? AppColors.statusError
              : (date.weekday == DateTime.sunday
                    ? AppColors.neutral500
                    : AppColors.neutralDark);

          final subTextColor = isSelected
              ? AppColors.neutralWhite
              : isPeach
              ? AppColors.statusError
              : AppColors.neutral500;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Stack(
              children: [
                Container(
                  width: 55.w,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _getDayName(date.weekday),
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasEvent)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.statusNotify,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}
