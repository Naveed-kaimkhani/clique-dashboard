import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int adminLikes;
  final int userSubmissions;
  final String graph;
  final Color color;

  const StatCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.adminLikes,
    required this.userSubmissions,
    required this.graph,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 262,
      height: 181,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(

            children: [
            Column(
              children: [
                  Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
              ],
            ),
               SizedBox(
            height: 50,
            child: SvgPicture.asset(graph,height: 50,width: 50,),
          ),
            ],
          ),
        
          SizedBox(height: 10),
         
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admin Likes",
                style: TextStyle(fontSize: 12, color: Colors.black87,fontWeight: FontWeight.w400),
              ),
              Text(
                "$adminLikes",
                style: TextStyle(fontSize: 12
, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "User Submissions",
                style: TextStyle(fontSize: 12, color: Colors.black87,fontWeight: FontWeight.w400),
              ),
              Text(
                "$userSubmissions",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
