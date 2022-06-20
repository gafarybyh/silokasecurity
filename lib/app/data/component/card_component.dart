import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:siloka_security/app/data/component/color_data.dart';
import 'package:siloka_security/app/data/component/text_component.dart';

import 'package:velocity_x/velocity_x.dart';

Widget cardComponent(BuildContext context,
    {String? titlePesan,
    String? tatarPesan,
    String? alamatPesan,
    dynamic createdAt,
    bool? done,
    Color? messageColor = biru,
    Function()? onTap}) {
  return VxCard(
    Material(
      child: InkWell(
        onTap: onTap,
        child: HStack(
          [
            VxBox()
                .color(messageColor!)
                .width(5)
                .height(context.mdGutter * 3)
                .make(),
            8.widthBox,
            Expanded(
              child: VStack(
                [
                  textRegular(text: titlePesan, bold: true),
                  textSubHead(text: tatarPesan),
                  textSubHead(text: alamatPesan),
                ],
              ),
            ),
            VStack(
              [
                Jiffy(createdAt)
                    .fromNow()
                    .toString()
                    .text
                    .size(13)
                    .color(abuabutua)
                    .make(),
                done == true
                    ? "Selesai".text.size(12).color(hijau).make()
                    : "Tindak Lanjuti".text.size(12).color(abuabutua).make(),
              ],
              crossAlignment: CrossAxisAlignment.end,
              alignment: MainAxisAlignment.spaceBetween,
              axisSize: MainAxisSize.max,
            ).py(5),
          ],
        ).pOnly(left: 10, right: 10),
      ),
    ),
  )
      .roundedSM
      .elevation(3)
      .make()
      .wFull(context)
      .h(context.screenHeight * 0.13)
      .pSymmetric(h: 8, v: 2);
}
