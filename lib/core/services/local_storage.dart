// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types, constant_identifier_names
import 'dart:convert';
import 'package:dealsify_production/core/services/extensions.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pref {
  static const String _localDataKey = "jd_storage";

  static Future<void> set(LocalDataModel data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localDataKey, jsonEncode(data.toJson()));
    } catch (e) {
      e.show();
    }
  }

  static Future<LocalDataModel?> get() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(_localDataKey);
      if (data != null) {
        return LocalDataModel.fromJson(jsonDecode(data));
      } else {
        return LocalDataModel();
      }
    } catch (e) {
      e.show();
    }
    return null;
  }

  static Future<void> remove() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_localDataKey);
    } catch (e) {
      e.show();
    }
  }
}


class LocalDataModel {
  dynamic access_token;
  dynamic company_id;
  dynamic user_id;
  dynamic is_rating_already_submit;
  dynamic is_app_used;
  dynamic default_Filter;

  LocalDataModel({
    this.access_token,
    this.company_id,
    this.user_id,
    this.is_rating_already_submit,
    this.is_app_used,
    this.default_Filter,
  });

  Map<dynamic, dynamic> toJson() => {
    'access_token': access_token ?? '',
    'company_id': company_id ?? '',
    'user_id': user_id ?? '',
    'is_rating_already_submit': is_rating_already_submit ?? '',
    'is_app_used': is_app_used ?? false,
    'default_Filter': default_Filter ?? '',
  };

  factory LocalDataModel.fromJson(Map<dynamic, dynamic> json) {
    return LocalDataModel(
      access_token: json['access_token'] ?? '',
      company_id: json['company_id'] ?? '',
      user_id: json['user_id'] ?? '',
      is_rating_already_submit: json['is_rating_already_submit'],
      is_app_used: json['is_app_used'],
      default_Filter: json['default_Filter'] ?? '',
    );
  }

}