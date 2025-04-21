import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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
Rx<File?> selectedImage = Rx<File?>(null);

Future<void> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    selectedImage.value = File(image.path);
  }
}

Future<String?> uploadGroupImage(File imageFile) async {
  final uri = Uri.parse("https://your-api.com/upload"); // <-- replace with your actual endpoint

  try {
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      "apikey": "f6985bc6a317824cc687e82794955efded6bf2b1",
      "Accept": "application/json",
    });

    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      print("Upload Success: $data");

      // Assuming your API returns image URL in `url`
      return data['url'] ?? data['imageUrl'];
    } else {
      print("Upload Failed: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Upload Error: $e");
    return null;
  }
}
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
String? imageUrl;
if (selectedImage.value != null) {
  imageUrl = await uploadGroupImage(selectedImage.value!);
}
    Map<String, dynamic> body = {
      "guid": v4,
      "name": nameController.text.trim(),
      "type": 'private',
      "membersCount": selectedMembers.length,
      "owner": userController.uid.toString(),
      "conversationId": "group_$v4",
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
