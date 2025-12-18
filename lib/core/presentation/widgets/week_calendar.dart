import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

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
    final days = [
      DateTime(2025, 12, 12), // Thu
      DateTime(2025, 12, 13), // Fri
      DateTime(2025, 12, 14), // Sat
      DateTime(2025, 12, 15), // Sun
      DateTime(2025, 12, 16), // Mon
      DateTime(2025, 12, 17), // Tue
      DateTime(2025, 12, 18), // Wed
      DateTime(2025, 12, 19), // Thu
      DateTime(2025, 12, 20), // Fri
    ];

    // Peach color for specific days as seen in design
    final peachColor = const Color(0xFFFFE0B2).withOpacity(0.5);

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
              : (isPeach ? peachColor : Colors.white);
          
          final textColor = isSelected ? Colors.white : (date.weekday == DateTime.sunday ? AppColors.neutral500 : AppColors.neutralDark);
          final subTextColor = isSelected ? Colors.white : AppColors.neutral500;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Stack(
              children: [
                Container(
                  width: 55,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.transparent, 
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _getDayName(date.weekday),
                        style: TextStyle(
                          color: subTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
        }
      )
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}
