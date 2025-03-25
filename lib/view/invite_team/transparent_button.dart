import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:post_krakren_dashboard/components/label_text.dart';
import 'package:post_krakren_dashboard/constants/app_fonts.dart';
import 'package:post_krakren_dashboard/constants/app_svg_icons.dart';
class TransparentButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const TransparentButton({super.key, required this.onTap, required this.text});
  
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
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(37),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
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
