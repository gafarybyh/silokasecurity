import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:siloka_security/app/data/component/color_data.dart';
import 'package:siloka_security/app/data/component/text_component.dart';
import 'package:siloka_security/app/modules/home/views/visitor_page.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import 'emergency_page.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  static DateTime currentTime = DateTime.now();
  static String tanggalsekarang = Jiffy(currentTime).format('d MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VxBox(
          child: Obx(
            () {
              return VStack(
                [
                  10.heightBox,
                  HStack(
                    [
                      textHeadline(text: "Pesan Laporan").pOnly(left: 12),
                      const Spacer(),
                      Stack(
                        children: [
                          const Positioned(
                            child: Icon(
                              Icons.message,
                              size: 35,
                              color: abuabutua,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: controller.getTotalPesan() != 0
                                ? VxBox(
                                        child: controller
                                            .getTotalPesan()
                                            .toString()
                                            .text
                                            .white
                                            .size(15)
                                            .make()
                                            .centered())
                                    .roundedFull
                                    .color(merah)
                                    .height(20)
                                    .width(20)
                                    .make()
                                : VxBox().make(),
                          ),
                        ],
                      ).tooltip(
                          "Total Pesan ${controller.getTotalPesan().toString()}"),
                    ],
                    axisSize: MainAxisSize.max,
                  ).pOnly(right: 12),
                  10.heightBox,
                  Align(
                    alignment: Alignment.topCenter,
                    child: VxBox(
                      child: VStack(
                        [
                          textHeadline2(
                              text:
                                  "Hallo ${Get.find<ProfileController>().dataUser.value.nama}",
                              colorwhite: true),
                          5.heightBox,
                          textsubHeadlineGrey(
                              text:
                                  "Selamat Datang di Tatar ${Get.find<ProfileController>().dataUser.value.tatar}, Selamat Bertugas."),
                          const Spacer(),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: HStack(
                                [
                                  textHeadline(
                                      text: tanggalsekarang, colorwhite: true)
                                ],
                                alignment: MainAxisAlignment.spaceBetween,
                                crossAlignment: CrossAxisAlignment.end,
                              )),
                        ],
                      ),
                    )
                        .p12
                        .width(context.screenWidth * 0.93)
                        .height(context.screenHeight * 0.18)
                        .color(biru)
                        .rounded
                        .make(),
                  ),
                  10.heightBox,
                  Expanded(
                    child: ContainedTabBarView(
                      tabs: [
                        textRegular(text: "Visitor", bold: true),
                        textRegular(text: "Emergency", bold: true),
                      ],
                      tabBarProperties: TabBarProperties(
                        background: Container(
                          width: context.screenWidth * 0.8,
                          decoration: const BoxDecoration(
                            color: abuabumuda,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6.0,
                        ),
                        indicator: ContainerTabIndicator(
                          borderColor: abuabutua,
                          borderWidth: 1,
                          padding: Vx.mH8,
                          radius: BorderRadius.circular(30),
                          color: Vx.white,
                        ),
                        labelColor: biru,
                        unselectedLabelColor: Vx.black,
                      ),
                      views: [
                        const VisitorPage().pOnly(top: 15),
                        const EmergencyPage().pOnly(top: 15),
                      ],
                    ),
                  ),
                  Padding(padding: context.screenPadding * 2)
                ],
              );
            },
          ),
        ).make().whFull(context),
      ),
    );
  }
}
