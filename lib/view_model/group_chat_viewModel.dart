import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/core/api/api_client.dart';
import 'package:post_krakren_dashboard/core/api/api_endpoints.dart';
import 'package:post_krakren_dashboard/data/model/message_model.dart';

class GroupChatViewModel extends GetxController {
  final String groupId;
  final String token;
  final String userId;

  GroupChatViewModel({
    required this.groupId,
    required this.token,
    required this.userId,
  });

  final StreamController<List<MessageModel>> _messageController =
      StreamController<List<MessageModel>>.broadcast();
  Stream<List<MessageModel>> get messagesStream => _messageController.stream;

  final ApiClient apiClient = Get.find<ApiClient>();
  Timer? _timer;
  bool _isLoading = false;
  bool hasMoreMessages = true;
  List<MessageModel> _messages = [];

  @override
  void onInit() {
    super.onInit();
    _fetchInitialMessages(); // Fetch initial 20 messages
    _timer = Timer.periodic(
        Duration(milliseconds: 800), (timer) => _fetchMessages(false));
  }

  @override
  void onClose() {
    _timer?.cancel();
    _messageController.close();
    super.onClose();
  }

  // Fetch initial 20 messages
  Future<void> _fetchInitialMessages() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final response = await ApiClient.getMessages(
        url:
            "https://dev.moutfits.com/api/v1/cometchat/groups/$groupId/messages?limit=20",
        headers: {"Authorization": "Bearer $token"},
      );
      log(response.body);

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey("messages")) {
          final messagesData = responseData["messages"];

          if (messagesData is List && messagesData.isNotEmpty) {
            _messages = messagesData
                .map((msg) => MessageModel.fromJson({...msg, 'userId': userId}))
                .toList()
                .reversed
                .toList(); // Reverse to show latest messages first

            _messageController.add(_messages);
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching initial messages: $e");
    } finally {
      _isLoading = false;
    }
  }

  Future<void> _fetchMessages(bool loadMore) async {
    if (_isLoading || (loadMore && !hasMoreMessages)) return;
    _isLoading = true;
    if (loadMore) {
      log("loading more messages");
    }
    try {
      String apiUrl =
          "https://dev.moutfits.com/api/v1/cometchat/groups/$groupId/messages";

      if (loadMore && _messages.isNotEmpty) {
        // Fetch older messages with timestamp parameter and limit of 200
        int lastMessageTimestamp =
            _messages.first.time; // Timestamp of the oldest message
        apiUrl +=
            "?limit=200&timeStamp=$lastMessageTimestamp-${8000}"; // Use limit=200 for older messages
        log("limit added");
      } else {
        // Fetch initial messages with limit of 20
        apiUrl += "?limit=10";
      }

      final response = await ApiClient.getMessages(
        url: apiUrl,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey("messages")) {
          final messagesData = responseData["messages"];

          if (messagesData is List && messagesData.isNotEmpty) {
            final List<MessageModel> newMessages = messagesData
                .map((msg) => MessageModel.fromJson({...msg, 'userId': userId}))
                .toList();

            if (loadMore) {
              _messages.insertAll(
                  0, newMessages); // Add older messages at the start
            } else {
              _messages =
                  newMessages.reversed.toList(); // Show latest messages first
            }

            _messageController.add(_messages);
          } else {
            hasMoreMessages = false; // No more messages to load
          }
        }
      }
    } catch (e) {
      debugPrint("Error fetching messages: $e");
    } finally {
      _isLoading = false;
    }
  }

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    try {
      final response = await apiClient.post(
        url: ApiEndpoints.sendMessage,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "apikey": "f6985bc6a317824cc687e82794955efded6bf2b1",
          "onBehalfOf": userId,
        },
        body: jsonEncode({
          "category": "message",
          "type": "text",
          "data": {
            "text": message,
          },
          "receiver": groupId,
          "receiverType": "group",
        }),
      );
      log("message sent");
      log(response.body);
      if (response.statusCode == 200) {
        _fetchMessages(false); // Refresh messages after sending a new one
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to send message: $e");
    }
  }
}
