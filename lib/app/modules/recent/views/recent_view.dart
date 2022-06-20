import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:siloka_security/app/data/component/color_data.dart';
import 'package:siloka_security/app/data/component/text_component.dart';
import 'package:siloka_security/app/modules/recent/views/recent_emergency_page.dart';
import 'package:velocity_x/velocity_x.dart';

import 'recent_visitor_page.dart';

class RecentView extends StatelessWidget {
  const RecentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VxBox(
          child: VStack(
            [
              15.heightBox,
              textHeadline(text: "Laporan Selesai").pOnly(left: 12),
              5.heightBox,
              const Divider(color: abuabutua).px12(),
              Expanded(
                child: ContainedTabBarView(
                  tabs: [
                    textRegular(text: "Visitor", bold: true),
                    textRegular(text: "Emergency", bold: true),
                  ],
                  tabBarProperties: TabBarProperties(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                    ),
                    background: Container(
                      width: context.screenWidth * 0.8,
                      decoration: const BoxDecoration(
                        color: abuabumuda,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                    indicator: ContainerTabIndicator(
                      borderColor: abuabutua,
                      borderWidth: 1,
                      padding: Vx.mH8,
                      radius: BorderRadius.circular(30),
                      color: Vx.white,
                    ),
                    labelColor: biru,
                    unselectedLabelColor: Vx.black,
                  ),
                  views: [
                    const RecentVisitorPage().pOnly(top: 15),
                    const RecentEmergencyPage().pOnly(top: 15),
                  ],
                ),
              ),
              Padding(padding: context.screenPadding * 2)
            ],
          ),
        ).make().whFull(context),
      ),
    );
  }
}
