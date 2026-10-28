import 'dart:developer';

import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/base_response.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/features/auth/data/models/auth_params.dart';

class AuthRepo {
  static Future<BaseResponse?> login(AuthParams authParams) async {
    try {
      log(authParams.toJson().toString());
      var response = await DioProvider.postApi(
        endpoint: Apis.login,
        data: authParams.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          // response.data as base response => object => .data
          return BaseResponse.fromJson(response.data);
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

  static Future<BaseResponse?> register(AuthParams authParams) async {
    try {
      var response = await DioProvider.postApi(
        endpoint: Apis.register,
        data: authParams.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          return BaseResponse.fromJson(response.data);
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
