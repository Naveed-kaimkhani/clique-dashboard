import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'index.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(163, 222, 229, 243),
        borderRadius: BorderRadius.circular(12),
        
      ),
      child: Row(
        children: [
          // Morning text with sun icon
          Row(
            children: [
             Text(
                "Good Morning",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
                  SizedBox(width: 8), // S
                // Icon(Icons.wb_sunny, color: Colors.amber), // Sun icon
SvgPicture.asset(AppSvgIcons.sun)
             
            ],
          ),
          // Spacer(), // Takes up remaining space

          // Search bar with shadow
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search here",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // Notification icon, profile picture, and username
          Row(
            children: [
              // Icon(Icons.notifications, color: Colors.grey),
              // NotificationIcon(), // Notification icon
              SvgPicture.asset(AppSvgIcons.notiIcon),
              SizedBox(width: 16), // Spacing
              CircleAvatar(
                backgroundImage: AssetImage(AppImages.profile), // Replace with your image asset
                radius: 16,
              ),
              SizedBox(width: 8), // Spacing
              Text(
                "Rohaan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ResponsiveAppBar extends StatelessWidget {
  const ResponsiveAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // For larger screens (e.g., tablets, desktops)
          return CustomAppBar();
        } else {
          // For smaller screens (e.g., mobile)
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Morning text with sun icon
                Row(
                  children: [
                    Icon(Icons.wb_sunny, color: Colors.amber),
                    SizedBox(width: 8),
                    Text(
                      "Good Morning",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Search bar with shadow
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search here",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Notification icon, profile picture, and username
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.notifications, color: Colors.grey),
                    SizedBox(width: 16),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/profile_picture.png"), // Replace with your image asset
                      radius: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Rohaan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
