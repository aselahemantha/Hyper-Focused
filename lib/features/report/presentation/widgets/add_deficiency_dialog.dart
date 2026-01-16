import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class AddDeficiencyDialog extends StatefulWidget {
  const AddDeficiencyDialog({super.key});

  @override
  State<AddDeficiencyDialog> createState() => _AddDeficiencyDialogState();
}

class _AddDeficiencyDialogState extends State<AddDeficiencyDialog> {
  String _selectedStatus = 'Deficiency'; // Monitor, Deficiency, Priority
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    'Add a New Deficiency',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutralDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Placeholder for add photo
                    },
                    child: Row(
                      children: [
                         Icon(Icons.camera_alt_outlined, size: 20.w, color: const Color(0xFF00A98E)),
                         SizedBox(width: 4.w),
                         Text(
                          'Add a Photo',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF00A98E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _buildTextField('Deficiency name', _nameController),
              SizedBox(height: 16.h),
              _buildTextField('Comment', _commentController, maxLines: 6),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(child: _buildStatusButton('Monitor', Icons.analytics_outlined, Colors.blue)),
                  SizedBox(width: 12.w),
                  Expanded(child: _buildStatusButton('Deficiency', Icons.build_outlined, Colors.orange)),
                  SizedBox(width: 12.w),
                  Expanded(child: _buildStatusButton('Priority', Icons.warning_amber_rounded, Colors.red)),
                ],
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: const BorderSide(color: AppColors.neutral200),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
                      ),
                      child: const Text('Cancel', style: TextStyle(color: AppColors.neutralDark)),
                    ),
                  ),
                  SizedBox(width: 16.w),
                   Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Return the new deficiency data
                        Navigator.pop(context, {
                          'title': _nameController.text,
                          'description': _commentController.text, // Using description as comment for now
                          'status': _selectedStatus,
                          'isSelected': false, // Checkbox defaults to false? Or true since we added it?
                          'isExpanded': false,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A98E),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
                        elevation: 0,
                      ),
                      child: const Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {int maxLines = 1}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.neutral500, fontSize: 15.sp),
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, IconData icon, Color color) {
    bool isSelected = _selectedStatus == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedStatus = label),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(8.w),
          border: isSelected ? Border.all(color: color, width: 1.5.w) : null,
        ),
        child: Column(
          children: [
             Icon(icon, color: isSelected ? color : AppColors.neutral500, size: 20.w),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                color: isSelected ? color : AppColors.neutral500,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
