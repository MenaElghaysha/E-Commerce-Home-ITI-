import 'package:dio/dio.dart';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProviderAuth {
  Future<String> userLogin(
      {required String userName, required String password}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      FormData userData =
          FormData.fromMap({"username": userName, "password": password});
      Response response =
          await Dio().post("https://dummyjson.com/auth/login", data: userData);

      if (response.statusCode == 200) {
        await pref.setString("userToken", response.data["token"]);
        return "Login Success";
      } else {
        return "Login Failed: ${response.data['message'] ?? 'Unknown error'}";
      }
    } catch (e) {
      if (e is DioException) {
        return e.response?.data["message"] ?? "An error occurred";
      } else {
        return "An error occurred";
      }
    }
  }
}
