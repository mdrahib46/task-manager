import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/user_model.dart';

class TestAuthController {
  static const String _accessTokenKey = 'access-token';
  static const String _accessDataKey = 'user-data';

  String? accessToken;
  UserModel? userModel;

  Future<void> saveAccessToken(String token, UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(
      _accessDataKey,
      jsonEncode(userModel.toJson()),
    );
  }

  Future<void> getAccessData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey);
    userModel = UserModel.fromJson(
      jsonDecode(sharedPreferences.getString(_accessDataKey)!),
    );
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);

    if (token != null) {
      await getAccessData();
      return true;
    } else {
      return false;
    }
  }

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
