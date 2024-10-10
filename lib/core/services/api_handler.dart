import 'dart:convert';
import 'package:dealsify_production/core/services/user_credentials.dart';
import 'package:http/http.dart' as http;

/// Custom api handler with passing token [ApiRequest]
class ApiRequest {

  static Future<http.Response> post(url, dynamic body) async {
    try {
      final response = await http.post(url, headers: await AccessToken.token(), body: body);
      return response;
    } catch (e) {
      throw Exception('Failed to make POST request: $e');
    }
  }

  static Future<http.Response> patch(url, dynamic data) async {
    try {
      final response = await http.patch(url, headers: await AccessToken.token(), body: json.encode(data));
      return response;
    } catch (e) {
      throw Exception('Failed to make PATCH request: $e');
    }
  }

  static Future<http.Response> delete(url) async {
    try {
      final response = await http.delete(url, headers: await AccessToken.token());
      return response;
    } catch (e) {
      throw Exception('Failed to make DELETE request: $e');
    }
  }

  static Future<http.Response> deleteBulk(url,body) async {
    try {
      final response = await http.delete(url, headers: await AccessToken.token(),body: body);
      return response;
    } catch (e) {
      throw Exception('Failed to make DELETE request: $e');
    }
  }

  static Future<http.Response> get(url) async {
    try {
      final response = await http.get(url, headers: await AccessToken.token());
      return response;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }

}