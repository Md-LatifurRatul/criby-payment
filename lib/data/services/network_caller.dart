import 'dart:convert';
import 'dart:developer';

import 'package:criby_payment/criby_app.dart';
import 'package:criby_payment/data/controller/auth_controller.dart';
import 'package:criby_payment/data/models/network_response.dart';
import 'package:criby_payment/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      final headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        if (AuthController.apiToken != null)
          'Authorization': 'Bearer ${AuthController.apiToken}',
      };
      final http.Response response = await http.get(
        Uri.parse(url),

        headers: headers,
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSucess: true,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401) {
        _goTologinScreen();
        return NetworkResponse(
          isSucess: false,
          responseCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSucess: false,
          responseCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSucess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          if (AuthController.apiToken != null)
            'Authorization': 'Bearer ${AuthController.apiToken}',
        },

        body: jsonEncode(body),
      );

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeResponse = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSucess: true,
          responseData: decodeResponse,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(
          isSucess: false,
          responseCode: response.statusCode,
          errorMessage: "Email/password is incorrect!",
        );
      } else {
        return NetworkResponse(
          isSucess: false,
          responseCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSucess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void _goTologinScreen() {
    Navigator.pushAndRemoveUntil(
      CribyApp.navigationKey.currentState!.context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}
