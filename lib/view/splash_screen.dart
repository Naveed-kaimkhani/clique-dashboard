
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/index.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [SvgPicture.asset(AppSvgIcons.appLogo,
      width:  436,
      height: 303.21,
        ),
        SizedBox(height: 122,),
        LabelText(text: "Post Kraken", fontSize: 45, weight: FontWeight.w600,),
     
      ],
    )
  ),
),

    );
  }

 
}
