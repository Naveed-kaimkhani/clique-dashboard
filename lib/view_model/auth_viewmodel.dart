import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/constants/app_routes.dart';
import 'package:post_krakren_dashboard/data/model/otp_request_model.dart';
import 'package:post_krakren_dashboard/data/repositories/auth_repo.dart';
import 'package:post_krakren_dashboard/utils/utils.dart';

class OTPViewModel extends GetxController {
  var isLoading = false.obs;
  var otpResponse = "".obs;

  final AuthRepository _authRepo = Get.find<AuthRepository>();
  Future<void> verifyOtp(String email, String otp) async {
    isLoading.value = true;
    OTPRequestModel requestModel = OTPRequestModel(email:email , otp: otp);

    OTPResponseModel response = await _authRepo.verifyOTP(requestModel);
    otpResponse.value = response.message;

    if (response.success) {
     Utils.showCustomSnackBar("Success",  response.message, ContentType.success);
      Get.offAllNamed(RouteName.dashboardScreen);
    } else {
         Utils.showCustomSnackBar("Error",  response.message, ContentType.failure);
  
    }
    
    isLoading.value = false;
  }
    Future<int> sendOTP(String phone) async {
      log("in send otp");
    int response = await _authRepo.SendOTP(phone);

  return response;
    
    
  }
}
