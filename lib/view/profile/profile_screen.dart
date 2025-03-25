import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_krakren_dashboard/components/label_text.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
import 'package:post_krakren_dashboard/constants/app_svg_icons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  Uint8List? _profileImage;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
       body: Container(
     decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage(AppImages.backgroundImage), // Correctly loading the asset image
    fit: BoxFit.cover, // Ensures the image fills the entire container
  ),
),
child:  Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.07),

            // Profile Title
            LabelText(
              text: "Profile",
              fontSize: 37.29,
              weight: FontWeight.w600,
            ),        

            uploadProfile(_profileImage),

            // User Name & Username
            LabelText(
              text: "Ethan Kingsley",
              fontSize: 24.86,
              weight: FontWeight.w600,
            ),          LabelText(
              text: "@ethan_kingsley",
              fontSize: 18.64,
              textColor: Colors.grey,
            ),
            SizedBox(height: screenHeight * 0.04),
            Divider(),
            // Details Section
            Align(
              alignment: Alignment.centerLeft,
              child: LabelText(
                text: "Details",
                fontSize:24.86,
                weight: FontWeight.w600,
              ),          ),
            SizedBox(height: screenHeight * 0.015),

            // Details Grid
            Column(
              children: [
                ProfileDetailRow("Station", "Head Office"),
                ProfileDetailRow("Status", "Moderator"),
                ProfileDetailRow("Department", "Creative Design Dept"),
                ProfileDetailRow("Reports to", "Jennifer"),
                
              ],
            ),
          ],
        ),
      ),
      )
    );
  }
  
  Widget uploadProfile(Uint8List? image) {
    return image == null
        ? Stack(
            children: [
              Image.asset(
                AppImages.profile,
                height: 186.44,
                width: 186.44,
              ),            Positioned(
                left: 90,
                bottom: 40,
                child: IconButton(
                  onPressed: () async {
                    // Uint8List? _image = await Utils.pickImage();
                    // if (_image != null) {
                    //   setState(() {
                    //     _profileImage = _image;
                    //   });
                    // } else {
                    //   debugPrint("Image not loaded");
                    // }
                  },
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child:SvgPicture.asset(AppSvgIcons.cam),
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              CircleAvatar(
                minRadius: 40,
                maxRadius: 40,
                child: ClipOval(
                    child: Image.memory(
                  image,
                  height: 120,
                  width: 120,
                )),
                // child: ,
              ),
              Positioned(
                left: 55,
                bottom: 0,
                child: IconButton(
                  onPressed: () async {
                    // Uint8List? _image = await Utils.pickImage();

                    // if (_image != null) {
                    //   // setState(() {
                    //   //   image = _image;
                    //   // });
                    // }
                    debugPrint("Image not loaded");
                  },
                  icon: SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(AppSvgIcons.cam),
                  ),
                ),
              ),
            ],
          );
  } // for 1st image

}

// Widget for Profile Detail Rows
class ProfileDetailRow extends StatefulWidget {
  final String title;
  final String value;

  const ProfileDetailRow(this.title, this.value, {super.key});

  @override
  State<ProfileDetailRow> createState() => _ProfileDetailRowState();
}

class _ProfileDetailRowState extends State<ProfileDetailRow> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
  return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LabelText(text: widget.title, fontSize:21.75, textColor: Colors.black),
          LabelText(text: widget.value, fontSize: 21.75, weight: FontWeight.w500),
        ],    ),
    );
  }
}



