

// after responsive 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/custom_toggle_tabs.dart';
import 'package:post_krakren_dashboard/components/gradient_button.dart';
import 'package:post_krakren_dashboard/components/label_text.dart';
import 'package:post_krakren_dashboard/components/noti_icon.dart';
import 'package:post_krakren_dashboard/components/profile_container.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
import 'package:post_krakren_dashboard/constants/app_routes.dart';

class TeamManagementScreen extends StatefulWidget {
  TeamManagementScreen({super.key});

  @override
  State<TeamManagementScreen> createState() => _TeamManagementScreenState();
}

class _TeamManagementScreenState extends State<TeamManagementScreen> {
  final PageController controller = PageController(viewportFraction: 0.8, keepPage: true);

  final List<Map<String, dynamic>> users = [
    {
      "name": "Ethan Kingsley",
      "username": "@ethan_kingsley",
      "lastPost": "09/23/2024",
      "image": AppImages.profile,
      "isActive": true,
    },
    {
      "name": "Kate Smith",
      "username": "@kate_smith",
      "lastPost": "09/02/2024",
      "image": AppImages.profile,
      "isActive": true,
    },
    {
      "name": "Jennifer",
      "username": "@jenny",
      "lastPost": "09/23/2024",
      "image": AppImages.profile,
      "isActive": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
   
    // Get the screen size
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05, top: screenHeight * 0.05, right: screenWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelText(
                          text: "Team Management",
                          fontSize: 24, // Adjust font size relative to screen width
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                    NotificationIcon(),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                CustomToggleTabs(),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    LabelText(
                      text: "Fresh Press Mesa",
                      fontSize:21, // Adjust font size relative to screen width
                      weight: FontWeight.w500,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_down, size: 36,),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                  height: screenHeight * 0.35, // Adjust list height relative to screen height
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(RouteName.teamStatsScreen);
                              },
                              child: ProfileContainer(imagePath: user["image"])),
                            SizedBox(width: screenWidth * 0.04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LabelText(
                                    text: user["name"],
                                    weight: FontWeight.w600,
                                    fontSize:14, // Adjust font size
                                  ),
                                  LabelText(
                                    text: user["username"],
                                    weight: FontWeight.w400,
                                    fontSize: 12, // Adjust font size
                                    textColor: Colors.grey.shade600,
                                  ),
                                  Text(
                                    "last post: ${user["lastPost"]}",
                                    style: TextStyle(
                                      fontSize: 12, // Adjust font size
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: user["isActive"],
                              onChanged: (value) {
                                setState(() {
                                  users[index]["isActive"] = value;
                                });
                              },
                              activeColor: Colors.white,
                              activeTrackColor: AppColors.blue,
                              inactiveTrackColor: Colors.grey.shade400,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                LabelText(
                  text: "Invite new Moderators:",
                  fontSize:20, // Adjust font size
                  weight: FontWeight.w500,
                ),
                
                SizedBox(height: screenHeight * 0.03),
                GradientButton(onTap: (){
                  
                  Get.toNamed(RouteName.inviteTeam);
                }, text: "Invite"),
                SizedBox(height: screenHeight * 0.02),
                // CustomSearchBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}