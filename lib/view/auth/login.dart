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
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final OTPViewModel otpViewModel = Get.put(OTPViewModel());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 768;

    return Scaffold(
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
                    labelText: 'Email',
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
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Forgot password action
                    },
                    child: Text('Forgot Password?'),
                  ),
                ),
                SizedBox(height: 20),
                // SizedBox(
                //   width: double.infinity,
                //   height: 50,
                //   child: ElevatedButton(
                //     onPressed: _submitForm,
                //     child: Text(
                //       'Login',
                //       style: TextStyle(fontSize: 16),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       // primary: Colors.blueAccent,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //     ),
                //   ),
                // ),

                 AuthButton(
                buttonText: 'Login',
                isLoading: otpViewModel.isLoading,
                onPressed: ()async {
  if (true) {
  otpViewModel.isLoading.value = true;
  try {
    final SignupParams request = SignupParams(
      name: "",
      // email: emailController.text,
      
      email: _emailController.text,
      phone: _passwordController.text,
      role: "",
    );

   await otpViewModel.login(request.email, request.phone);
    
  otpViewModel.isLoading.value = false;
    // if (statusCode == 200) {
    //   Get.toNamed(RouteName.oTPScreen, arguments: request);
    // } else {
    //   Utils.showCustomSnackBar("Error", "Failed to send OTP", ContentType.failure);
    // }
  } catch (error) {
    Utils.showCustomSnackBar("Error", "Something went wrong", ContentType.failure);
  } finally {
    otpViewModel.isLoading.value = false;
  }
}
                  
                },
              ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign up
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform login action
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      
      // Here you would typically call your authentication service
      print('Logging in with: $email, $password');
      
      // Example: Get.offAll(() => HomeScreen());
    }
  }
}