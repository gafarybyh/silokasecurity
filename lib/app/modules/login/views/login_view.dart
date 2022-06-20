import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:siloka_security/app/data/component/textfield_component.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../data/component/color_data.dart';
import '../../../data/component/text_component.dart';
import '../controllers/login_controller.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: VxBox(
          child: VStack(
            [
              VxBox(
                child: Form(
                  key: formKey,
                  child: VStack(
                    [
                      20.heightBox,
                      textHeadline(text: "SILOKA").centered(),
                      textRegular(text: "Security Monitor", bold: true)
                          .centered(),
                      20.heightBox,
                      textRegular(text: "Login ID", bold: true).p4(),
                      textFieldComponent(
                        controller: controller.txtloginid,
                        isPassword: false,
                        obscureText: false,
                        hint: "Login ID atau Username",
                        prefixIcon: const Icon(Icons.credit_card, size: 18),
                      ),
                      const HeightBox(15),
                      textRegular(text: "Kata Sandi", bold: true).p4(),
                      textFieldComponent(
                        controller: controller.txtkatasandi,
                        hint: "Kata Sandi",
                        isPassword: true,
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock, size: 18),
                      ),
                      5.heightBox,
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: "Lupa Kata Sandi ?"
                              .text
                              .size(15)
                              .color(biru)
                              .make(),
                        ),
                      ).objectCenterRight(),
                      20.heightBox,
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            EasyLoading.show();
                            controller.doUserLogin();
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(Vx.m12),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                          backgroundColor: MaterialStateProperty.all(biru),
                        ),
                        child: HStack([
                          Expanded(
                            child: textRegular(text: "Masuk", bold: true)
                                .centered(),
                          )
                        ]),
                      ),
                      20.heightBox,
                    ],
                    alignment: MainAxisAlignment.center,
                  ),
                ),
              )
                  .width(context.screenWidth * 0.8)
                  .white
                  .rounded
                  .px12
                  .shadow2xl
                  .make(),
            ],
            alignment: MainAxisAlignment.center,
            crossAlignment: CrossAxisAlignment.center,
          ),
        ).make().whFull(context),
      ),
    );
  }
}




           // textHeadline(text: "Text HeadLine"),
              // textsubHeadline(text: "Text Sub Headline"),
              // textRegular(text: "Text Regular"),
              // textSubHead(text: "Text SubHead"),

              // //
              // // Button Stack
              // //

              // HStack([
              //   buttonactive("KONFIRMASI").expand(),
              //   buttonunactive("TIDAK AKTIF").expand()
              // ]).centered().py4().wFull(context),

              // //
              // // Button Single Middle Stack
              // //

              // signout("KELUAR").py4(),
              // emergency("EMERGENCY").py4(),

              // cardemergency("Test Title")