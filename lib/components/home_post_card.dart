

import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/components/index.dart';

class HomePostCard extends StatelessWidget {
  const HomePostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
       
        return Container(
          width: 210,
          height: 279,
          margin: const EdgeInsets.only(right:  18.0 , top: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10), // Dynamic padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Row
                Row(
                  children: [
                    Image.asset(AppImages.profile,height: 38,width: 38,),
                    // SizedBox(width: cardWidth * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelText(
                            text: "By Ethan K.",
                            fontSize:13.61,
                            weight: FontWeight.w500,
                          ),
                          LabelText(
                            text: "9/10/2024",
                            fontSize:11.67,
                            textColor: Colors.grey,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),

                // Image Section
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    AppImages.post,
                    height: 80.31, // Responsive height
                    width: 167.27,
                    fit: BoxFit.cover,
                  ),
                ),
                // SizedBox(height: cardHeight * 0.05),

                // SizedBox(height: 2),
                // Footer Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabelText(
                      text: "Instagram",
                      fontSize: 13.61,
                      weight: FontWeight.w400,
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.black54,
                      size:23.34,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
