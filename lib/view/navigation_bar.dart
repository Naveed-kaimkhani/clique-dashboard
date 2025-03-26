import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/view/dashboard_home/dashboard_home.dart';
import 'package:post_krakren_dashboard/view/users_influencers/user_influencers_screens.dart';
import 'package:post_krakren_dashboard/view/products_screen/product_page.dart';
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
    // const ConnectSocials(),
    UsersInfluencersScreen(),
// ProfileScreen(),
    ProductPage(),
    VideosApprovalScreen(),
    ProductPage(),
    const CalendarScreen(),
    const ChatScreen(),
    const SettingsScreen(),
    // const PostScreen(),
    // const AccountsScreen(),
    // const HelpScreen(),
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
        const Divider(color: Colors.white54),
        _drawerItem(Icons.settings, "Annoucements", 4),
        _drawerItem(Icons.post_add, "Settings", 5),
        _drawerItem(Icons.account_circle, "Revenue", 6),
        _drawerItem(Icons.help, "Accounts Management", 7),
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

// }

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreenContent("Users/Influencers", []);
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreenContent("Calendar", []);
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreenContent("Chat", []);
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreenContent("Settings", []);
  }
}

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreenContent("Post", []);
  }
}

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreenContent("Accounts", []);
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScreenContent("Help", []);
  }
}

// Helper function to create screen content
Widget _buildScreenContent(String title, List<Widget> items) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Expanded(
          child: items.isNotEmpty
              ? ListView(children: items)
              : const Center(child: Text("No content available")),
        ),
      ],
    ),
  );
}

// Social Media Connection Tile
Widget _socialMediaTile(String platform, Color color, bool isConnected) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(Icons.check, color: Colors.white)),
      title: Text(platform),
      subtitle: Text(isConnected ? "Connected" : "Reconnect"),
      trailing: isConnected
          ? TextButton(
              onPressed: () {},
              child:
                  const Text("Disconnect", style: TextStyle(color: Colors.red)),
            )
          : null,
    ),
  );
}
