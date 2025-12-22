import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class MyServicesPage extends StatelessWidget {
  const MyServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'My Services',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add service
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: AppColors.primary),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9), // Light green tint at top
              Color(0xFFE0F2F1), // Light teal tint
              Color(0xFFE0F7FA), // Light cyan tint
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'You can manage your services here. These services will be shown on your website and it will help your clients to easily book your services.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      _buildServiceCard(
                        icon: Icons.home_outlined,
                        title: 'Residential Home Inspection',
                        totalEarned: 239.98,
                        upcomingSchedules: 4,
                        price: 480,
                      ),
                      _buildServiceCard(
                        icon: Icons.apartment_outlined,
                        title: 'Commercial Property',
                        totalEarned: 499.99,
                        upcomingSchedules: 2,
                        price: 1200,
                      ),
                      _buildServiceCard(
                        icon: Icons.pest_control_outlined, // Using pest_control as substitute for bug icon
                        title: 'Pest Control Evaluation',
                        totalEarned: 159.50,
                        upcomingSchedules: 3,
                        price: 450,
                      ),
                      _buildServiceCard(
                        icon: Icons.power_outlined, // Using power for plug
                        title: 'Energy Efficiency Audit',
                        totalEarned: 349.00,
                        upcomingSchedules: 5,
                        price: 800,
                      ),
                      _buildServiceCard(
                        icon: Icons.pool_outlined, // Using pool for ladder/pool
                        title: 'Pool Safety Inspection',
                        totalEarned: 299.99,
                        upcomingSchedules: 1,
                        price: 300,
                      ),
                    ],
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.money, size: 16, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      '\$${totalEarned.toStringAsFixed(2)} Total Earned',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      '$upcomingSchedules Upcoming Schedule${upcomingSchedules != 1 ? 's' : ''}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '\$ $price USD',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // TODO: Implement edit service
                },
                child: const Text(
                  'Edit Service',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
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
