import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure this 
import 'index.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String message;
  final String time;

  const NotificationTile({
    super.key,
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: SvgPicture.asset(
          AppSvgIcons.notiIcon,
          fit: BoxFit.contain,
          width:71.32,
          height: 71.32,
        ),
      ),
      title: Text(
        title.trim(),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 23.77,
        ),
      ),
      subtitle: Text(
        message.trim(),
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 17.83,
        ),
      ),
      trailing: Text(
        time.trim(),
        style: const TextStyle(
          color: Colors.grey,
          fontSize:17.83,
        ),
      ),
    );
  }
}
