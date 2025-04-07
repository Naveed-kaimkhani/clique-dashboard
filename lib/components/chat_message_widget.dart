import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/data/model/message_model.dart';
import '../constants/app_colors.dart';

class ChatMessageWidget extends StatelessWidget {
  final MessageModel message;
  final bool isDesktop;

  const ChatMessageWidget({
    super.key,
    required this.message,
    this.isDesktop = false,
  });

  String _formatTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    return '${hour == 0 ? 12 : hour}:${date.minute.toString().padLeft(2, '0')} $amPm';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768 || this.isDesktop;

    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isDesktop ? screenWidth * 0.3 : screenWidth * 0.75,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: isDesktop ? 12 : 8,
            horizontal: isDesktop ? 16 : 8,
          ),
          padding: EdgeInsets.all(isDesktop ? 20 : 16),
          decoration: BoxDecoration(
            gradient: message.isMe
                ? AppColors.appGradientColors
                : LinearGradient(colors: [Colors.white, Colors.white]),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: message.isMe
                  ? const Radius.circular(16)
                  : const Radius.circular(4),
              bottomRight: message.isMe
                  ? const Radius.circular(4)
                  : const Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!message.isMe) ...[
                Row(
                  children: [
                    if (isDesktop) ...[
                      // CircleAvatar(
                      //   radius: 16,
                      //   backgroundImage: message.senderAvatar != null
                      //       ? NetworkImage(message.senderAvatar!)
                      //       : null,
                      //   child: message.senderAvatar == null
                      //       ? const Icon(Icons.person, size: 16)
                      //       : null,
                      // ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      message.sender,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isDesktop ? 16 : 14,
                        color: message.isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              Text(
                message.message,
                style: TextStyle(
                  fontSize: isDesktop ? 16 : 14,
                  color: message.isMe ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatTimestamp(message.time),
                    style: TextStyle(
                      fontSize: isDesktop ? 12 : 10,
                      color: message.isMe
                          ? Colors.white.withOpacity(0.8)
                          : Colors.black.withOpacity(0.6),
                    ),
                  ),
                  // if (message.isMe && message.status != null)
                  //   Icon(
                  //     _getStatusIcon(message.status!),
                  //     size: isDesktop ? 16 : 14,
                  //     color: message.isMe
                  //         ? Colors.white.withOpacity(0.8)
                  //         : Colors.black.withOpacity(0.6),
                  //   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'sent':
        return Icons.check;
      case 'delivered':
        return Icons.done_all;
      case 'read':
        return Icons.done_all;
      default:
        return Icons.access_time;
    }
  }
}
