import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/template_card.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class TemplateCenterPage extends StatelessWidget {
  const TemplateCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: CircleAvatar(
            backgroundColor: AppColors.neutralWhite,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 18.w, color: AppColors.neutralDark),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        title: Text(
          'Template Centre',
          style: TextStyle(
            color: AppColors.neutralDark,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(
              Icons.info,
              color: Colors.black, // From design, looks like a filled black icon
              size: 28.w,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.3, 1.0],
            colors: [
              Color(0xFFE0F7FA), // Light cyan/blue at top
              Color(0xFFF5F5F5), // Fade to white-ish
              Color(0xFFF5F5F5),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              _buildTemplateCard(
                context,
                'Pool Inspection',
                'You can manage your services here. These services will be shown on your website.',
              ),
              _buildTemplateCard(
                context,
                'Garage Inspection',
                'You can manage your services here. These services will be shown on your website.',
              ),
              _buildTemplateCard(
                context,
                'Electricity Inspection',
                'You can manage your services here. These services will be shown on your website.',
              ),
              _buildTemplateCard(
                context,
                'Sample Inspection',
                'You can manage your services here. These services will be shown on your website.',
              ),
              _buildTemplateCard(
                context,
                'Residential Home Inspection',
                'You can manage your services here. These services will be shown on your website.',
              ),
              _buildTemplateCard(
                context,
                'Commercial Building',
                'You can manage your services here. These services will be shown on your website.',
              ),
              SizedBox(height: 80.h), // Extra space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.h, right: 10.w),
        child: FloatingActionButton(
          onPressed: () => _showOptionsModal(context),
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.menu, color: Colors.black),
        ),
      ),
    );
  }

  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOption(
                context,
                icon: Icons.add,
                label: 'Create a New Template',
                onTap: () {
                  context.pop(); // Close modal
                  context.push('/create-template');
                },
              ),
              const Divider(),
              _buildOption(
                context,
                icon: Icons.file_download_outlined,
                label: 'Import Template',
                onTap: () {
                  context.pop(); // Close modal
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Import functionality not implemented yet')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.neutral500),
      title: Text(
        label,
        style: TextStyle(
          color: AppColors.neutralDark,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
    );
  }

  Widget _buildTemplateCard(BuildContext context, String title, String description) {
    return TemplateCard(
      title: title,
      description: description,
      onExport: () {
        // Dummy action for export
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export functionality not implemented yet')),
        );
      },
      onEdit: () {
        context.push('/edit-template');
      },
    );
  }
}
