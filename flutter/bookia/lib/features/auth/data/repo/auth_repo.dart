import 'dart:developer';

import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/features/auth/data/models/auth_params.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';

class AuthRepo {
  static Future<AuthResponse?> login(AuthParams authParams) async {
    try {
      log(authParams.toJson().toString());
      var response = await DioProvider.postApi(
        endpoint: Apis.login,
        data: authParams.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          return AuthResponse.fromJson(response.data);
        } on Exception catch (e) {
          log("Parsing error : $e");
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<AuthResponse?> register(AuthParams authParams) async {
    try {
      var response = await DioProvider.postApi(
        endpoint: Apis.register,
        data: authParams.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          return AuthResponse.fromJson(response.data);
        } on Exception catch (e) {
          log("Parsing error : $e");
          return null;
        }
        // json
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
