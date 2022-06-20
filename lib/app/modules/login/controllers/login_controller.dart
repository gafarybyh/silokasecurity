import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:flutter/material.dart';
import 'package:siloka_security/app/data/component/color_data.dart';

class LoginController extends GetxController {
  final TextEditingController txtloginid = TextEditingController();
  final TextEditingController txtkatasandi = TextEditingController();

//DO USER LOGIN
  void doUserLogin() async {
    final username = txtloginid.text.trim();
    final password = txtkatasandi.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      EasyLoading.dismiss();
      Get.offNamed("/navbar");
      txtloginid.clear();
      txtkatasandi.clear();
    } else {
      EasyLoading.dismiss();
      Get.snackbar("Gagal Login", "Login ID atau Password Salah",
          icon: const Icon(Icons.warning_amber, color: merah));
      txtkatasandi.clear();
    }
  }

  @override
  void onInit() {
    hasUserLogged();
    super.onInit();
  }

//CEK USER SESSION TOKEN
  void hasUserLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser != null) {
      EasyLoading.show();
      //Checks whether the user's session token is valid
      final ParseResponse? parseResponse =
          await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

      if (parseResponse?.success == null || !parseResponse!.success) {
        //Invalid session. Logout
        EasyLoading.dismiss();
        await currentUser.logout();
      } else {
        EasyLoading.dismiss();
        Get.offNamed('/navbar');
      }
    } else {
      return null;
    }
  }
}
