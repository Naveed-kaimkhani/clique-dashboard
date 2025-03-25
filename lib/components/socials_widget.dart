import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'index.dart';

class SocialsWidget extends StatelessWidget {
    final String picture; // Asset path for the picture
  final String connectText; // Text for connecting
  final String disconnectText; // Text for disconnecting

  const SocialsWidget({
    super.key,
    required this.picture,
    required this.connectText,
    required this.disconnectText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            width: 896,
            height: 63,
            decoration: BoxDecoration(
              color: Colors.transparent, // Transparent background
              border: Border.all(
                 color: Color.fromRGBO(204, 204, 204, 1), // Border color
                // width: 3.0,         // Border width
              ),
              borderRadius: BorderRadius.circular(16), // Optional: Rounded border
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 22),
              child: Row( 
                children: [
              //  SizedBox(width: 22,) ,
                 SvgPicture.asset(picture),
                 SizedBox(width: 8,),
                  LabelText(text: connectText, fontSize: 20, ),
                  SizedBox(width: 340,),
                  LabelText(text: disconnectText, fontSize: 16,textColor: Colors.red,)
                  
                ],
              ),
            ),
          );
  }
}



class SocialsWidgetDisconnected extends StatelessWidget {
  final String picture; // Asset path for the picture
  final String connectText; // Text for connecting

  const SocialsWidgetDisconnected({
    super.key,
    required this.picture,
    required this.connectText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.transparent, // Transparent background
        border: Border.all(
          color: Color.fromRGBO(204, 204, 204, 1), // Border color
          // width: 3.0,         // Border width
        ),
        borderRadius: BorderRadius.circular(16), // Optional: Rounded border
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 22),
        child: Row(
          children: [
            //  SizedBox(width: 22,) ,
            SvgPicture.asset(picture),
            SizedBox(width: 8,),
            LabelText(text: connectText, fontSize: AppFontSize.xsmall, ),
            SizedBox(width: 108,),

          ],
        ),
      ),
    );
  }
}