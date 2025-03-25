import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_krakren_dashboard/components/index.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const GradientButton({super.key, required this.onTap, required this.text});
  
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenHeight * 0.08,
        width:screenWidth * 0.5,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 218, 251, 255),
              Color(0xFFBEE3E0),
              Color(0xFF8CD6E5),
              Color(0xFF6BCDE8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(37),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Centered Text
            LabelText(
              text: text,
              weight: FontWeight.w500,
              fontSize: AppFontSize.small,
            ),

            /// Right Aligned Icon
            Positioned(
              right: 20,
              child:  SvgPicture.asset(AppSvgIcons.send ),
            ),
          ],
        ),
      ),
    );
  }
}
