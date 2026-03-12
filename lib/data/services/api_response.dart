import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:task_manager_app/data/models/network_response.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  ApiCaller._();

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(uri.toString());

      http.Response response = await http.get(uri);

      _logger.i("Request Response : ${response.body}");
      dynamic decodedResponse;
      try {
        decodedResponse = jsonDecode(response.body);
      } catch (e) {
        decodedResponse = response.body;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: 'Request failed. Please try again.',
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        responseData: null,
        errorMessage: 'Unable to connect to the server.',
      );
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        "Content-Type": "application/json",

      };

      _logRequest(url);
      final http.Response response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      _logger.i("Status Code: ${response.statusCode} \nRequest Response: ${response.body}");

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedData['data'] ?? 'Something went wrong....!',
          );
        }
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401) {

        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: "Unauthenticated user",
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i("URL: $url\nRESPONSE: $body");
  }
}
