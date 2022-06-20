import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget textFieldComponent(
    {TextEditingController? controller,
    String? hint,
    bool? isPassword,
    bool? obscureText,
    Icon? prefixIcon}) {
  return VxTextField(
    controller: controller!,
    hint: hint!,
    validator: (value) {
      if (value!.isEmpty) {
        return hint + " kosong";
      }
      return null;
    },
    borderType: VxTextFieldBorderType.roundLine,
    isPassword: isPassword!,
    obscureText: obscureText!,
    borderRadius: 20,
    prefixIcon: prefixIcon!,
  );
}
