import 'package:flutter/material.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/contacts/presentation/widgets/contact_list_item.dart';
import 'package:hyper_focused/features/contacts/presentation/widgets/contact_stats_card.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  String _selectedFilter = 'Clients';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _allContacts = [
    {
      'name': 'Jason Johnson',
      'phone': '+1 888 224 556 2345',
      'initials': 'JJ',
      'type': 'Clients',
    },
    {
      'name': 'Alice Anderson',
      'phone': '+1 555 123 4567',
      'initials': 'AA',
      'type': 'Agents',
    },
    {
      'name': 'Brian Brown',
      'phone': '+1 444 987 6543',
      'initials': 'BB',
      'type': 'Clients',
    },
    {
      'name': 'Catherine Clark',
      'phone': '+1 333 222 9999',
      'initials': 'CC',
      'type': 'Agencies',
    },
    {
      'name': 'David Doe',
      'phone': '+1 222 555 7890',
      'initials': 'DD',
      'type': 'Clients',
    },
    {
      'name': 'Emily Evans',
      'phone': '+1 111 444 1234',
      'initials': 'EE',
      'type': 'Agents',
    },
    {
      'name': 'Frank Foster',
      'phone': '+1 777 888 3456',
      'initials': 'FF',
      'type': 'Agencies',
    },
    {
      'name': 'Grace Green',
      'phone': '+1 666 123 7890',
      'initials': 'GG',
      'type': 'Clients',
    },
    {
      'name': 'Henry Hill',
      'phone': '+1 999 888 7777',
      'initials': 'HH',
      'type': 'Agents',
    },
    {
      'name': 'Ivy Irvin',
      'phone': '+1 000 111 2222',
      'initials': 'II',
      'type': 'Agencies',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get _filteredContacts {
    return _allContacts.where((contact) {
      final matchesFilter = contact['type'] == _selectedFilter;
      final matchesSearch = contact['name']!.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesFilter && matchesSearch;
    }).toList();
  }

  int _getCountByType(String type) {
    return _allContacts.where((c) => c['type'] == type).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF5EF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // Search Bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.neutralDark.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: AppStrings.searchContacts,
                            hintStyle: TextStyle(color: AppColors.neutral400),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.search,
                              color: AppColors.neutral400,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Stats Cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFilterCard(
                            'Clients',
                            Icons.person_pin_outlined,
                          ),
                          _buildFilterCard('Agents', Icons.person_pin_outlined),
                          _buildFilterCard('Agencies', Icons.business_outlined),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // List Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your $_selectedFilter',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.neutralDark,
                            ),
                          ),
                          Row(
                            children: const [
                              Text(
                                'Recently Added',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Contact List
                      _buildContactList(),

                      // Extra spacing for bottom
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCard(String type, IconData icon) {
    final count = _getCountByType(type);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = type;
        });
      },
      child: ContactStatsCard(
        label: type,
        count: count.toString(),
        icon: icon,
        isSelected: _selectedFilter == type,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: AppColors.neutralDark,
              ),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          const Text(
            'Contacts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.neutralDark,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 16,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add, color: Colors.white, size: 20),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList() {
    final contacts = _filteredContacts;

    if (contacts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Center(
          child: Text(
            "No ${_selectedFilter.toLowerCase()} found",
            style: const TextStyle(color: AppColors.neutral500),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: contacts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ContactListItem(
          name: contact['name']!,
          phoneNumber: contact['phone']!,
          initials: contact['initials']!,
        );
      },
      separatorBuilder: (context, index) =>
          const Divider(height: 1, thickness: 1, color: AppColors.neutral200),
    );
  }
}
