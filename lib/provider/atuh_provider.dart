import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/utils/app_urls.dart';

class AuthProvider extends ChangeNotifier {
  // Keys for SharedPreferences
  final String _accessTokenKey = "token";
  final String _userModelKey = 'usr-data';

  // Logger for debugging
  static final Logger _logger = Logger();

  // Variables
  String? errorMessage;
  bool isLoading = false;

  String? accessToken;
  UserModel? userModel;

  /// -----------------------------
  /// Save user data locally
  /// -----------------------------
  Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Save token and user model to SharedPreferences
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson()));

    // Assign to instance variables
    accessToken = token;

    // Assign to instance userModel
    userModel = model;

    _logger.i('Token saved: $token');
    _logger.i('User saved: $userModel');

    notifyListeners();
  }

  /// -----------------------------
  /// Load user data from local storage
  /// -----------------------------
  Future<void> loadUser() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    accessToken = sharedPreferences.getString(_accessTokenKey);
    final userData = sharedPreferences.getString(_userModelKey);

    // Load userModel only if data exists
    if (userData != null) {
      userModel = UserModel.fromJson(jsonDecode(userData));
      _logger.i('Loaded user: $userModel');
    }

    notifyListeners();
  }

  /// -----------------------------
  /// Check if user is logged in
  /// -----------------------------
  bool get isLoggedIn => accessToken != null;

  /// -----------------------------
  /// Update user data
  /// -----------------------------
  Future<void> updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Save updated user model under correct key
    await sharedPreferences.setString(_userModelKey, jsonEncode(model.toJson()));

    // Update instance variable
    userModel = model;

    notifyListeners();
  }

  /// -----------------------------
  /// Clear user data (logout)
  /// -----------------------------
  Future<void> cleanUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();

    accessToken = null;
    userModel = null;

    notifyListeners();
  }

  /// -----------------------------
  /// Internal method to set loading state
  /// -----------------------------
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// -----------------------------
  /// Sign in user
  /// -----------------------------
  Future<bool> signIn({required String email, required String password}) async {
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password
    };

    _setLoading(true);

    final NetworkResponse response = await ApiCaller.postRequest(
      url: AppUrls.login,
      body: requestBody,
    );

    _setLoading(false);

    if (response.isSuccess) {
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String token = response.responseData['token'];
      userModel = model;
      await saveUserData(model, token);

      return true;
    } else {
      errorMessage = response.responseData['data'];
      notifyListeners();
      return false;
    }
  }
}