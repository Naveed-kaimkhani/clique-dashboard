import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/chat_message_widget.dart';
import 'package:post_krakren_dashboard/components/index.dart';
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/data/model/message_model.dart';
import 'package:post_krakren_dashboard/view_model/group_chat_viewModel.dart';

class GroupChatScreen extends StatefulWidget {
  final String groupName;
  final int memberCount;
  final String guid;
  final String? profileImage;

  GroupChatScreen({
    super.key,
    required this.groupName,
    this.profileImage,
    required this.memberCount,
    required this.guid,
  });

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  late GroupChatViewModel viewModel;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingOlderMessages = false;
  bool _isDesktop = false;

  @override
  void initState() {
    log(widget.guid);
    super.initState();
    final UserController userController = Get.find<UserController>();
    _isDesktop = MediaQuery.of(Get.context!).size.width > 768;

    viewModel = Get.put(GroupChatViewModel(
      groupId: widget.guid,
      token: userController.token.value,
      userId: 83.toString(),
    ));

    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent) {
      setState(() => _isLoadingOlderMessages = true);

    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    Get.delete<GroupChatViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    _isDesktop = screenSize.width > 768;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _buildGroupHeader(false),
              Expanded(child: _buildMessageList()),
              _buildChatInput(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGroupHeader(false),
        Expanded(child: _buildMessageList()),
        _buildChatInput(),
      ],
    );
  }

  Widget _buildGroupHeader(bool isSidebarHeader) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _isDesktop ? 24 : 16,
        vertical: _isDesktop ? 16 : 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: isSidebarHeader
            ? null
            : Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          if (!isSidebarHeader && !_isDesktop) ...[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: 8),
          ],
          CircleAvatar(
            radius: _isDesktop ? 24 : 20,
            backgroundImage: widget.profileImage != null
                ? NetworkImage(widget.profileImage!)
                : null,
            child: widget.profileImage == null
                ? Icon(
                    Icons.group,
                    size: _isDesktop ? 28 : 24,
                    color: AppColors.appColor,
                  )
                : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.groupName,
                  style: TextStyle(
                    fontSize: _isDesktop ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.memberCount} members',
                  style: TextStyle(
                    fontSize: _isDesktop ? 14 : 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (_isDesktop && !isSidebarHeader) ...[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                // Show group info
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Show more options
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<MessageModel>>(
      stream: viewModel.messagesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No messages found"));
        }

        final messages = snapshot.data!;

        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(
            horizontal: _isDesktop ? 24 : 16,
            vertical: 16,
          ),
          reverse: false,
          itemCount: messages.length + (_isLoadingOlderMessages ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == 0 && _isLoadingOlderMessages) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ));
            }

            final messageIndex = _isLoadingOlderMessages ? index - 1 : index;
            return ChatMessageWidget(
              message: messages[messageIndex],
              isDesktop: _isDesktop,
            );
          },
        );
      },
    );
  }

  Widget _buildChatInput() {
    TextEditingController messageController = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _isDesktop ? 24 : 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          if (_isDesktop) ...[
            // IconButton(
            //   icon: Icon(Icons.add),
            //   onPressed: () {
            //     // Add attachment
            //   },
            // ),
            // IconButton(
            //   icon: Icon(Icons.emoji_emotions_outlined),
            //   onPressed: () {
            //     // Open emoji picker
            //   },
            // ),
          ],
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxHeight: 120),
              child: TextField(
                controller: messageController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: _isDesktop ? 16 : 12,
                  ),
                ),
                onSubmitted: (message) {
                  // viewModel.sendMessage(message).then((_) => _scrollToBottom());
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              // Handle send
              if (messageController.text.isEmpty) {
                return;
              }
              messageController.text.isEmpty
                  ? null
                  : await viewModel
                      .sendMessage(messageController.text)
                      .then((_) => _scrollToBottom());
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
