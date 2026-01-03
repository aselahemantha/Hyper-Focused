import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/add_section_dialog.dart';

class InspectionItemPage extends StatefulWidget {
  final String categoryName;
  final String sectionName;
  const InspectionItemPage({super.key, required this.categoryName, required this.sectionName});

  @override
  State<InspectionItemPage> createState() => _InspectionItemPageState();
}

class _InspectionItemPageState extends State<InspectionItemPage> {
  bool _isEditingItems = false;
  bool _isEditingLocation = false;
  File? _coverImage;
  final TextEditingController _locationController = TextEditingController(text: 'Between the MB room and bathroom');
  
  final List<String> _items = [
    'General',
    'Entry Door',
    'Window 1',
    'Wardrobe',
    'Bed',
  ];

  final Map<String, int?> _itemPins = {
    'Entry Door': 2,
  };

  Future<void> _pickCoverPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _coverImage = File(image.path);
      });
    }
  }

  void _toggleEditItems() {
    setState(() {
      _isEditingItems = !_isEditingItems;
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  Future<void> _showAddItemDialog(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const AddSectionDialog(showIconPicker: false),
    );

    if (result != null) {
      setState(() {
        _items.add(result['name']);
      });
    }
  }

  void _showMenuModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 40),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: AppColors.neutral500),
              title: const Text(
                'Edit Sections',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralDark,
                ),
              ),
              onTap: () {
                context.pop();
                _toggleEditItems();
              },
            ),
            const Divider(height: 1, color: AppColors.neutral100),
            ListTile(
              leading: const Icon(Icons.maps_ugc_outlined, color: AppColors.neutral500), // Using a close match or location specific if available
              // User screenshot icon looks like a flag/map marker mix. 
              // Icon(Icons.add_location_alt_outlined) or similar? 
              // Screenshot icon: "Layer" looking thing with a flag? or just "Location details".
              // Let's use `Icons.add_location_outlined` or `Icons.edit_location_outlined`
              // Actually looking closer at artifact `uploaded_image_1767453922781.png`... 
              // It looks like a map pin on a map/layer. `Icons.add_location_alt_outlined` is closest? 
              // Or standard `Icons.location_on_outlined`. The screenshot shows `Location` as `Icons.location_on_outlined` in the body.
              // In the menu it's a bit more complex. Let's use `Icons.add_location_alt_outlined` for "Add/Edit Location".
              title: const Text(
                'Add/Edit Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralDark,
                ),
              ),
              onTap: () {
                context.pop();
                setState(() {
                  _isEditingLocation = !_isEditingLocation;
                });
              },
            ),
            const Divider(height: 1, color: AppColors.neutral100),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined, color: AppColors.neutral500),
              title: const Text(
                'Edit Cover Photo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralDark,
                ),
              ),
              onTap: () {
                context.pop();
                _pickCoverPhoto();
              },
            ),
            const Divider(height: 1, color: AppColors.neutral100),
            ListTile(
              leading: const Icon(Icons.grid_view_outlined, color: AppColors.neutral500), // Screenshot shows a grid with plus? Or just grid.
              // Screenshot icon looks like a grid/table. `Icons.table_chart_outlined`? 
              // Or `Icons.grid_on_outlined`.
              // Previous was `grid_view_outlined`. I'll stick to that or `grid_view`
              title: const Text(
                'Add a New Item',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralDark,
                ),
              ),
              onTap: () {
                context.pop();
                _showAddItemDialog(context);
              },
            ),
          ],
        ),
      ),
    );
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
            height: 300,
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
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Hero Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[300], // Placeholder for image
                            child: _coverImage != null
                              ? Image.file(
                                  _coverImage!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                 'assets/images/placeholder_room.png', // Fallback or placeholder
                                 fit: BoxFit.cover,
                                 errorBuilder: (context, error, stackTrace) => 
                                    const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                               ), 
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Location Section
                        _buildSectionHeader(
                          icon: Icons.location_on_outlined, 
                          title: 'Location', 
                          actionLabel: _isEditingLocation ? 'Save' : 'Edit Location', 
                          onAction: () {
                            setState(() {
                              _isEditingLocation = !_isEditingLocation;
                            });
                          }
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: _isEditingLocation 
                            ? TextField(
                                controller: _locationController,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.neutralDark,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                maxLines: null,
                              )
                            : Text(
                                _locationController.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.neutralDark,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        ),
                        const SizedBox(height: 24),

                        // Items Section
                        _buildSectionHeader(
                          icon: Icons.grid_view_outlined, 
                          title: 'Items', 
                          actionLabel: _isEditingItems ? 'Save Changes' : 'Edit Items', 
                          onAction: _toggleEditItems
                        ),
                        const SizedBox(height: 8),
                        
                        if (_isEditingItems)
                          ReorderableListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _items.length,
                            onReorder: _onReorder,
                            proxyDecorator: (child, index, animation) {
                              return AnimatedBuilder(
                                animation: animation,
                                builder: (BuildContext context, Widget? child) {
                                  return Material(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: child,
                                  );
                                },
                                child: child,
                              );
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                key: ValueKey(_items[index]),
                                margin: const EdgeInsets.only(bottom: 12),
                                child: _buildItemRow(_items[index], index: index),
                              );
                            },
                          )
                        else 
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: _buildItemRow(_items[index]),
                              );
                            },
                          ),
                        
                        const SizedBox(height: 12),
                        // Add Item Button
                        if (!_isEditingItems)
                        GestureDetector(
                          onTap: () => _showAddItemDialog(context),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00A98E), // Green color from screenshot
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'Add Item',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
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
                  child: const Icon(Icons.arrow_back, color: Colors.black87, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Inspection Details',
                    style: TextStyle(
                      color: AppColors.neutral500,
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.categoryName,
                        style: const TextStyle(
                          color: AppColors.neutralDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right, size: 16, color: AppColors.neutralDark),
                      Text(
                        widget.sectionName,
                        style: const TextStyle(
                          color: AppColors.neutralDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          /* Info Icon - Not in screenshot but common in other pages, keeping standard header structure? 
             Actually screenshot just has standard header. 
             If not needed, can remove. But let's keep consistency for now or minimal based on screenshot.
             Screenshot shows back button, text, and... wait, it's cut off. 
             But 'InspectionStartPage' had it. Let's keep it minimal if screenshot doesn't show it clearly,
             but standard app header usually has an action on right. I'll leave it empty to match screenshot cleanly. 
          */
          Container(), 
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon, 
    required String title, 
    required String actionLabel, 
    required VoidCallback onAction
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: AppColors.neutral500),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.neutralDark,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: onAction,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            actionLabel,
            style: const TextStyle(
              color: Color(0xFF00A98E), // Green like "Add Item" button
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemRow(String itemName, {int? index}) {
    final pins = _itemPins[itemName];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (_isEditingItems)
            ReorderableDragStartListener(
              index: index!,
              child: const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.menu, color: AppColors.neutral500),
              ),
            ),
          Expanded(
            child: GestureDetector(
              onTap: _isEditingItems ? null : () {
                context.push(
                  '/inspection-item-details',
                  extra: {
                    'categoryName': widget.categoryName,
                    'sectionName': widget.sectionName,
                    'itemName': itemName,
                  },
                );
              },
              behavior: HitTestBehavior.translucent,
              child: Text(
                itemName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralDark,
                ),
              ),
            ),
          ),
          if (!_isEditingItems) ...[
            if (pins != null) ...[
              const Icon(Icons.push_pin_outlined, size: 16, color: Color(0xFF00A98E)),
              const SizedBox(width: 4),
              Text(
                '$pins Pins',
                style: const TextStyle(
                  color: Color(0xFF00A98E),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
            ],
            GestureDetector(
              onTap: () {
                 context.push(
                  '/inspection-item-details',
                  extra: {
                    'categoryName': widget.categoryName,
                    'sectionName': widget.sectionName,
                    'itemName': itemName,
                  },
                );
              },
              behavior: HitTestBehavior.translucent,
              child: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.neutralDark),
            ),
          ] else
            GestureDetector(
              onTap: () => _removeItem(index!),
              child: Container(
                width: 24, 
                height: 2, 
                color: Colors.red,
              ),
            )
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Capsule Container
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
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
                      // Camera Icon
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt_outlined, color: Colors.black87, size: 24),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      _buildIcon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // FAB like icon (Menu)
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
