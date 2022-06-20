import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:siloka_security/app/data/component/card_component.dart';
import 'package:siloka_security/app/modules/recent/controllers/recent_emergency_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../data/component/color_data.dart';
import '../../../data/component/modalbottom_component.dart';

class RecentEmergencyPage extends GetView<RecentEmergencyController> {
  const RecentEmergencyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: VxBox(
        child: Obx(() {
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
                              "${controller.recentEmergency[index]['pesan']}",
                          tatarPesan:
                              "${controller.recentEmergency[index]['tatar']}",
                          alamatPesan:
                              "${controller.recentEmergency[index]['alamat']}",
                          createdAt:
                              "${controller.recentEmergency[index]['updatedAt']}",
                          done: controller.recentEmergency[index]['done'],
                          onTap: () {
                        showMaterialModalBottomSheet(
                            context: context,
                            shape: Vx.rounded,
                            bounce: true,
                            enableDrag: true,
                            isDismissible: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return recentModalBottomComponent(
                                context,
                                pesan:
                                    "${controller.recentEmergency[index]['pesan']}",
                                tatar:
                                    "${controller.recentEmergency[index]['tatar']}",
                                alamat:
                                    "${controller.recentEmergency[index]['alamat']}",
                                pengirim:
                                    "${controller.recentEmergency[index]['pengirim']}",
                              );
                            });
                      });
                    },
                    childCount: controller.recentEmergency.length,
                  ),
                )
              ],
            ),
          );
        }),
      ).make().whFull(context),
    );
  }
}
