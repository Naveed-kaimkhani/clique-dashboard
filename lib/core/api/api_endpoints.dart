class ApiEndpoints {
  static const String baseUrl = "https://cactisocial.com/api-clique/public/api/v1";
  static const String register = "$baseUrl/register";
  
  static const String verifyOtp = "$baseUrl/otp/verify";
  
  static const String cometchatBaseUrl =
      "https://269435d754e8fd97.api-us.cometchat.io/v3";
  static const String sendOtp = "$baseUrl/send";
  static const String login = "$baseUrl/login";
  static const String joinGroup = "$baseUrl/cometchat/groups/join";
  static const String getGroups = "$baseUrl/cometchat/groups";
  static const String getInfluencers = "$baseUrl/user";
  static const String apiKey = "f6985bc6a317824cc687e82794955efded6bf2b1";

  static const String sendMessage = "https://269435d754e8fd97.api-us.cometchat.io/v3/messages";
  
  static const String createGroupApi = "https://269435d754e8fd97.api-us.cometchat.io/v3/groups";
 static const String getGroupMembers = "$baseUrl/cometchat/groups";
 static String groupMessages(String groupId) =>
      "$baseUrl/cometchat/groups/$groupId/messages";

  static final String getAllPopstreamUrl =
      "https://clique.revovideo.net/api/popstream/get-all-popstream?language=en";
  static final String getRevoAccessApi =
      'https://clique.revovideo.net/api/auth/token';
 static final String updateApi = "https://cactisocial.com/api-clique/public/api/v1/user/update?_method=PUT";
//  static const String getGroupMembers = "$baseUrl/cometchat/groups/g2/members";
}
