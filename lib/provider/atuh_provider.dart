import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/api_response.dart';
import 'package:task_manager_app/utils/app_urls.dart';

class AuthProvider extends ChangeNotifier {
  String _accessToken = "token";
  String _userModelKey = 'usr-data';
  static final Logger _logger = Logger();

  String? errorMessage;
  bool isLoading = false;

  static String? accessToken;
  static UserModel? userModel;

  Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessToken, token);
    await sharedPreferences.setString(_userModelKey, jsonEncode(model));

    accessToken = token;
    model = model;

    _logger.i(token);
    _logger.i(userModel);

    notifyListeners();
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessToken);
    return token != null;
  }

  Future<void> updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessToken, jsonEncode(model.toJson()));
    notifyListeners();
  }

  Future<void> cleanUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    notifyListeners();
  }

  _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> signIn({required String email, required String password}) async {
    Map<String, dynamic> requestBody = {"email": email, "password": password};

    _setLoading(true);

    final NetworkResponse response = await ApiCaller.postRequest(
      url: AppUrls.login,
      body: requestBody,
    );

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(response.responseData['data']);
      String accessToken = response.responseData['token'];

      await saveUserData(userModel, accessToken);
      return true;
    } else {
      errorMessage = response.responseData['data'];
      notifyListeners();
      return false;
    }
  }
}
