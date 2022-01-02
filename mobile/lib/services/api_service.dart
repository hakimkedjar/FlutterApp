import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cash_manager/utils/local_storage.dart';
import 'package:cash_manager/utils/exceptions.dart';

class API {
  static const String host = String.fromEnvironment('HOST',
      defaultValue: 'http://job-me.tech:8080'); // Define your IP machine !

  static _throwError(int status) {
    switch (status) {
      case 400:
        throw BadRequestException();
      case 401:
        throw AuthorizationException();
      case 403:
        throw PermissionException();
      default:
        throw DefaultException();
    }
  }

  static Future<Map<String, dynamic>> get(String url) async {
    var response = await http.get(Uri.parse(host + url),
        headers: {'Authorization': 'Bearer ${LocalStorage.getString('jwt')}'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return _throwError(response.statusCode);
    }
  }

  static Future<Map<String, dynamic>> delete(String url) async {
    var response = await http.delete(Uri.parse(host + url),
        headers: {'Authorization': 'Bearer ${LocalStorage.getString('jwt')}'});
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return _throwError(response.statusCode);
    }
  }

  static Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    var response = await http.post(
      Uri.parse(host + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${LocalStorage.getString('jwt')}'
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return _throwError(response.statusCode);
    }
  }

  static Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> body,
  ) async {
    var response = await http.put(
      Uri.parse(host + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${LocalStorage.getString('jwt')}'
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return _throwError(response.statusCode);
    }
  }
}
