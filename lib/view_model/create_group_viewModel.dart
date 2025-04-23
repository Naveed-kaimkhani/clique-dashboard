import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/core/api/api_endpoints.dart';
import 'package:post_krakren_dashboard/data/model/influencer_model.dart';
import 'package:post_krakren_dashboard/utils/utils.dart';
import 'package:post_krakren_dashboard/view_model/influencer_viewmodel.dart';
import 'package:uuid/uuid.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

  final userController = Get.find<UserController>();
Future<void> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    selectedImage.value = File(image.path);
  }
}
RxBool isLoading = false.obs;
Future<String?> uploadGroupImage(File imageFile) async {
  final uri = Uri.parse("${ApiEndpoints.baseUrl}/upload/image");

  try {
    isLoading.value=true;
    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      "Authorization": "Bearer ${userController.token.value}",
      "Accept": "application/json",
    });

    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> data = jsonDecode(responseBody);
     
      return data['url'] as String?;
    } else {
      
    isLoading.value=false;
      log("Upload Failed: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    
    isLoading.value=false;
    log("Upload Error: $e");
    return null;
  }
}

  RxList<String> selectedMembers = <String>[].obs;
  RxBool isSelectingMembers = false.obs;
  final searchMemberController = TextEditingController();

  var uuid = Uuid();
  // Access influencer viewmodelfinal InfluencerViewmodel influencerViewmodel = 
final InfluencerViewmodel influencerViewmodel = 
    Get.isRegistered<InfluencerViewmodel>() 
        ? Get.find() 
        : Get.put(InfluencerViewmodel());


  // Computed list of member names
  // List<InfluencerModel> get allMembers =>
  //     influencerViewmodel.influencers.map((e) => e.name ?? '').where((name) => name.isNotEmpty).toList();

List<InfluencerModel> get allMembers =>
  influencerViewmodel.influencers
      .where((e) => (e.name ?? '').isNotEmpty)
      .toList();

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

if (selectedImage.value==null) {
  Utils.showCustomSnackBar("Warning", "Please select group icon", ContentType.warning);
  return;
}
if (nameController.text.isEmpty) {
  Utils.showCustomSnackBar("Warning", "Group name is empty", ContentType.warning);
   return;
}
if (selectedImage.value != null) {
  imageUrl = await uploadGroupImage(selectedImage.value!);
}

if (imageUrl==null) {

  Utils.showCustomSnackBar("Error", "Group icon is null", ContentType.failure);
  return ;
}
    Map<String, dynamic> body = {
      "guid": v4,
      "name": nameController.text,
      "type": 'private',
      "membersCount": selectedMembers.length,
      "owner": userController.uid.toString(),
      "conversationId": "group_$v4",
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
      "icon":imageUrl,
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
          "apikey": ApiEndpoints.apiKey,
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        
    isLoading.value=false;
        Get.snackbar("Success", "Group created successfully");
      } else {
        Get.snackbar("Error", "Failed to create group");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    }
  }

}
