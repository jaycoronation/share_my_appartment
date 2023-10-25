import 'package:share_my_appartment/utils/session_manager_new.dart';

class SessionManager {
  /*"user_id": "2",
  "name": "Chhatbar mayur",
  "contact": 8401358881,
  "email": "mayur@coronation.in",
  "notification": 1,
  "is_active": 1,
  "timestamp": "20/01/2022",
  "profile_pic": "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/16426725241.jpg",
  "token": "90fb06d46489d9a21abfc31c1ebc2b9d"*/

  final String isLoggedIn = "isLoggedIn";
  final String userId = "user_id";
  final String name = "name";
  final String email = "email";
  final String contact = "contact";
  final String profilePic = "profile_pic";
  final String token = "token";
  final String notification = "notification";
  final String cityId = "cityId";

  //set data into shared preferences like this
  Future createLoginSession(String apiUserId,String apiName,String apiEmail,String apiContact,String apiProfilePic,
      String apiToken,int apiNotification) async {
    await SessionManagerNew.setBool(isLoggedIn, true);
    await SessionManagerNew.setString(userId, apiUserId);
    await SessionManagerNew.setString(name, apiName);
    await SessionManagerNew.setString(email, apiEmail);
    await SessionManagerNew.setString(contact, apiContact);
    await SessionManagerNew.setString(profilePic, apiProfilePic);
    await SessionManagerNew.setString(token, apiToken);
    await SessionManagerNew.setInt(notification, apiNotification);
  }

  bool? checkIsLoggedIn() {
    return SessionManagerNew.getBool(isLoggedIn);
  }

  String? getUserId() {
    return SessionManagerNew.getString(userId);
  }

  Future<void> setName(String apiName)
  async {
    await SessionManagerNew.setString(name, apiName);
  }

  String? getName() {
    return SessionManagerNew.getString(name);
  }

  Future<void> setEmail(String apiEmail)
  async {
    await SessionManagerNew.setString(email, apiEmail);
  }

  String? getEmail() {
    return SessionManagerNew.getString(email);
  }

  String? getContact() {
    return SessionManagerNew.getString(contact);
  }

  Future<void> setProfilePic(String apiProfilePic)
  async {
    await SessionManagerNew.setString(profilePic, apiProfilePic);
  }

  String? getProfilePic() {
    return SessionManagerNew.getString(profilePic);
  }

  Future<void> setToken(String deviceToken)
  async {
    await SessionManagerNew.setString(token, deviceToken);
  }

  String? getToken() {
    return SessionManagerNew.getString(token);
  }

  Future<void> setNotificationStatus(int apiNotification)
  async {
    await SessionManagerNew.setInt(notification, apiNotification);
  }

  int? getNotificationStatus() {
    return SessionManagerNew.getInt(notification);
  }

  Future<void> setCityId(String apiCityId)
  async {
    await SessionManagerNew.setString(cityId, apiCityId);
  }

  String? getCityId()
  {
    return SessionManagerNew.getString(cityId);
  }
}