import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/report/presentation/widgets/add_deficiency_dialog.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class InspectionItemDetailsPage extends StatefulWidget {
  final String categoryName;
  final String sectionName;
  final String itemName;

  const InspectionItemDetailsPage({
    super.key,
    required this.categoryName,
    required this.sectionName,
    required this.itemName,
  });

  @override
  State<InspectionItemDetailsPage> createState() => _InspectionItemDetailsPageState();
}

class _InspectionItemDetailsPageState extends State<InspectionItemDetailsPage> {
  int _selectedTabIndex = 0; // 0: Information, 1: Limitations, 2: Deficiencies
  bool _isEditingLocation = false;
  final TextEditingController _locationController = TextEditingController(text: 'Left corner of the room');

  // Check List Data
  final Map<String, bool> _materials = {
    'Glass': false,
    'Wood': false,
    'Steel': true,
    'Hollow Core': true,
    'Single Pane': false,
    'Fibre Glass': true,
  };

  final Map<String, bool> _sampleCheckList = {
    'Sample One': false,
    'Sample Two': true,
    'Sample Three': false,
  };

  // Deficiencies Data
  final List<Map<String, dynamic>> _deficiencies = [
    {
      'title': 'Door Does Not Close or Latch',
      'description': 'Door does not close or latch properly. Recommend qualified handyman adjust strike plate and/or lock.',
      'isSelected': false,
      'isExpanded': true,
    },
    {
      'title': 'Window Leak',
      'description': 'Water leaks through window during heavy rain. Suggest resealing or replacing weather stripping.',
      'isSelected': false,
      'isExpanded': false,
    },
    {
      'title': 'Heating System Malfunction',
      'description': 'Heating system fails to operate efficiently. Advise inspection and potential replacement of thermostat.',
      'isSelected': false,
      'isExpanded': false,
    },
    {
      'title': 'Flickering Lights',
      'description': 'Lights flicker intermittently. Recommend checking wiring and connections for loose contacts.',
      'isSelected': false,
      'isExpanded': false,
    },
    {
      'title': 'Cracked Tile',
      'description': 'Cracked tiles in the bathroom. Suggest replacing damaged tiles to prevent water damage.',
      'isSelected': false,
      'isExpanded': false,
    },
  ];

