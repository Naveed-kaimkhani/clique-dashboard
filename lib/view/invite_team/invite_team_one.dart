

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/custom_text_field.dart';
import 'package:post_krakren_dashboard/components/label_text.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
import 'package:post_krakren_dashboard/view/invite_team/transparent_button.dart';

import '../../components/gradient_button.dart';
import '../../constants/app_routes.dart';

class InviteTeam extends StatefulWidget {
  const InviteTeam({super.key});

  @override
  State<InviteTeam> createState() => _InviteTeamState();
}

class _InviteTeamState extends State<InviteTeam> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double paddingHorizontal = size.width * 0.05;
    final double paddingVertical = size.height * 0.03;
    final double titleFontSize = size.width * 0.06;
    final double subtitleFontSize = size.width * 0.035;
    final double inputSpacing = size.height * 0.02;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            /// **Background Image**
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// **Content Layout**
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddingHorizontal,
                vertical: paddingVertical,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// **Header Section**
                  LabelText(
                    text: "Invite Your Moderator  Team",
                    fontSize:37.6,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(height: size.height * 0.015),
                  LabelText(
                    text:
                        "Once you have Moderator/s they will be able to invite users under their\naccount. Small team?\nModerators can act as users too.",
                    fontSize: 21.93,
                    weight: FontWeight.w600,
                    textColor: AppColors.grey,
                  ),
                  SizedBox(height:32),
                  LabelText(
                    text: "Invite up to 3 Moderators",
                    fontSize: 21.93,
                    weight: FontWeight.w500,
                  ),

                  SizedBox(height: size.height * 0.03),

                  /// **Input Fields**
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextField(hintText: "Email or Phone Number"),
                          SizedBox(height: inputSpacing),
                          CustomTextField(hintText: "Email or Phone Number"),
                          SizedBox(height: inputSpacing),
                          CustomTextField(hintText: "Email or Phone Number"),
                          SizedBox(height: inputSpacing),
                          CustomTextField(hintText: "Email or Phone Number"),
                          SizedBox(height: size.height * 0.05), // Extra space before buttons
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// **Bottom Buttons**
            Positioned(
              bottom: paddingVertical,
              left: paddingHorizontal,
              right: paddingHorizontal,
              child: Column(
                children: [
                  GradientButton(onTap: () {
                    Get.toNamed(RouteName.setPermissions);
                  }, text: "Send Invite"),
                  SizedBox(height: size.height * 0.015),
                  TransparentButton(text: "Skip", onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
