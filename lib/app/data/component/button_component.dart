import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'color_data.dart';

Widget textbuttonunactive(value) => "$value"
    .text
    .center
    .size(14)
    .white
    .fontFamily('Roboto')
    .semiBold
    .make()
    .box
    .padding(const EdgeInsets.symmetric(vertical: 12))
    .roundedLg
    .gray400
    .size(276, 42)
    .make();

Widget textbuttonactive(value) => "$value"
    .text
    .center
    .size(14)
    .white
    .fontFamily('Roboto')
    .semiBold
    .make()
    .box
    .roundedLg
    .padding(const EdgeInsets.symmetric(vertical: 12))
    .size(276, 42)
    .color(biru)
    .make();

// BUTTON LAINYA

Widget textsignout(value) => "$value"
    .text
    .center
    .size(16)
    .white
    .fontFamily('Roboto')
    .medium
    .make()
    .box
    .roundedSM
    .padding(const EdgeInsets.symmetric(vertical: 14))
    .size(158, 44)
    .color(merah)
    .make()
    .centered();

Widget textemergency(value) => "$value"
    .text
    .center
    .size(16)
    .white
    .fontFamily('Roboto')
    .medium
    .make()
    .box
    .roundedSM
    .padding(const EdgeInsets.symmetric(vertical: 50))
    .size(163, 123)
    .color(Colors.red)
    .make()
    .centered();
