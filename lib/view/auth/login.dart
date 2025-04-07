import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/auth_button.dart';
import 'package:post_krakren_dashboard/constants/app_routes.dart';
import 'package:post_krakren_dashboard/data/model/signup_params.dart';
import 'package:post_krakren_dashboard/utils/utils.dart';
import 'package:post_krakren_dashboard/view_model/auth_viewmodel.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final OTPViewModel otpViewModel = Get.put(OTPViewModel());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: isLargeScreen ? 500 : 350,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Forgot password action
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                AuthButton(
                  buttonText: 'Login',
                  isLoading: otpViewModel.isLoading,
                  onPressed: () async {
                    if (true) {
                      otpViewModel.isLoading.value = true;

                      final SignupParams request = SignupParams(
                        name: "",
                        // email: emailController.text,

                        email: _emailController.text,
                        phone: "",
                        role: "",
                      );

                      int statusCode = await otpViewModel.sendOTP(
                        request.email,
                      );
                      otpViewModel.isLoading.value = false;
                      if (statusCode == 200) {
                        Get.toNamed(RouteName.oTPScreen, arguments: request);
                      } else {
                        Utils.showCustomSnackBar(
                            "Error", "Failed to send OTP", ContentType.failure);
                      }
                    }
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
