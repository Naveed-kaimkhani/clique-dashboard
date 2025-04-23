import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/view/chat_screens/chat_list.dart';
import 'package:post_krakren_dashboard/view/dashboard_home/dashboard_home.dart';
import 'package:post_krakren_dashboard/view/users_influencers/user_influencers_screens.dart';
import 'package:post_krakren_dashboard/view/products_screen/product_page.dart';
import 'package:post_krakren_dashboard/view/videos_approval/delete_popstream.dart';
import 'package:post_krakren_dashboard/view/videos_approval/videos_approval.dart';

import '../components/index.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardHome(),
    UsersInfluencersScreen(),
    ProductPage(),
    VideosApprovalScreen(),
    DeletePopstream(),
    ChatList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Transparent Sidebar
          Container(
            width: 250,
            // color: const Color.fromARGB(255, 255, 253, 253),

            color: Colors.white,
            // // Adjust transparency
            child: _buildDrawer(),
          ),
          // Main Content (Changes on click)
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }

  // Sidebar Navigation Menu
  Widget _buildDrawer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Image.asset(AppSvgIcons.appLogo)),
        _drawerItem(Icons.dashboard, "Dashboard", 0),
        _drawerItem(Icons.group, "Users / Influencers", 1),
        _drawerItem(Icons.calendar_today, "Product Details", 2),
        _drawerItem(Icons.chat, "Videos Decision", 3),
                _drawerItem(Icons.chat, "Approved Popstreams", 4),
        _drawerItem(Icons.settings, "Cliques", 5),
      ],
    );
  }

  Widget _drawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon,
          color: _selectedIndex == index ? AppColors.appColor : Colors.black54),
      title: Text(
        title,
        style: TextStyle(
            color: _selectedIndex == index ? AppColors.appColor : Colors.black),
      ),
      tileColor: _selectedIndex == index
          ? Colors.blue.withOpacity(0.3)
          : Colors.transparent,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}




