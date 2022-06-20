import 'package:get/get.dart';
import 'package:siloka_security/app/modules/home/controllers/emergency_controller.dart';
import 'package:siloka_security/app/modules/home/controllers/home_controller.dart';
import 'package:siloka_security/app/modules/home/controllers/visitor_controller.dart';
import 'package:siloka_security/app/modules/profile/controllers/profile_controller.dart';
import 'package:siloka_security/app/modules/recent/controllers/recent_emergency_controller.dart';
import 'package:siloka_security/app/modules/recent/controllers/recent_visitor_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController());
    Get.put<VisitorController>(VisitorController());
    Get.put<EmergencyController>(EmergencyController());
    Get.put<HomeController>(HomeController());
    Get.put<RecentVisitorController>(RecentVisitorController());
    Get.put<RecentEmergencyController>(RecentEmergencyController());
  }
}
