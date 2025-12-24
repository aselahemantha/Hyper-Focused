import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/template_card.dart';

class TemplateCenterPage extends StatelessWidget {
  const TemplateCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundColor: AppColors.neutralWhite,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.neutralDark),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        title: const Text(
          'Template Centre',
          style: TextStyle(
            color: AppColors.neutralDark,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.info,
              color: Colors.black, // From design, looks like a filled black icon
              size: 28,
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
            padding: const EdgeInsets.all(16),
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
            ],
          ),
        ),
      ),
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
