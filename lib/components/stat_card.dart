import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? percentage;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final bool showProgress;
  final VoidCallback? onTap; // 👈 Add onTap parameter

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.percentage,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.showProgress = false,
        this.onTap, // 👈 Initialize onTap

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.appColor,
                  child: Icon(icon, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (percentage != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  percentage!,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
            if (showProgress)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: LinearProgressIndicator(
                  value: 0.86,
                  color: Colors.green,
                  backgroundColor: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
