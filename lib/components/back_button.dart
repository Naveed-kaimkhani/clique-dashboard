import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48, // Adjust size as needed
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(16), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Subtle shadow
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:8.0),
        child: Center(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios,     size: 24,) ,
           // Bell icon
        onPressed: (){
          Get.back();
        },
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

