import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:siloka_security/app/modules/profile/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:siloka_security/server_config.dart';

class ProfileController extends GetxController {
  Rx<ProfileModel> dataUser = ProfileModel().obs;

//USER LOGOUT
  void doUserLogout() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;

    if (currentUser != null) {
      var response = await currentUser.logout();
      if (response.success) {
        EasyLoading.dismiss();
        Get.offNamed('/login');
      } else {
        EasyLoading.dismiss();
        Get.snackbar('Gagal Logout', "Terjadi kesalahan, Mohon coba kembali");
      }
    } else {
      Get.offNamed('/login');
    }
  }

  @override
  void onInit() {
    getUser();
    updateDeviceToken();
    super.onInit();
  }

  Future<void> getUser() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;

    dataUser.value = profileModelFromJson(currentUser.toString());
  }

  //GET DEVICE TOKEN FROM FCM
  Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint("TOKEN : $token");
    return token;
  }

  //SAVE DEVICE TOKEN
  Future<void> updateDeviceToken() async {
    final token = await getToken();
    final userToken = dataUser.value.devicetoken;

    if (userToken == null || userToken != token) {
      putDeviceToken(token!);
    }
  }

  //HTTP UPDATE DEVICE TOKEN TO SERVER
  Future<void> putDeviceToken(String? token) async {
    String? userId = dataUser.value.objectId;
    final response = await http.put(
      Uri.parse('https://silokasecurity.b4a.io/users/$userId'),
      headers: {
        "X-Parse-Application-Id": keyApplicationId,
        "X-Parse-REST-API-Key": keyRestAPI,
        "X-Parse-Session-Token": dataUser.value.sessionToken!,
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, String>{
        'devicetoken': token!,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
    } else {
      throw Exception('Failed to load album');
    }
  }

  // Future<List<ParseObject>> doUserQuery() async {
  //   QueryBuilder<ParseUser> queryUsers =
  //       QueryBuilder<ParseUser>(ParseUser.forQuery());
  //   final ParseResponse apiResponse = await queryUsers.query();

  //   if (apiResponse.success && apiResponse.results != null) {
  //     var datauser = apiResponse.results as List<ParseObject>;
  //     print(datauser.toList().toString());
  //     return datauser;
  //   } else {
  //     return [];
  //   }
  // }
}
