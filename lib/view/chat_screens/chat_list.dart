

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/data/model/group_model.dart';
import 'package:post_krakren_dashboard/view/chat_screens/chat_screen.dart';
import 'package:post_krakren_dashboard/view_model/discover_viewmodel.dart';

class ChatList extends StatelessWidget {
  final DiscoverViewModel _viewModel = Get.put(DiscoverViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Groups',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 768;

    return Obx(() {
      if (_viewModel.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (_viewModel.error.value.isNotEmpty) {
        return Center(child: Text(_viewModel.error.value));
      }

      if (_viewModel.groups.isEmpty) {
        return Center(child: Text("No Groups Available"));
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: isDesktop ? 16 : 8,
          horizontal: isDesktop ? 24 : 8,
        ),
        itemCount: _viewModel.groups.length,
        itemBuilder: (context, index) {
          final group = _viewModel.groups[index];
          return _buildChatListItem(context, group, isDesktop);
        },
      );
    });
  }

  Widget _buildChatListItem(BuildContext context, Group group, bool isDesktop) {
    final size = MediaQuery.of(context).size;
    
    // Responsive sizing
    final double horizontalPadding = isDesktop ? 16 : size.width * 0.03;
    final double verticalPadding = isDesktop ? 8 : size.height * 0.01;
    final double profileImageSize = isDesktop ? 48 : size.width * 0.11;
    final double fontSize = isDesktop ? 14 : size.width * 0.04;
    final double borderRadius = isDesktop ? 8 : size.width * 0.025;
    final double shadowBlur = isDesktop ? 6 : size.width * 0.02;
    final double shadowSpread = isDesktop ? 1 : size.width * 0.005;
    final Offset shadowOffset = isDesktop ? Offset(1, 2) : Offset(size.width * 0.005, size.width * 0.01);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: shadowBlur,
            spreadRadius: shadowSpread,
            offset: shadowOffset,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: isDesktop ? 0 : horizontalPadding,
        vertical: isDesktop ? 8 : verticalPadding,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupChatScreen(
                  profileImage: group.icon,
                  guid: group.guid,
                  groupName: group.name,
                  memberCount: group.membersCount,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 16 : horizontalPadding * 1.3,
              vertical: isDesktop ? 12 : verticalPadding * 1.5,
            ),
            child: Row(
              children: [
                // Profile Image
                Container(
                  height: profileImageSize,
                  width: profileImageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: group.icon != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(group.icon!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: group.icon == null ? Colors.grey[300] : null,
                  ),
                  child: group.icon == null
                      ? Icon(Icons.group,
                          size: profileImageSize * 0.6, color: Colors.grey[600])
                      : null,
                ),
                SizedBox(width: isDesktop ? 16 : 12),
                // Group Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${group.membersCount} members',
                        style: TextStyle(
                          fontSize: fontSize * 0.9,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // Desktop-only additional info
                if (isDesktop) ...[
                  SizedBox(width: 16),
                  Text(
                    'Active now',
                    style: TextStyle(
                      fontSize: fontSize * 0.85,
                      color: Colors.green,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}