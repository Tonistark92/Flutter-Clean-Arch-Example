import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_clean/api/status_code.dart';

import 'api_consumer.dart';
import 'error/exceptions.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;
  DioConsumer({required this.client}) {
    client.options.baseUrl = "https://jsonplaceholder.typicode.com/";
    client.options.headers = {
      // "Accept": "application/json",
      "Content-Type": "application/json",
    };
    client.options.connectTimeout = const Duration(seconds: 20); //5s
    client.options.receiveTimeout = const Duration(seconds: 20);
  }

  @override
  Future delete(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response response =
          await client.delete(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _errorHandler(e);
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final Response response =
          await client.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _errorHandler(e);
      // if (e.response?.statusCode == StatusCode.unauthorized) {
      //   throw const UnauthorizedException("Unauthorized action");
      // } else {
      //   throw const SocketException("No internet connection");
      // }
    }
  }

  @override
  Future patch(String path,
      {Map<String, dynamic>? queryParameters, body}) async {
    final Response response =
        await client.patch(path, queryParameters: queryParameters, data: body);
    return response.data;
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? queryParameters, body}) async {
    try {
      final Response response =
          await client.post(path, queryParameters: queryParameters, data: body);
      return response.data;
    } on DioException catch (e) {
      _errorHandler(e);
    }
  }

  @override
  Future put(String path, {Map<String, dynamic>? queryParameters, body}) async {
    final Response response =
        await client.put(path, queryParameters: queryParameters, data: body);
    return response.data;
  }

  @override
  Future<void> setToken() async {
    // try {
    //   final token = await TokensSecureStorage().getAccessToken();
    //   client.options.headers.addAll({"Authorization": "Bearer $token"});
    // } catch (e) {
    //   throw const ReadFromDeviceException();
    // }
  }

  void removeToken() {
    client.options.headers.remove("Authorization");
  }

  void _errorHandler(DioException e) {
    String? errorMsg;
    if (e.error is SocketException) {
      throw const NoInternetConnectionException("No internet connection");
    } else if (e.response?.statusCode == StatusCode.unauthorized) {
      throw const UnauthorizedException("Unauthorized action");
    } else if (e.response?.statusCode == StatusCode.badRequest) {
      final message = _extractErrorMsgFromResponse(e.response!);
      throw BadRequestException(message);
    } else if (e.response?.statusCode == StatusCode.notFound) {
      throw const NotFoundException();
    } else if (e.response?.statusCode == StatusCode.internalServerError) {
      throw const ServerException("Something went wrong, please try again");
    } else {
      errorMsg = e.response?.data['message'] ??
          "Something went wrong, please try again";
      throw CustomException(errorMsg);
    }
  }

  String _extractErrorMsgFromResponse(Response response) {
    // Extract the errors from the response
    // final errors = response.data['errors'];
    // final error = errors[0];
    // final errorMsg = error['msg'];
    // throw ServerException(errorMsg);
    return "Bad Request";
  }
}
