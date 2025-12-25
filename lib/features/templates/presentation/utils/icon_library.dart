import 'package:flutter/material.dart';

class IconCategory {
  final String name;
  final List<IconItem> icons;

  const IconCategory({required this.name, required this.icons});
}

class IconItem {
  final String label;
  final IconData icon;

  const IconItem({required this.label, required this.icon});
}

class IconLibrary {
  static const List<IconCategory> categories = [
    IconCategory(
      name: 'Building & Structure',
      icons: [
        IconItem(label: 'Home', icon: Icons.home_outlined),
        IconItem(label: 'Building', icon: Icons.apartment_outlined),
        IconItem(label: 'Building2', icon: Icons.domain_outlined),
        IconItem(label: 'House', icon: Icons.house_outlined),
        IconItem(label: 'Warehouse', icon: Icons.warehouse_outlined),
        IconItem(label: 'Castle', icon: Icons.fort_outlined),
        IconItem(label: 'Church', icon: Icons.church_outlined),
        IconItem(label: 'School', icon: Icons.school_outlined),
        IconItem(label: 'Hospital', icon: Icons.local_hospital_outlined),
        IconItem(label: 'Factory', icon: Icons.factory_outlined),
        IconItem(label: 'Tent', icon: Icons.holiday_village_outlined),
        IconItem(label: 'TreePine', icon: Icons.forest_outlined),
        IconItem(label: 'Mountain', icon: Icons.landscape_outlined),
        IconItem(label: 'Fence', icon: Icons.fence_outlined),
        IconItem(label: 'Landmark', icon: Icons.account_balance_outlined),
        IconItem(label: 'MapPin', icon: Icons.location_on_outlined),
        IconItem(label: 'Navigation', icon: Icons.navigation_outlined),
        IconItem(label: 'Compass', icon: Icons.explore_outlined),
        IconItem(label: 'Map', icon: Icons.map_outlined),
        IconItem(label: 'Route', icon: Icons.route_outlined),
        IconItem(label: 'Signpost', icon: Icons.directions_outlined),
      ],
    ),
    IconCategory(
      name: 'Tools & Equipment',
      icons: [
        IconItem(label: 'Wrench', icon: Icons.build_outlined),
        IconItem(label: 'Hammer', icon: Icons.handyman_outlined),
        IconItem(label: 'Screwdriver', icon: Icons.construction_outlined),
        IconItem(label: 'Drill', icon: Icons.home_repair_service_outlined),
        IconItem(label: 'Saw', icon: Icons.carpenter_outlined),
        IconItem(label: 'PaintBucket', icon: Icons.format_paint_outlined),
        IconItem(label: 'Brush', icon: Icons.brush_outlined),
        IconItem(label: 'Ruler', icon: Icons.straighten_outlined),
        IconItem(label: 'Triangle', icon: Icons.change_history_outlined),
        IconItem(label: 'Square', icon: Icons.crop_square_outlined),
        IconItem(label: 'Gauge', icon: Icons.speed_outlined),
        IconItem(label: 'Scale', icon: Icons.balance_outlined),
        IconItem(label: 'Timer', icon: Icons.timer_outlined),
        IconItem(label: 'Calculator', icon: Icons.calculate_outlined),
        IconItem(label: 'Flashlight', icon: Icons.flashlight_on_outlined),
        IconItem(label: 'Zap', icon: Icons.bolt_outlined),
        IconItem(label: 'Bolt', icon: Icons.settings_outlined), // Closest to bolt/nut
        IconItem(label: 'Plug', icon: Icons.power_outlined),
        IconItem(label: 'Cable', icon: Icons.cable_outlined),
      ],
    ),
  ];
}
