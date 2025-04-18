import 'dart:developer';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/data/model/user_registration_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  late SharedPreferences prefs;
  Rxn<User> user = Rxn<User>();
  var token = '1|KBTMkpNQWaqNHTzA49xb4wcd5y4UqzkuABTSk3ES7d35d387'.obs;
  var revoAccessToken = ''.obs;
  var revoLamdaToken = ''.obs;
  var userEmail = ''.obs;
  var profilePhoto = ''.obs;
  var coverPhoto = ''.obs;
    var phone = ''.obs;
  var role = ''.obs;
  var userName = ''.obs;
  var uid = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    loadUserSession(); // Load session on init
  }

  void saveUserSession(
      UserRegistrationResponse response, String userName) async {

    token.value = response.token!;

    this.userName.value = userName; // Set the observable value directly
    await prefs.setString('token', response.token!);
    await prefs.setString('userName', userName);
  }

  Future<void> loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedUserName = prefs.getString('userName');

    final storedToken = prefs.getString('token');
    final revoAcess = prefs.getString('revo_access_token');
    final lamdaToken = prefs.getString('revo_lambda_token');
      
      //  final String revoAccessToken = responseData["revo_access_token"];
       
      //  final String revoLambdaToken = responseData["revo_lambda_token"];
        final storedRole = prefs.getString('role')??'';
        
        final email = prefs.getString('email');
        
        final profilePhotoUrl = prefs.getString('profile_photo_url');
        
        final coverPhotoUrl = prefs.getString('cover_photo_url');
        
        final phoneNo = prefs.getString('phone');
    uid.value = prefs.getInt('uid') ?? 0;

    if (storedUserName != null && storedToken != null ) {
      userName.value = storedUserName; // Set the observable value directly
      token.value = storedToken; // Set the observable value directly
      userName.value = storedUserName; // Set the observable value directly
      token.value = storedToken;
      userEmail.value=email??'';
      role.value=storedRole;
      revoAccessToken.value=revoAcess??'';
      revoLamdaToken.value=lamdaToken??'';
      profilePhoto.value=profilePhotoUrl??'';
      coverPhoto.value=coverPhotoUrl??'';
      phone.value=phoneNo??'';
    }
  }

  void logout() async {
    await prefs.clear();
    user.value = null;
    token.value = '';
    userName.value = '';
    uid.value = 0;
  }

  // Direct access methods for user data from SharedPreferences
  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
  }

  static Future<int> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('uid') ?? 0;
  }
}
