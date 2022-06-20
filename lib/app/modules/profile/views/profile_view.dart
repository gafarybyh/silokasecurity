import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:siloka_security/app/data/component/color_data.dart';
import 'package:siloka_security/app/data/component/text_component.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VxBox(
          child: Obx(
            () {
              return VStack(
                [
                  15.heightBox,
                  textHeadline(text: "Profil").pOnly(left: 12),
                  5.heightBox,
                  const Divider(color: abuabutua).px12(),
                  10.heightBox,
                  HStack(
                    [
                      VxCircle(
                        backgroundColor: abuabutua,
                        radius: 80,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Vx.white,
                        ),
                      ),
                      10.widthBox,
                      VStack(
                        [
                          textHeadline2(
                              text: "${controller.dataUser.value.nama}",
                              colorwhite: false),
                          5.heightBox,
                          textSubHead(
                              text: "Tatar ${controller.dataUser.value.tatar}"),
                        ],
                      ),
                    ],
                  ).px12(),
                  30.heightBox,
                  HStack(
                    [
                      const Icon(Icons.phone_outlined, size: 25),
                      10.widthBox,
                      textRegular(text: "Nomor Telepon", bold: true),
                      const Spacer(),
                      textSubRegular(
                          text: "${controller.dataUser.value.telepon}",
                          bold: true),
                    ],
                  ).px16(),
                  15.heightBox,
                  HStack(
                    [
                      const Icon(Icons.perm_identity, size: 25),
                      10.widthBox,
                      textRegular(text: "Username", bold: true),
                      const Spacer(),
                      textSubRegular(
                          text: "${controller.dataUser.value.username}",
                          bold: true),
                    ],
                  ).px16(),
                  15.heightBox,
                  HStack(
                    [
                      const Icon(Icons.alternate_email, size: 25),
                      10.widthBox,
                      textRegular(text: "Email", bold: true),
                      const Spacer(),
                      textSubRegular(
                          text: "${controller.dataUser.value.email}",
                          bold: true),
                    ],
                  ).px16(),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      EasyLoading.show();
                      controller.doUserLogout();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(Vx.m12),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      backgroundColor: MaterialStateProperty.all(merah),
                    ),
                    child: textRegular(text: "Keluar", bold: true)
                        .px(context.screenWidth * 0.1),
                  ).centered(),
                ],
              ).pOnly(bottom: context.screenHeight * 0.13);
            },
          ),
        ).make().whFull(context),
      ),
    );
  }
}
