import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:siloka_security/app/data/component/card_component.dart';
import 'package:siloka_security/app/modules/recent/controllers/recent_visitor_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/component/modalbottom_component.dart';

class RecentVisitorPage extends GetView<RecentVisitorController> {
  const RecentVisitorPage({Key? key}) : super(key: key);

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
                          titlePesan:
                              "${controller.recentVisitor[index]['pesan']}",
                          tatarPesan:
                              "${controller.recentVisitor[index]['tatar']}",
                          alamatPesan:
                              "${controller.recentVisitor[index]['alamat']}",
                          createdAt:
                              "${controller.recentVisitor[index]['updatedAt']}",
                          done: controller.recentVisitor[index]['done'],
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
                                    "${controller.recentVisitor[index]['pesan']}",
                                tatar:
                                    "${controller.recentVisitor[index]['tatar']}",
                                alamat:
                                    "${controller.recentVisitor[index]['alamat']}",
                                pengirim:
                                    "${controller.recentVisitor[index]['pengirim']}",
                              );
                            });
                      });
                    },
                    childCount: controller.recentVisitor.length,
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
