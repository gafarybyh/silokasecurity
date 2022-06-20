import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:siloka_security/app/modules/home/controllers/home_controller.dart';
import 'package:siloka_security/app/modules/home/models/emergency_model.dart';
import 'package:siloka_security/app/modules/recent/controllers/recent_emergency_controller.dart';

class EmergencyController extends GetxController {
  RxList<ParseObject> listEmergency = RxList<ParseObject>();

  @override
  void onInit() {
    doQueryEmergencyByOrdering();
    super.onInit();
  }

  @override
  void onReady() {
    liveQueryEmergency();
    super.onReady();
  }

//REALTIME QUERY EMERGENCY
  void liveQueryEmergency() async {
    final LiveQuery liveQuery = LiveQuery();

    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject('EmergencyMessage'));

    Subscription subscription = await liveQuery.client.subscribe(query);

    //CREATE DATA-----------------------------------------------------
    subscription.on(LiveQueryEvent.create, (value) {
      debugPrint('*** CREATE ***: ${DateTime.now().toString()}\n $value ');

      //tambah data list ke index pertama
      if (value['done'] == false) {
        listEmergency.insert(0, value);
        Get.find<HomeController>().sendPushMessage(
            title: 'Pesan Emergency', message: "${value['pesan']}");
      }
    });

    //UPDATE DATA-----------------------------------------------------
    subscription.on(LiveQueryEvent.update, (value) {
      debugPrint('*** UPDATE ***: ${DateTime.now().toString()}\n $value ');

      String rawJson = (value as ParseObject).toString();
      final createdObject = emergencyModelFromJson(rawJson);
      final index = listEmergency
          .indexWhere((element) => element.objectId == createdObject.objectId);

      listEmergency[index] = value;

      if (listEmergency[index]['done'] == true) {
        //Refresh Data Pesan emergency
        doQueryEmergencyByOrdering();
        //jika data selesai maka tambah ke recent emergency
        Get.find<RecentEmergencyController>()
            .recentEmergency
            .add(listEmergency[index]);
        //lalu refresh recent emergency
        Get.find<RecentEmergencyController>()
            .doQueryRecentEmergencyByOrdering();
      }

      debugPrint("DIUBAH DATA : ${listEmergency[index].toString()}");
    });

    //ENTER DATA-----------------------------------------------------
    subscription.on(LiveQueryEvent.enter, (value) {
      debugPrint('*** ENTER ***: ${DateTime.now().toString()}\n $value ');
    });

    //LEAVE DATA-----------------------------------------------------
    subscription.on(LiveQueryEvent.leave, (value) {
      debugPrint('*** LEAVE ***: ${DateTime.now().toString()}\n $value ');
    });

    //DELETE DATA-----------------------------------------------------
    subscription.on(LiveQueryEvent.delete, (value) {
      debugPrint('*** DELETE ***: ${DateTime.now().toString()}\n $value ');
      String rawJson = (value as ParseObject).toString();
      final createdObject = emergencyModelFromJson(rawJson);
      listEmergency
          .removeWhere((element) => createdObject.objectId == element.objectId);
      //Refresh data emergency
      Get.find<RecentEmergencyController>().doQueryRecentEmergencyByOrdering();
    });
  }

  //UPDATE HTTP DATA EMERGENCY
  Future<void> updateEmergency(String id, bool done) async {
    var update = ParseObject('EmergencyMessage')
      ..objectId = id
      ..set('done', done);
    await update.save();
    EasyLoading.dismiss();
  }

  //QUERY HTTP DATA EMERGENCY
  void doQueryEmergencyByOrdering() async {
    // Create your query
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('EmergencyMessage'));

    // orderByDescending
    parseQuery
      ..whereEqualTo('done', false)
      ..orderByDescending('createdAt');

    // The query will resolve only after calling this method, retrieving
    // an array of `ParseObjects`, if success
    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      // Let's show the results
      for (var o in apiResponse.results!) {
        debugPrint((o as ParseObject).toString());
      }

      listEmergency.value = apiResponse.results as List<ParseObject>;
    } else {
      listEmergency.value = [];
    }
  }
}
