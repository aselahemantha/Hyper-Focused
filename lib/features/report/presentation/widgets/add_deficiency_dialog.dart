import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   const Text(
                    'Add a New Deficiency',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutralDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Placeholder for add photo
                    },
                    child: const Row(
                      children: [
                         Icon(Icons.camera_alt_outlined, size: 20, color: Color(0xFF00A98E)),
                         SizedBox(width: 4),
                         Text(
                          'Add a Photo',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF00A98E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildTextField('Deficiency name', _nameController),
              const SizedBox(height: 16),
              _buildTextField('Comment', _commentController, maxLines: 6),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _buildStatusButton('Monitor', Icons.analytics_outlined, Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatusButton('Deficiency', Icons.build_outlined, Colors.orange)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatusButton('Priority', Icons.warning_amber_rounded, Colors.red)),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: AppColors.neutral200),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('Cancel', style: TextStyle(color: AppColors.neutralDark)),
                    ),
                  ),
                  const SizedBox(width: 16),
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.neutral500, fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, IconData icon, Color color) {
    bool isSelected = _selectedStatus == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedStatus = label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: color, width: 1.5) : null,
        ),
        child: Column(
          children: [
             Icon(icon, color: isSelected ? color : AppColors.neutral500, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
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
