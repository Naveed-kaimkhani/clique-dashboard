import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/core/api/api_endpoints.dart';
import 'package:post_krakren_dashboard/view_model/influencer_viewmodel.dart';
import 'package:uuid/uuid.dart';

class CreateGroupViewModel extends GetxController {
  final guidController = TextEditingController();
  final nameController = TextEditingController();
  final groupTypeController = TextEditingController();
  final passwordController = TextEditingController();
  final iconController = TextEditingController();
  final descriptionController = TextEditingController();
  final ownerController = TextEditingController();
  final metadataController = TextEditingController();
  final tagsController = TextEditingController();

  RxList<String> selectedMembers = <String>[].obs;
  RxBool isSelectingMembers = false.obs;
  final searchMemberController = TextEditingController();

  var uuid = Uuid();

  final UserController userController = Get.find<UserController>();
  // Access influencer viewmodelfinal InfluencerViewmodel influencerViewmodel = 
final InfluencerViewmodel influencerViewmodel = 
    Get.isRegistered<InfluencerViewmodel>() 
        ? Get.find() 
        : Get.put(InfluencerViewmodel());


  // Computed list of member names
  List<String> get allMembers =>
      influencerViewmodel.influencers.map((e) => e.name ?? '').where((name) => name.isNotEmpty).toList();

  void clearAll() {
    guidController.clear();
    nameController.clear();
    groupTypeController.clear();
    passwordController.clear();
    iconController.clear();
    descriptionController.clear();
    ownerController.clear();
    metadataController.clear();
    tagsController.clear();
    selectedMembers.clear();
    searchMemberController.clear();
  }

  Future<void> createGroupAPI() async {
    final url = Uri.parse(ApiEndpoints.createGroupApi);
  var v4 = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

    Map<String, dynamic> body = {
      "guid": v4,
      "name": nameController.text.trim(),
      "type": 'public',
      "membersCount": selectedMembers.length,
      "owner": userController.uid.toString(),
      "conversationId": "group_${guidController.text.trim()}",
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
      "members": {
        "admins": [],
        "moderators": [],
        "participants": selectedMembers,
        "usersToBan": []
      }
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "apikey": "f6985bc6a317824cc687e82794955efded6bf2b1",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Group created successfully");
        print("Response: ${response.body}");
      } else {
        print("Failed: ${response.statusCode}");
        print("Response: ${response.body}");
        Get.snackbar("Error", "Failed to create group");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Exception", e.toString());
    }
  }

  Map<String, dynamic> _parseMetadata(String input) {
    try {
      return input.isNotEmpty ? jsonDecode(input) : {};
    } catch (e) {
      Get.snackbar("Invalid Metadata", "Please enter valid JSON");
      return {};
    }
  }
}
