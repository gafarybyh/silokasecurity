import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:siloka_security/app/data/component/color_data.dart';
import 'package:siloka_security/app/modules/home/views/home_view.dart';
import 'package:siloka_security/app/modules/profile/views/profile_view.dart';
import 'package:siloka_security/app/modules/recent/views/recent_view.dart';
import 'package:velocity_x/velocity_x.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeView(),
      const RecentView(),
      const ProfileView(),
    ];
    RxInt currentIndex = 0.obs;

    void changePage(int index) {
      currentIndex.value = index;
    }

    return Obx(() => Scaffold(
          body: ZStack([
            pages[currentIndex.value],
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data:
                    Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: SalomonBottomBar(
                  margin: Vx.m12,
                  currentIndex: currentIndex.value,
                  onTap: changePage,
                  items: [
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.message),
                      title: const Text("Pesan"),
                      selectedColor: biru,
                    ),
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.event_available),
                      title: const Text("Selesai"),
                      selectedColor: hijau,
                    ),
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.person),
                      title: const Text("Profil"),
                      selectedColor: oren,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }
}
