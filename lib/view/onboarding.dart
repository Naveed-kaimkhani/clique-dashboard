



import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../components/index.dart';
import '../constants/app_routes.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

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
        //  SizedBox(width: 50,),
        Image.asset(AppSvgIcons.onboardIcon, width:  605,height: 644,),
          SizedBox(width: 125,),
          Column(
            children: [
              LabelText(text: "Setting up profiles", fontSize: 42, weight: FontWeight.w600 ),
              
              LabelText(text: "Post Kraken makes it easy to connect\n and manage multiple profiles, saving\n                              you time and effort.", fontSize: AppFontSize.large, weight: FontWeight.w100, textColor: const Color.fromARGB(255, 65, 64, 64)
              ,),

              SizedBox(height: 126,),
              SteppingDots( totalSteps: 2, currentStep: 0,),
              SizedBox(height: 230,),
              OnboardButton(

                onTap: () {
              Get.toNamed(RouteName.onboard2); // Navigation example
            },
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
