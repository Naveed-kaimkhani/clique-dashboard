import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:post_krakren_dashboard/components/index.dart';
import 'package:post_krakren_dashboard/data/model/signup_params.dart';
import 'package:post_krakren_dashboard/view_model/auth_viewmodel.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final OTPViewModel otpViewModel = Get.put(OTPViewModel());
  final SignupParams signupParams = Get.arguments;
  final RxString currentOtp = "".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 600 ? 100 : 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Enter OTP",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "We’ve sent an OTP to your email",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 32),

                    // 🔢 OTP Input Field
                    PinCodeTextField(
                      length: 6,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                      animationType: AnimationType.fade,
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      onChanged: (value) {
                        currentOtp.value = value;
                      },
                      onCompleted: (value) {
                        currentOtp.value = value;
                        otpViewModel.verifyOtp(
                            signupParams.email, currentOtp.value);
                      },
                      mainAxisAlignment:
                          MainAxisAlignment.center, // 👈 This controls spacing

                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 48,
                        activeFillColor: Colors.white,
                        inactiveColor: Colors.grey.shade400,
                        activeColor: AppColors.black,
                        selectedColor: Colors.black,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                      enableActiveFill: true,
                    ),

                    const SizedBox(height: 32),

                    ElevatedButton(
                    
                      onPressed: () {
                        final otp = currentOtp.value;
                        if (otp.length == 6) {
                          otpViewModel.verifyOtp(signupParams.email, otp);
                        } else {
                          Get.snackbar("Invalid OTP",
                              "Please enter a valid 6-digit OTP.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.shade100,
                              colorText: Colors.black);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Verify",
                        style:
                            TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
