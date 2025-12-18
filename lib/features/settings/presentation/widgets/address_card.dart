import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildRow('Address Line 1', '123 Highland Rd'),
          _buildDivider(),
          _buildRow('City', 'Los Angeles'),
          _buildDivider(),
          Row(
            children: [
              Expanded(child: _buildRow('Zip', '90006')),
              Container(
                width: 1,
                height: 48,
                color: AppColors.neutral100,
              ),
              Expanded(child: _buildRow('State', 'California')),
            ],
          ),
          _buildDivider(),
          _buildRow('Country', 'United States'),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.neutralDark,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textBody,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.neutral100,
    );
  }
}
