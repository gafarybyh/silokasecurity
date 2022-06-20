import 'package:flutter/material.dart';
import 'package:siloka_security/app/data/component/color_data.dart';
import 'package:velocity_x/velocity_x.dart';

Widget textHeadline({String? text, bool? colorwhite = false}) {
  return Text(text!)
      .text
      .size(24)
      .color(colorwhite == true ? Vx.white : Vx.black)
      .fontFamily("Roboto")
      .fontWeight(FontWeight.w600)
      .make();
}

Widget textHeadline2({String? text = "User", bool? colorwhite = true}) {
  return Text(text!)
      .text
      .size(20)
      .color(colorwhite == true ? Vx.white : Vx.black)
      .fontFamily("Roboto")
      .fontWeight(FontWeight.w600)
      .make();
}

Widget textsubHeadlineBlack({String? text}) {
  return Text(text!)
      .text
      .size(16)
      .black
      .fontFamily("Roboto")
      .fontWeight(FontWeight.w500)
      .make();
}

Widget textsubHeadlineGrey({String? text}) {
  return Text(text!)
      .text
      .size(16)
      .color(abuabumuda)
      .fontFamily("Roboto")
      .make();
}

Widget textRegular({String? text, bool? bold = false, bool? overflow = true}) {
  return Text(text!)
      .text
      .size(15)
      .fontFamily("Roboto")
      .fontWeight(bold == true ? FontWeight.w500 : FontWeight.normal)
      .overflow(overflow == true ? TextOverflow.ellipsis : TextOverflow.clip)
      .make();
}

Widget textSubHead({String? text}) {
  return Text(text!)
      .text
      .size(13)
      .gray400
      .fontFamily("Roboto")
      .fontWeight(FontWeight.w500)
      .ellipsis
      .make();
}

Widget textSubRegular({String? text, bool? bold = false}) {
  return Text(text!)
      .text
      .size(13)
      .gray500
      .ellipsis
      .fontFamily("Roboto")
      .fontWeight(bold == true ? FontWeight.w500 : FontWeight.normal)
      .make();
}

// BUTTON TEXT

Widget textButton({String? text, bool? colorwhite = false}) {
  return Text(text!)
      .text
      .size(12)
      .fontFamily("Roboto")
      .color(colorwhite == true ? Vx.white : Vx.black)
      .fontWeight(FontWeight.w700)
      .make();
}
