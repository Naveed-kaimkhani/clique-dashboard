
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/constants/app_images.dart';
import 'package:post_krakren_dashboard/controllers/user_controller.dart';
import 'package:post_krakren_dashboard/view/auth/login.dart';
import 'package:post_krakren_dashboard/view/navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController userController = Get.put(UserController());
  
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    // For web, we might want a slightly shorter delay
    await Future.delayed(Duration(milliseconds: 1500));
    
    // Check authentication status
    userController.loadUserSession();
    
    // Use Get.offAllNamed for better web routing
    if (userController.token.value.isNotEmpty) {
      Get.offAll(() => DashboardScreen());
    } else {
      Get.offAll(() => LoginScreen(
    
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              duration: Duration(milliseconds: 1200),
              tween: Tween<double>(begin: 0.5, end: 1.0),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Image.asset(
                    AppImages.appLogo,
                    width: isLargeScreen ? 300 : 220,
                    height: isLargeScreen ? 300 : 220,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
            if (isLargeScreen) ...[
              SizedBox(height: 30),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 2,
              ),
            ],
          ],
        ),
      ),
    );
  }
}