import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';
import 'dart:ui';

class CreateTemplateItemDetailsPage extends StatefulWidget {
  final String categoryName;
  final String subCategoryName;
  final String itemName;

  const CreateTemplateItemDetailsPage({
    super.key,
    required this.categoryName,
    required this.subCategoryName,
    required this.itemName,
  });

  @override
  State<CreateTemplateItemDetailsPage> createState() => _CreateTemplateItemDetailsPageState();
}

class _CreateTemplateItemDetailsPageState extends State<CreateTemplateItemDetailsPage> {
  String _selectedTab = 'Information';
  final List<String> _tabs = ['Information', 'Limitations', 'Deficiencies'];

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
        title: Column(
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.neutralDark,
                ),
                children: [
                  const TextSpan(text: 'Create a New Template '),
                  WidgetSpan(
                    child: Icon(Icons.arrow_forward, size: 12.w, color: AppColors.neutralDark),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(text: ' Step 2'), // Design keeps Step 2 label even deep in hierarchy sometimes, user req image shows "Step 2"
                ],
              ),
            ),
            SizedBox(height: 4.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.neutralDark,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(text: 'Main Categories '),
                    WidgetSpan(
                      child: Icon(Icons.keyboard_arrow_right, size: 16.w, color: AppColors.neutralDark),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    TextSpan(text: ' ${widget.categoryName} '),
                    WidgetSpan(
                      child: Icon(Icons.keyboard_arrow_right, size: 16.w, color: AppColors.neutralDark),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    TextSpan(text: ' ${widget.subCategoryName}'),
                  ],
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 14.w,
              child: Icon(Icons.info_outline, color: Colors.white, size: 18.w),
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
              Color(0xFFE0F7FA),
              Color(0xFFF5F5F5),
              Color(0xFFF5F5F5),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
                children: [
                  // Item Name Title
                  Text(
                    widget.itemName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutralDark,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'You can manage your services here. These services will be shown on your website.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.neutral500,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Tabs
                  Container(
                    height: 50.h, // Fixed height for tab bar row
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _tabs.length,
                      separatorBuilder: (context, index) => SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        final tab = _tabs[index];
                        final isSelected = _selectedTab == tab;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTab = tab;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : AppColors.neutralWhite,
                              borderRadius: BorderRadius.circular(25.h),
                              border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent),
                              boxShadow: [
                                if (!isSelected)
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                tab,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : AppColors.neutralDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Location Input
                   Row(
                    children: [
                      Icon(Icons.flag_outlined, color: AppColors.neutral500, size: 20.w),
                      SizedBox(width: 8.w),
                      Text(
                        'Location*',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.neutralDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Add the default location',
                        hintStyle: TextStyle(color: AppColors.neutral500),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Add New Item Button (Dynamic text based on tab)
                  GestureDetector(
                    onTap: () {
                      // Action for adding new info
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.w),
                        border: Border.all(
                          color: AppColors.neutral100,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Click to add a New $_selectedTab', // e.g., "Click to add a New Information"
                          style: TextStyle(
                            color: AppColors.neutral500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Bottom Bar
              Positioned(
                bottom: 24.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35.h),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 70.w, // Using .w to keep it proportional if needed, or .h. 70.w is prob better for touch targets
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(35.h),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.neutralDark.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back, color: AppColors.neutralDark, size: 28.w),
                                  onPressed: () => context.pop(),
                                ),
                                IconButton(
                                  icon: Icon(Icons.home_outlined, color: AppColors.neutralDark, size: 28.w),
                                  onPressed: () {
                                     context.go('/'); // Or wherever home is
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit_outlined, color: AppColors.neutralDark, size: 28.w),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.save_outlined, color: AppColors.neutralDark, size: 28.w),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: () => _showMenuModal(context),
                      child: Container(
                        width: 70.w,
                        height: 70.w,
                        decoration: const BoxDecoration(
                            color: AppColors.neutralWhite,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                        child: Icon(Icons.menu, color: AppColors.neutralDark, size: 30.w),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMenuModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMenuItem(context, Icons.text_fields, 'Comment'),
            const Divider(height: 1),
            _buildMenuItem(context, Icons.photo_outlined, 'Photo'),
            const Divider(height: 1),
            _buildMenuItem(context, Icons.mic_none, 'Voice Note'),
            const Divider(height: 1),
            _buildMenuItem(context, Icons.videocam_outlined, 'Video'),
            const Divider(height: 1),
            _buildMenuItem(context, Icons.checklist, 'Check List'),
            const Divider(height: 1),
            _buildMenuItem(context, Icons.description_outlined, 'File'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMenuItem(BuildContext context, IconData icon, String text) {
      return ListTile(
        leading: Icon(icon, color: AppColors.neutral500),
        title: Text(text),
        onTap: () {
            context.pop();
        },
      );
  }
}
