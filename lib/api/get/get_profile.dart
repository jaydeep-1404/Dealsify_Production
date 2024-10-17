// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:convert';

import 'package:dealsify_production/core/services/extensions.dart';
import 'package:get/get.dart';
import '../../core/services/api_handler.dart';
import '../../core/services/server_urls.dart';
import '../../core/services/strings.dart';
import '../../core/services/user_credentials.dart';

class ProfileController extends GetxController {
  var userData = UserData().obs;

  @override
  void onInit() {
    super.onInit();
    get();
  }

  Future<void> get() async {
    try {
        final response = await ApiRequest.get(Uri.parse(ConstUrl.my_profile));
        final Map<String, dynamic> data = json.decode(response.body);
        AccessToken.expired(data);
        if (data[BKD.status].toString().isSuccess) {
          userData.value = UserData.fromJson(data[BKD.data]);
        } else {
          throw Exception('Failed to load data');
        }
    } catch (e,s) {
      print(s);
    }
  }

  clear(){
    userData.value = UserData();
  }

}

class UserData {
  final String? id,
      email,
      user_role_id,
      role,
      password,
      company_id,
      is_deleted,
      created_at,
      updated_at,
      refresh_token,
      name,
      image;

  UserData({
    this.id,
    this.email,
    this.user_role_id,
    this.role,
    this.password,
    this.company_id,
    this.is_deleted,
    this.created_at,
    this.updated_at,
    this.refresh_token,
    this.name,
    this.image,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      user_role_id: json['user_role_id']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      company_id: json['company_id']?.toString() ?? '',
      is_deleted: json['is_deleted']?.toString() ?? '',
      created_at: json['createdAt']?.toString() ?? '',
      updated_at: json['updatedAt']?.toString() ?? '',
      refresh_token: json['refresh_token']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }
}
