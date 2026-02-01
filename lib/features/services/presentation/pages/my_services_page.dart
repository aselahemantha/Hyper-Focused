import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

import '../../../../core/constants/app_strings.dart';
import '../../data/models/service_model.dart';

class MyServicesPage extends StatelessWidget {
  const MyServicesPage({super.key});

  static const List<ServiceModel> _services = [
    ServiceModel(
      id: '1',
      title: 'Residential Home Inspection',
      totalEarned: 239.98,
      upcomingSchedules: 4,
      price: 480,
      iconKey: 'home',
    ),
    ServiceModel(
      id: '2',
      title: 'Commercial Property',
      totalEarned: 499.99,
      upcomingSchedules: 2,
      price: 1200,
      iconKey: 'apartment',
    ),
    ServiceModel(
      id: '3',
      title: 'Pest Control Evaluation',
      totalEarned: 159.50,
      upcomingSchedules: 3,
      price: 450,
      iconKey: 'pest_control',
    ),
    ServiceModel(
      id: '4',
      title: 'Energy Efficiency Audit',
      totalEarned: 349.00,
      upcomingSchedules: 5,
      price: 800,
      iconKey: 'power',
    ),
    ServiceModel(
      id: '5',
      title: 'Pool Safety Inspection',
      totalEarned: 299.99,
      upcomingSchedules: 1,
      price: 300,
      iconKey: 'pool',
    ),
  ];

  IconData _getIcon(String key) {
    switch (key) {
      case 'home':
        return Icons.home_outlined;
      case 'apartment':
        return Icons.apartment_outlined;
      case 'pest_control':
        return Icons.pest_control_outlined;
      case 'power':
        return Icons.power_outlined;
      case 'pool':
        return Icons.pool_outlined;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.0.w),
          child: CircleAvatar(
            backgroundColor: AppColors.neutralWhite,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.neutralDark),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.myServices,
          style: TextStyle(
            color: AppColors.neutralDark,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add service
        },
        backgroundColor: AppColors.neutralWhite,
        child: const Icon(Icons.add, color: AppColors.primary),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Color(0xFFE0F2F1), Color(0xFFE0F7FA)],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  AppStrings.myReportDesc,
                  style: TextStyle(
                    color: AppColors.textBody2,
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: _services.length,
                    itemBuilder: (context, index) {
                      final service = _services[index];
                      return _buildServiceCard(
                        icon: _getIcon(service.iconKey),
                        title: service.title,
                        totalEarned: service.totalEarned,
                        upcomingSchedules: service.upcomingSchedules,
                        price: service.price.toInt(),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.neutral200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required double totalEarned,
    required int upcomingSchedules,
    required int price,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.neutralDark,
              borderRadius: BorderRadius.circular(8.w),
            ),
            child: Icon(icon, color: AppColors.neutralWhite, size: 24.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColors.neutralDark,
                  ),
                ),
                SizedBox(height: 4.h),
                // Total Earned
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/svg/earned_service.svg',
                      height: 14,
                      placeholderBuilder: (context) => Icon(
                        Icons.money_outlined,
                        size: 14.w,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '\$${totalEarned.toStringAsFixed(2)} Total Earned',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textBody,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h), // Adjusted spacing
                // Upcoming Schedules
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/svg/schedule_service.svg',
                      height: 14,
                      placeholderBuilder: (context) => Icon(
                        Icons.event_repeat,
                        size: 14.w,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '$upcomingSchedules Upcoming Schedule${upcomingSchedules != 1 ? 's' : ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textBody,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.neutralWhite,
                  border: Border.all(color: AppColors.neutral200),
                  borderRadius: BorderRadius.circular(6.w),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/images/svg/dollor_service.svg',
                      height: 14,
                      placeholderBuilder: (context) => Icon(
                        Icons.monetization_on_outlined,
                        size: 14.w,
                        color: AppColors.neutralDark,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '$price USD',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: AppColors.neutralDark,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () {
                  // TODO: Implement edit service
                },
                child: Text(
                  'Edit Service',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
