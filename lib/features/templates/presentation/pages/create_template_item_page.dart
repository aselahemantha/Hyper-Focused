import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/add_item_dialog.dart';
import 'dart:ui';

class CreateTemplateItemPage extends StatefulWidget {
  final String categoryName;
  final String subCategoryName;

  const CreateTemplateItemPage({
    super.key,
    required this.categoryName,
    required this.subCategoryName,
  });

  @override
  State<CreateTemplateItemPage> createState() => _CreateTemplateItemPageState();
}

class _CreateTemplateItemPageState extends State<CreateTemplateItemPage> {
  final List<String> _items = [];
  bool _isEditing = false;

  void _addItem(String itemName) {
    setState(() {
      _items.add(itemName);
    });
  }

  void _updateItemName(int index, String newName) {
    setState(() {
      _items[index] = newName;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
      if (_items.isEmpty) {
        _isEditing = false;
      }
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _showAddItemDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const AddItemDialog(),
    );

    if (result != null) {
      _addItem(result);
    }
  }

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
        title: Column(
          children: [
             RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.neutralDark,
                ),
                children: [
                  TextSpan(text: 'Create a New Template '),
                  WidgetSpan(
                    child: Icon(Icons.arrow_forward, size: 12, color: AppColors.neutralDark),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(text: ' Step 3'),
                ],
              ),
            ),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: AppColors.neutralDark,
                    fontSize: 14, // Slightly smaller to fit breadcrumbs
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(text: 'Main Categories '),
                    const WidgetSpan(
                      child: Icon(Icons.keyboard_arrow_right, size: 16, color: AppColors.neutralDark),
                      alignment: PlaceholderAlignment.middle,
                    ),
                    TextSpan(text: ' ${widget.categoryName} '),
                    const WidgetSpan(
                      child: Icon(Icons.keyboard_arrow_right, size: 16, color: AppColors.neutralDark),
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
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 14,
              child: const Icon(Icons.info_outline, color: Colors.white, size: 18),
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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  const Text(
                    'You can manage your services here. These services will be shown on your website.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.neutral500,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Cover Image Placeholder
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.image_outlined, size: 48, color: AppColors.neutralDark),
                        const SizedBox(height: 8),
                        const Text(
                          'Cover Image Position',
                          style: TextStyle(
                            color: AppColors.neutral500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // General Info Item
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.neutral500),
                        const SizedBox(width: 12),
                        const Text(
                          'General Info (Default)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.neutralDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Items
                  ..._items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // No icon logic requested for items, just name
                             Expanded(
                              child: _isEditing 
                                ? TextField(
                                      controller: TextEditingController(text: item)
                                      ..selection = TextSelection.collapsed(offset: item.length),
                                      onChanged: (val) => _updateItemName(index, val),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.neutralDark,
                                      ),
                                    )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.neutralDark,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.push(
                                            '/create-template/step-2/sub-sections/items/details',
                                            extra: {
                                              'categoryName': widget.categoryName,
                                              'subCategoryName': widget.subCategoryName,
                                              'itemName': item,
                                            },
                                          );
                                        },
                                        child: const Text(
                                          'Create Details',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                            if (_isEditing)
                                IconButton(
                                  icon: const Icon(Icons.remove, color: Colors.red),
                                  onPressed: () => _removeItem(index),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                )
                          ],
                        ),
                      ),
                    );
                  }),

                  // Add New Item Button
                  if (!_isEditing)
                  GestureDetector(
                    onTap: () => _showAddItemDialog(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.neutral100,
                           width: 1.5,
                           style: BorderStyle.none // User request image has dotted/dashed border or simple? Image looks like dashed/dotted white. 
                           // Actually standard code used 'border: Border.all(color: AppColors.neutral100, style: BorderStyle.solid)' in previous pages.
                           // Image 1 shows a dotted/glowy border? 
                           // I'll stick to consistency with previous pages unless specifically asked for "dotted".
                           // Wait, the user said "Same functionalities but In the add item pop up...".
                           // Code in prev pages used solid border. I'll stick to solid for now to match exactly what I wrote before, 
                           // or I can try to mimic the "dotted" look if I had a dotted border package, but standard Border doesn't do dotted easily without custom painter.
                           // I'll stick to the style I established in Step 2.
                        ),
                      ),
                      // Actually, let's look at the previous code for "Add New Section" button style.
                      // decoration: BoxDecoration(color: AppColors.neutralWhite.withOpacity(0.5), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.neutral100, style: BorderStyle.solid)),
                      // I'll copy that.
                     child: const Center(
                        child: Text(
                          'Click to add a New Item',
                          style: TextStyle(
                            color: AppColors.neutral500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Bottom Bar
              Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 70,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(35),
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
                                  icon: const Icon(Icons.arrow_back, color: AppColors.neutralDark, size: 28),
                                  onPressed: () => context.pop(),
                                ),
                                if (_isEditing)
                                   IconButton(
                                    icon: const Icon(Icons.check, color: AppColors.neutralDark, size: 28),
                                    onPressed: () => _toggleEditMode(),
                                  )
                                else 
                                  IconButton(
                                  icon: const Icon(Icons.save_outlined, color: AppColors.neutralDark, size: 28),
                                  onPressed: () {},
                                ),
                                if (_isEditing)
                                   IconButton(
                                    icon: const Icon(Icons.save_outlined, color: AppColors.neutralDark, size: 28),
                                    onPressed: () {
                                      _toggleEditMode();
                                    },
                                  )
                                else if (_items.isNotEmpty)
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined, color: AppColors.neutralDark, size: 28),
                                    onPressed: () => _toggleEditMode(),
                                  ),
                                if (!_isEditing)
                                IconButton(
                                  icon: const Icon(Icons.add, color: AppColors.neutralDark, size: 28),
                                  onPressed: () => _showAddItemDialog(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector( // Keeping the menu for consistency, though maybe not strictly needed for this sub-view? Design keeps it usually.
                      onTap: () => _showMenuModal(context),
                      child: Container(
                        width: 70,
                        height: 70,
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
                        child: const Icon(Icons.menu, color: AppColors.neutralDark, size: 30),
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
        margin: const EdgeInsets.all(16),
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
              title: const Text('Edit Items'),
              onTap: () {
                context.pop();
                 if (_items.isNotEmpty) _toggleEditMode();
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.grid_view, color: AppColors.neutral500),
              title: const Text('New Item'), // "Item" vs "Section"
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
}