  void _showMenuModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             _buildMenuItem(Icons.edit_outlined, 'Edit Items', () {}),
            _buildDivider(),
            _buildMenuItem(Icons.maps_ugc_outlined, 'Location', () {
               setState(() => _isEditingLocation = true);
            }),
            _buildDivider(),
            _buildMenuItem(Icons.text_fields, 'Comment', () {}),
             _buildDivider(),
            _buildMenuItem(Icons.photo_outlined, 'Photo', () {}),
             _buildDivider(),
            _buildMenuItem(Icons.mic_none_outlined, 'Voice Note', () {}),
             _buildDivider(),
            _buildMenuItem(Icons.videocam_outlined, 'Video', () {}),
             _buildDivider(),
            _buildMenuItem(Icons.playlist_add_check, 'Check List', () {}),
             _buildDivider(),
            _buildMenuItem(Icons.insert_drive_file_outlined, 'File', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.neutral500, size: 24.w),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.neutralDark,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, color: AppColors.neutral100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
           // Background Gradient (Partial)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green.withOpacity(0.05),
                    const Color(0xFFF9FAFB),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                SizedBox(height: 16.h),
                _buildTabs(),
                SizedBox(height: 16.h),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 120.h),
                    child: _buildContent(),
                  ),
                ),
              ],
            ),
          ),
           // Bottom Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomActionBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                 boxShadow: [
                   BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_back, color: Colors.black87, size: 20.w),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inspection Details',
                style: TextStyle(
                  color: AppColors.neutral500,
                  fontSize: 12.sp,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.categoryName,
                    style: TextStyle(
                      color: AppColors.neutralDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right, size: 16.w, color: AppColors.neutralDark),
                  Text(
                    widget.sectionName,
                    style: TextStyle(
                      color: AppColors.neutralDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right, size: 16.w, color: AppColors.neutralDark),
                   Text(
                    widget.itemName,
                    style: TextStyle(
                      color: AppColors.neutralDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.w),
        ),
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            _buildTabItem('Information', 0),
            _buildTabItem('Limitations', 1),
            _buildTabItem('Deficiencies', 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00A98E) : Colors.transparent,
            borderRadius: BorderRadius.circular(24.w),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.neutralDark,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_selectedTabIndex == 0) {
      return _buildInformationTab();
    } else if (_selectedTabIndex == 1) {
      return _buildLimitationsTab();
    } else {
      return _buildDeficienciesTab();
    }
  }

  Widget _buildInformationTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLocationSection(),
          SizedBox(height: 24.h),
          _buildCheckListsSection(),
          SizedBox(height: 24.h),
          _buildSectionHeader('Texts', 'Edit List'),
          _buildTextCard(),
          SizedBox(height: 24.h),
          _buildSectionHeader('Photos', 'Edit List'),
          SizedBox(height: 8.h),
          _buildPhotoGrid(),
          SizedBox(height: 24.h),
          _buildSectionHeader('Voice Notes', 'Edit List'),
           SizedBox(height: 8.h),
          _buildVoiceNoteList(),
        ],
      ),
    );
  }

  Widget _buildLimitationsTab() {
    return const Center(child: Text("Limitations Placeholder"));
  }

  Widget _buildDeficienciesTab() {
     return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ..._deficiencies.map((def) => _buildDeficiencyTile(def)),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                 final newDeficiency = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (context) => const AddDeficiencyDialog(),
                );
                if (newDeficiency != null) {
                  setState(() {
                    _deficiencies.add(newDeficiency);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A98E),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w)),
                elevation: 0,
              ),
              child: Text('Add New', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
            ),
          ),
        ],
      ),
     );
  }

  Widget _buildDeficiencyTile(Map<String, dynamic> deficiency) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: deficiency['isExpanded'] ?? false,
          tilePadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          leading: Checkbox(
            value: deficiency['isSelected'] ?? false,
            onChanged: (val) {
               setState(() => deficiency['isSelected'] = val);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
            activeColor: const Color(0xFF00A98E),
            side: const BorderSide(color: AppColors.neutral200),
          ),
          title: Text(
            deficiency['title'],
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.neutralDark,
            ),
          ),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          children: [
            // Status Buttons
            Row(
              children: [
                Expanded(child: _buildTileStatusButton(deficiency, 'Monitor', Icons.analytics_outlined, Colors.blue)),
                SizedBox(width: 8.w),
                Expanded(child: _buildTileStatusButton(deficiency, 'Deficiency', Icons.build_outlined, Colors.orange)),
                SizedBox(width: 8.w),
                Expanded(child: _buildTileStatusButton(deficiency, 'Priority', Icons.warning_amber_rounded, Colors.red)),
              ],
            ),
            SizedBox(height: 16.h),
            
            // Comment Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Comment', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp)),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('Edit Comment', style: TextStyle(color: const Color(0xFF00A98E), fontSize: 14.sp)),
                )
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              deficiency['description'] ?? 'No description',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.neutral500,
                height: 1.5,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Divider(height: 1, color: AppColors.neutral100),
            ),
            
             // Add Photo Button
             GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.camera_alt_outlined, color: const Color(0xFF00A98E), size: 20.w),
                    SizedBox(width: 4.w),
                    Text(
                      'Add a Photo',
                      style: TextStyle(
                        color: const Color(0xFF00A98E),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildTileStatusButton(Map<String, dynamic> deficiency, String label, IconData icon, Color color) {
    // For now, let's default to selecting if it matches the 'status' key or default empty
    // If we want to store it, we need to update the map.
    String currentStatus = deficiency['status'] ?? 'Deficiency'; // Default
    bool isSelected = currentStatus == label;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          deficiency['status'] = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
         decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(8.w),
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

  Widget _buildLocationSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: AppColors.neutral500, size: 20.w),
                SizedBox(width: 8.w),
                Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutralDark,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () => setState(() => _isEditingLocation = !_isEditingLocation),
              child: Text(
                _isEditingLocation ? 'Save' : 'Edit Location',
                style: const TextStyle(
                  color: Color(0xFF00A98E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
         Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: _isEditingLocation
              ? TextField(
                  controller: _locationController,
                  maxLines: null,
                  decoration: const InputDecoration.collapsed(hintText: 'Enter location'),
                  style: TextStyle(fontSize: 16.sp, color: AppColors.neutralDark),
                )
              : Text(
                  _locationController.text,
                  style: TextStyle(fontSize: 16.sp, color: AppColors.neutralDark),
                ),
        ),
      ],
    );
  }

  Widget _buildCheckListsSection() {
    return Column(
      children: [
        _buildSectionHeader('Check Lists', 'Edit List'),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Material', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 16.w,
                runSpacing: 8.h,
                children: _materials.entries.map((e) => _buildCheckboxItem(e.key, e.value, _materials)).toList(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Divider(height: 1, color: AppColors.neutral100),
              ),
              Text('Check List sample', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
               SizedBox(height: 12.h),
               Wrap(
                spacing: 16.w,
                runSpacing: 8.h,
                children: _sampleCheckList.entries.map((e) => _buildCheckboxItem(e.key, e.value, _sampleCheckList)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxItem(String label, bool value, Map<String, bool> sourceMap) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24.w,
          height: 24.w,
          child: Checkbox(
            value: value,
            onChanged: (val) {
               setState(() => sourceMap[label] = val!);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
            activeColor: const Color(0xFF00A98E),
            side: const BorderSide(color: AppColors.neutral200),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.neutral500,
          ),
        ),
      ],
    );
  }

  Widget _buildTextCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        children: [
          Text(
            'You can manage your services here. These services will be shown on your website and it will help your clients to easily book your services.',
             style: TextStyle(fontSize: 14.sp, color: AppColors.neutral500, height: 1.5),
          ),
           Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const Divider(height: 1, color: AppColors.neutral100),
          ),
           Text(
            'You can manage your services here. These services will be shown on your website and it will help your clients to easily book your services.',
             style: TextStyle(fontSize: 14.sp, color: AppColors.neutral500, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8.h,
      crossAxisSpacing: 8.w,
      children: [
        _buildPhotoItem('assets/images/photo1.png', Colors.black),
        _buildPhotoItem('assets/images/photo2.png', Colors.teal),
        _buildPhotoItem('assets/images/photo3.png', Colors.red),
        _buildPhotoItem('assets/images/photo4.png', Colors.orange),
        _buildPhotoItem('assets/images/photo5.png', Colors.brown),
        _buildAddPhotoItem(),
      ],
    );
  }
  
  Widget _buildPhotoItem(String path, Color placeholderColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.w),
      child: Container(
        color: placeholderColor,
        // child: Image.asset(path, fit: BoxFit.cover), // Placeholder colors for now
      ),
    );
  }

  Widget _buildAddPhotoItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, color: AppColors.neutralDark),
          SizedBox(height: 4.h),
          Text(
            'Add New',
            style: TextStyle(fontSize: 12.sp, color: AppColors.neutralDark, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildVoiceNoteList() {
    return Column(
      children: List.generate(4, (index) => 
        Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '12 Dec 25 02.28 PM',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.neutral500,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '2 mins 4 secs',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutralDark,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.play_arrow_outlined, size: 28.w, color: AppColors.neutralDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.neutralDark,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            action,
            style: const TextStyle(
              color: Color(0xFF00A98E),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.w),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIcon(Icons.arrow_back),
                      _buildIcon(Icons.flashlight_on_outlined),
                      _buildIcon(Icons.mic_none_outlined),
                      _buildIcon(Icons.camera_alt_outlined),
                      _buildIcon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _showMenuModal(context),
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                 boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
              ),
              child: const Icon(Icons.menu, color: Colors.black87, size: 28),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildIcon(IconData icon) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: Colors.black87, size: 24),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
