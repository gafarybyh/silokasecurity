import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:siloka_security/app/data/component/card_component.dart';
import 'package:siloka_security/app/data/component/color_data.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/component/modalbottom_component.dart';
import '../controllers/emergency_controller.dart';

class EmergencyPage extends StatelessWidget {
  final bool? done;
  const EmergencyPage({Key? key, this.done}) : super(key: key);

  static EmergencyController emergencyController =
      Get.find<EmergencyController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: VxBox(
        child: Obx(() {
          // if (emergencyController.listEmergency.isEmpty) {
          //   return const CircularProgressIndicator().centered();
          // } else {
          return Scrollbar(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return cardComponent(context,
                          messageColor: merah,
                          titlePesan:
                              "${emergencyController.listEmergency[index]['pesan']}",
                          tatarPesan:
                              "${emergencyController.listEmergency[index]['tatar']}",
                          alamatPesan:
                              "${emergencyController.listEmergency[index]['alamat']}",
                          createdAt:
                              "${emergencyController.listEmergency[index]['createdAt']}",
                          done: emergencyController.listEmergency[index]
                              ['done'], onTap: () {
                        showMaterialModalBottomSheet(
                            context: context,
                            shape: Vx.rounded,
                            bounce: true,
                            enableDrag: true,
                            isDismissible: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return modalBottomComponent(
                                context,
                                enableTombolBantuan: true,
                                warnaIcon: merah,
                                pesan:
                                    "${emergencyController.listEmergency[index]['pesan']}",
                                tatar:
                                    "${emergencyController.listEmergency[index]['tatar']}",
                                alamat:
                                    "${emergencyController.listEmergency[index]['alamat']}",
                                pengirim:
                                    "${emergencyController.listEmergency[index]['pengirim']}",
                                fungsiterima: () {
                                  EasyLoading.show();
                                  emergencyController
                                      .updateEmergency(
                                          emergencyController
                                              .listEmergency[index].objectId
                                              .toString(),
                                          true)
                                      .then((value) => Get.back());
                                },
                                fungsibantuan: () {},
                              );
                            });
                      });
                    },
                    childCount: emergencyController.listEmergency.length,
                  ),
                )
              ],
            ),
          );
        }
            // },
            ),
      ).make().whFull(context),
    );
  }
}
