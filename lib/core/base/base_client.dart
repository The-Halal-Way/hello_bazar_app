// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_bazar/core/constants/my_api_url.dart';
import 'package:hello_bazar/core/constants/my_string.dart';
import 'package:hello_bazar/core/error/api_exception.dart';
import 'package:hello_bazar/core/util/my_dialog.dart';
import 'package:logger/logger.dart';

class BaseClient {
  static final dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 3)));

  static final Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'zoneId': '[1]',
    'latitude': '23.735129',
    'longitude': '90.425614',
  };

  static Future<dynamic> getData({
    required String endPoint,
    Object? body,
    Map<String, dynamic>? parameters,
    Options? options,
    required BuildContext ctx,
  }) async {
    try {
      final url = "${MyApiUrl.baseUrl}/${MyApiUrl.version}/$endPoint";
      Logger().i("$url/$parameters");
      final response = await dio.get(
        url,
        queryParameters: parameters,
        data: body ?? jsonEncode({}),
        options: options ?? Options(headers: header),
      );
      Logger().t("\x1B[95mResponse status code: ${response.statusCode}");
      if (response.statusCode == 200) return response.data;
      MyDialog().showFailedToast(msg: MyString.errorMsg, context: ctx);
    } on DioException catch (e) {
      ApiException.handleException(e, ctx);
    } catch (e) {
      Logger().e(e);
      MyDialog().showFailedToast(
        title: "Unexpected Error!",
        msg: e.toString(),
        context: ctx,
      );
    }
  }

  static Future<dynamic> postData({
    required String endPoint,
    Object? body,
    Map<String, dynamic>? parameters,
    Options? options,
    required BuildContext ctx,
  }) async {
    try {
      final url = "${MyApiUrl.baseUrl}/${MyApiUrl.version}/$endPoint";
      Logger().i("$url/$parameters");
      final response = await dio.post(
        url,
        queryParameters: parameters,
        data: body ?? jsonEncode({}),
        options: options ?? Options(headers: header),
      );
      Logger().t("\x1B[95mResponse status code: ${response.statusCode}");
      if (response.statusCode == 200) return response.data;
      MyDialog().showFailedToast(msg: MyString.errorMsg, context: ctx);
    } on DioException catch (e) {
      ApiException.handleException(e, ctx);
    } catch (e) {
      Logger().e(e);
      MyDialog().showFailedToast(
        title: "Unexpected Error!",
        msg: e.toString(),
        context: ctx,
      );
    }
  }

  static Future<dynamic> patchData({
    required String endPoint,
    Object? body,
    Map<String, dynamic>? parameters,
    Options? options,
    required BuildContext ctx,
  }) async {
    try {
      final url = "${MyApiUrl.baseUrl}/${MyApiUrl.version}/$endPoint";
      Logger().i("$url/$parameters");
      final response = await dio.patch(
        url,
        queryParameters: parameters,
        data: body ?? jsonEncode({}),
        options: options ?? Options(headers: header),
      );
      Logger().t("\x1B[95mResponse status code: ${response.statusCode}");
      if (response.statusCode == 200) return response.data;
      MyDialog().showFailedToast(msg: MyString.errorMsg, context: ctx);
    } on DioException catch (e) {
      Logger().e(e);
      ApiException.handleException(e, ctx);
    } catch (e) {
      Logger().e(e);
      MyDialog().showFailedToast(
        title: "Unexpected Error!",
        msg: e.toString(),
        context: ctx,
      );
    }
  }

  static Future<dynamic> putData({
    required String endPoint,
    Object? body,
    Map<String, dynamic>? parameters,
    Options? options,
    required BuildContext ctx,
  }) async {
    try {
      final url = "${MyApiUrl.baseUrl}/${MyApiUrl.version}/$endPoint";
      Logger().i("$url/$parameters");
      final response = await dio.put(
        url,
        queryParameters: parameters,
        data: body ?? jsonEncode({}),
        options: options ?? Options(headers: header),
      );
      Logger().t("\x1B[95mResponse status code: ${response.statusCode}");
      if (response.statusCode == 200) return response.data;
      MyDialog().showFailedToast(msg: MyString.errorMsg, context: ctx);
    } on DioException catch (e) {
      ApiException.handleException(e, ctx);
    } catch (e) {
      Logger().e(e);
      MyDialog().showFailedToast(
        title: "Unexpected Error!",
        msg: e.toString(),
        context: ctx,
      );
    }
  }

  static Future<dynamic> deleteData({
    required String endPoint,
    Object? body,
    Map<String, dynamic>? parameters,
    Options? options,
    required BuildContext ctx,
  }) async {
    try {
      final url = "${MyApiUrl.baseUrl}/${MyApiUrl.version}/$endPoint";
      Logger().i("$url/$parameters");
      final response = await dio.delete(
        url,
        queryParameters: parameters,
        data: body,
        options: options ?? Options(headers: header),
      );
      Logger().t("\x1B[95mResponse status code: ${response.statusCode}");
      if (response.statusCode == 200) return response.data;
      MyDialog().showFailedToast(msg: MyString.errorMsg, context: ctx);
    } on DioException catch (e) {
      ApiException.handleException(e, ctx);
    } catch (e) {
      Logger().e(e);
      MyDialog().showFailedToast(
        title: "Unexpected Error!",
        msg: e.toString(),
        context: ctx,
      );
    }
  }
}
