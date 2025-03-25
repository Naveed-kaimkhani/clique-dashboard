import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/components/custom_button.dart';
import 'package:post_krakren_dashboard/components/label_text.dart';
import 'package:post_krakren_dashboard/components/skip_buttton.dart';
import 'package:post_krakren_dashboard/components/stepping_dots.dart';
import 'package:post_krakren_dashboard/constants/app_fonts.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
import 'package:post_krakren_dashboard/constants/app_svg_icons.dart';
class OnboardTwo extends StatelessWidget {
  const OnboardTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
  decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage(AppImages.backgroundImage), // Correctly loading the asset image
    fit: BoxFit.cover, // Ensures the image fills the entire container
  ),
),
  child: Center(
    child:  Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      SkipButton(),
      
      SizedBox(height: 11,),
      
        Row(children: [
          Image.asset(AppSvgIcons.onboard2, width:  605,height: 644,),
          SizedBox(width: 125,),
          Column(
            children: [
              LabelText(text: "Connecting accounts", fontSize: 34, weight: FontWeight.w600 ),
              
              LabelText(text: "Connect all your accounts in one place, schedule\nposts, and analyze performance. It's social media\n                                       management, made easy.", fontSize: AppFontSize.large, weight: FontWeight.w100, textColor: const Color.fromARGB(255, 65, 64, 64)
              ,),
SizedBox(height: 126,),
              SteppingDots( totalSteps: 2, currentStep: 1,),
              SizedBox(height: 230,),
              OnboardButton(

                onTap: (){},
              ),
            ],
          )
        ],)

      ],
    ),
  ),
),

    );
  }

 
}
