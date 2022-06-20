import 'package:flutter/material.dart';
import 'package:siloka_security/app/data/component/text_component.dart';
import 'package:velocity_x/velocity_x.dart';

import 'color_data.dart';

//MODAL BOTTOM COMPONENT
Widget modalBottomComponent(BuildContext context,
    {String? pesan,
    String? tatar,
    String? alamat,
    String? pengirim,
    Function()? fungsiterima,
    Color? warnaIcon = biru,
    bool? enableTombolBantuan = true,
    Function()? fungsibantuan}) {
  return VxBox(
    child: VStack(
      [
        10.heightBox,
        Icon(
          Icons.info,
          size: 50,
          color: warnaIcon,
        ).centered(),
        textHeadline2(text: "Konfirmasi Laporan", colorwhite: false)
            .objectTopCenter()
            .pOnly(top: 8),
        20.heightBox,
        VxBox(
          child: VStack(
            [
              HStack([
                textRegular(text: "Pesan : ", bold: true),
                textRegular(text: "$pesan", bold: false, overflow: false)
                    .expand(),
              ]),
              5.heightBox,
              HStack([
                textRegular(text: "Pengirim : ", bold: true),
                textRegular(text: "$pengirim", bold: false, overflow: false)
                    .expand()
              ]),
              5.heightBox,
              HStack([
                textRegular(text: "Tatar : ", bold: true),
                textRegular(text: "$tatar", bold: false),
              ]),
              5.heightBox,
              HStack([
                textRegular(text: "Alamat : ", bold: true),
                textRegular(text: "$alamat", bold: false, overflow: false)
                    .expand()
              ]),
              5.heightBox,
            ],
          ).p8(),
        ).rounded.color(abuabumuda).make().wFull(context),
        const Spacer(),
        //ENABLE TOMBOL BANTUAN ATAU TIDAK
        enableTombolBantuan == true
            ? textSubRegular(text: "Terima Laporan atau Panggil Bantuan")
                .centered()
            : textSubRegular(text: "Terima untuk mengkonfirmasi Laporan")
                .centered(),
        20.heightBox,
        HStack(
          [
            //ENABLE TOMBOL BANTUAN ATAU TIDAK
            enableTombolBantuan == true
                ? ElevatedButton(
                    onPressed: fungsibantuan,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(Vx.m12),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      backgroundColor: MaterialStateProperty.all(merah),
                    ),
                    child: textRegular(text: "Bantuan", bold: true)
                        .px(context.screenWidth * 0.1),
                  ).expand()
                : VxBox().make(),
            10.widthBox,
            ElevatedButton(
              onPressed: fungsiterima,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(Vx.m12),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(hijau),
              ),
              child: textRegular(text: "Terima", bold: true)
                  .px(context.screenWidth * 0.1),
            ).expand(),
          ],
        ),
      ],
    ).pOnly(bottom: 30, left: 12, right: 12),
  )
      .white
      .shadow3xl
      .rounded
      .alignBottomCenter
      .make()
      .h(context.screenHeight * 0.5);
}

//RECENT MODAL BOTTOM
Widget recentModalBottomComponent(
  BuildContext context, {
  String? pesan,
  String? tatar,
  String? alamat,
  String? pengirim,
}) {
  return VxBox(
    child: VStack(
      [
        10.heightBox,
        const Icon(
          Icons.check_circle,
          size: 50,
          color: hijau,
        ).centered(),
        textHeadline2(text: "Laporan Diterima", colorwhite: false)
            .objectTopCenter()
            .pOnly(top: 8),
        20.heightBox,
        VxBox(
          child: VStack(
            [
              HStack([
                textRegular(text: "Pesan : ", bold: true),
                textRegular(text: "$pesan", bold: false, overflow: false)
                    .expand(),
              ]),
              5.heightBox,
              HStack([
                textRegular(text: "Pengirim : ", bold: true),
                textRegular(text: "$pengirim", bold: false, overflow: false)
                    .expand()
              ]),
              5.heightBox,
              HStack([
                textRegular(text: "Tatar : ", bold: true),
                textRegular(text: "$tatar", bold: false),
              ]),
              5.heightBox,
              HStack([
                textRegular(text: "Alamat : ", bold: true),
                textRegular(text: "$alamat", bold: false, overflow: false)
                    .expand()
              ]),
              5.heightBox,
            ],
          ).p8(),
        ).rounded.color(abuabumuda).make().wFull(context),
        const Spacer(),
      ],
    ).pOnly(bottom: 30, left: 12, right: 12),
  )
      .white
      .shadow3xl
      .rounded
      .alignBottomCenter
      .make()
      .h(context.screenHeight * 0.4);
}
