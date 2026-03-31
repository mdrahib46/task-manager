import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/user_model.dart';

class AuthController {
  AuthController._();
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  static String? accessToken;
  static UserModel? userModel;

  static Future<void> saveUserData(
      String accessTokenParam,
      UserModel userModelParam,
      ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, accessTokenParam);
    await sharedPreferences.setString(
      _userDataKey,
      jsonEncode(userModelParam.toJson()),
    );

    accessToken = accessTokenParam;
    userModel = userModelParam;
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey);
    final userData = sharedPreferences.getString(_userDataKey);

    if (userData != null) {
      userModel = UserModel.fromJson(jsonDecode(userData));
    }
  }

  static Future<void> updateUserData(UserModel model, {String? newToken}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    if (newToken != null) {
      await sharedPreferences.setString(_accessTokenKey, newToken);
      accessToken = newToken;
    }

    userModel = model;
  }

 static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    if (token != null) {
      await getUserData();
      return true;
    } else {
      return false;
    }
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
