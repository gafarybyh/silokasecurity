import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:siloka_security/app/data/component/card_component.dart';
import 'package:siloka_security/app/data/component/modalbottom_component.dart';
import 'package:siloka_security/app/modules/home/controllers/home_controller.dart';
import 'package:siloka_security/app/modules/home/controllers/visitor_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class VisitorPage extends GetView<VisitorController> {
  const VisitorPage({Key? key}) : super(key: key);

  static HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: VxBox(
        child: Obx(() {
          // if (controller.listVisitor.isEmpty) {
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
                          titlePesan:
                              "${controller.listVisitor[index]['pesan']}",
                          tatarPesan:
                              "${controller.listVisitor[index]['tatar']}",
                          alamatPesan:
                              "${controller.listVisitor[index]['alamat']}",
                          createdAt:
                              "${controller.listVisitor[index]['createdAt']}",
                          done: controller.listVisitor[index]['done'],
                          onTap: () {
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
                                enableTombolBantuan: false,
                                pesan:
                                    "${controller.listVisitor[index]['pesan']}",
                                tatar:
                                    "${controller.listVisitor[index]['tatar']}",
                                alamat:
                                    "${controller.listVisitor[index]['alamat']}",
                                pengirim:
                                    "${controller.listVisitor[index]['pengirim']}",
                                fungsiterima: () {
                                  EasyLoading.show();
                                  controller
                                      .updateVisitor(
                                          controller.listVisitor[index].objectId
                                              .toString(),
                                          true)
                                      .then((value) => Get.back());
                                },
                                fungsibantuan: () {},
                              );
                            });
                      });
                    },
                    childCount: controller.listVisitor.length,
                  ),
                )
              ],
            ),
          );
          // }
        }),
      ).make().whFull(context),
    );
  }
}
