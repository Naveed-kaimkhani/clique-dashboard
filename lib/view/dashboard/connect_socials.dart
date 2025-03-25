import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:post_krakren_dashboard/components/gradient_button.dart';
import 'package:post_krakren_dashboard/components/label_text.dart';
import 'package:post_krakren_dashboard/components/socials_widget.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
import 'package:post_krakren_dashboard/constants/app_svg_icons.dart';
import 'package:post_krakren_dashboard/view/team_management/manage_team.dart';

class ConnectSocials extends StatelessWidget {
  const ConnectSocials({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    final k = SizedBox(height: screenHeight * 0.02); // Dynamic spacing

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800), // Limit content width for larger screens
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  Center(
                    child: LabelText(
                      text: "Connect Your Socials",
                      fontSize: 35, // Adaptive text size
                      weight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  
                  // Socials Widgets
                  SocialsWidget(picture: AppSvgIcons.facebook, connectText: "Connect", disconnectText: "Disconnect"),
                  k,
                  SocialsWidget(picture: AppSvgIcons.insta, connectText: "Connect", disconnectText: "Disconnect"),
                  k,
                  SocialsWidget(picture: AppSvgIcons.tiktok, connectText: "Connect", disconnectText: "Disconnect"),
                  k,
                  SocialsWidget(picture: AppSvgIcons.youtube, connectText: "Connect", disconnectText: ""),
                  k,
                  SocialsWidget(picture: AppSvgIcons.linkedin, connectText: "Connect", disconnectText: ""),
                  k,
                  SocialsWidget(picture: AppSvgIcons.drive, connectText: "Connect", disconnectText: ""),
                  k,
                  
                  SizedBox(height: screenHeight * 0.05),

                  // Next Button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GradientButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ManageTeam()),
                        );
                      },
                      text: "Save",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
