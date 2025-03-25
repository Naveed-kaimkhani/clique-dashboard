import 'package:flutter/material.dart';

import 'index.dart';

class PostingDetails extends StatelessWidget {
  const PostingDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final k = SizedBox(height: MediaQuery.of(context).size.height * 0.02);
    return Container(
      height: 321.68,
      width: 499.7,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
         boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1), // Soft black shadow
      blurRadius: 10, // Spread of the shadow
      spreadRadius: 2, // How far it spreads
      offset: Offset(0, 4), // X and Y offset (creates a bottom shadow)
    ),
  ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LabelText(
                text: 'This week at a glance',
                fontSize: 18.91,
                weight: FontWeight.w500,
              ),
              LabelText(
                text: '9/2 - 9/9:',
                fontSize: 18.91,
                weight: FontWeight.w500,
              ),
            ],
          ),
          k,
          SummaryItem(
            icon: Icons.check_circle,
            iconColor: AppColors.blue,
            text: '3 Reels Published',
          ),
          k,
          SummaryItem(
            icon: Icons.check_circle,
            iconColor: AppColors.blue,
            text: '6 Facebook Posts Published',
          ),
          k,
          SummaryItem(
            icon: Icons.check_circle,
            iconColor: AppColors.blue,
            text: '5 Tik Toks Published',
          ),
          k,
          SummaryItem(
            icon: Icons.check_circle,
            iconColor: AppColors.blue,
            text: '5 Insta Post Published',
          ),
          k,
          SummaryItem(
            icon: Icons.cancel,
            iconColor: Colors.red,
            text: '1 Post Rejected',
          ),
        ],
      ),
    );
  }
}

class SummaryItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const SummaryItem({
    required this.icon,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 27.01,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        Expanded(
          child: LabelText(
            text: text,
            fontSize:18.91,
            weight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}