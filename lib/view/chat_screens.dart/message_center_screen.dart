import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
class MessageCenterScreen extends StatelessWidget {
  MessageCenterScreen({super.key});

  final List<Map<String, dynamic>> chatList = [
    {
      'name': 'Ethan Kingsley',
      'message': 'Hey, how is it going today',
      'time': '04:50 PM',
      'image': AppImages.profile, // Replace with actual image
      'isUnread': true
    },
    {
      'name': 'Kate Smith',
      'message': 'Hey, how is it going today',
      'time': '04:50 PM',
      'image': AppImages.profile, // Replace with actual image
      'isUnread': false
    },
    {
      'name': 'John Doe',
      'message': 'Hey, how is it going today',
      'time': '04:50 PM',
      'image': AppImages.profile, // Replace with actual image
      'isUnread': false
    },
    {
      'name': 'Jenifer',
      'message': 'Hey, how is it going today',
      'time': '04:50 PM',
      'image': AppImages.profile, // Replace with actual image
      'isUnread': false
    },
    {
      'name': 'Ethan Kingsley',
      'message': 'Hey, how is it going today',
      'time': '04:50 PM',
      'image': AppImages.profile, // Replace with actual image
      'isUnread': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
         decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              
          
                  padding: EdgeInsets.only(left: 20,top: 32),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Message Center",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 24,),
                DefaultTabController(
                  length: 3,
                  child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      gradient: AppColors.appGradientColors,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    tabAlignment: TabAlignment.start,
                    dividerColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.symmetric(horizontal: 4),
                    tabs: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("Chat"),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("Groups"),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Tab(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text("Fresh Press Mesa"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 37),
                Expanded(
                  child: ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      return ChatTile(
                        name: chatList[index]['name'],
                        message: chatList[index]['message'],
                        time: chatList[index]['time'],
                        image: chatList[index]['image'],
                        isUnread: chatList[index]['isUnread'],
                      );
                    },
                  ),
                ),
              ],
            ),
            )
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.lightBlueAccent : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String image;
  final bool isUnread;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.image,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(image),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(message),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (isUnread)
                const CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.blue,
                  child: Text(
                    '2',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8,),
        const Divider(thickness: 0.3,), // Adds a line between chat tiles
      
        SizedBox(height: 8,),
      ],
    );
  }
}
