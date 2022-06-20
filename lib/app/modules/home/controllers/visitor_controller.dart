import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:siloka_security/app/modules/home/controllers/home_controller.dart';
import 'package:siloka_security/app/modules/recent/controllers/recent_visitor_controller.dart';
import '../models/visitor_model.dart';

class VisitorController extends GetxController {
  RxList<ParseObject> listVisitor = RxList<ParseObject>();

  @override
  void onInit() {
    doQueryVisitorByOrdering();
    super.onInit();
  }

  @override
  void onReady() {
    liveQueryVisitor();
    super.onReady();
  }

//UPDATE HTTP DATA VISITOR
  Future<void> updateVisitor(String id, bool done) async {
    var update = ParseObject('VisitorMessage')
      ..objectId = id
      ..set('done', done);
    await update.save();
    EasyLoading.dismiss();
  }

//QUERY HTTP DATA VISITOR
  void doQueryVisitorByOrdering() async {
    // Create your query
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('VisitorMessage'));

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

      listVisitor.value = apiResponse.results as List<ParseObject>;
    } else {
      listVisitor.value = [];
    }
  }

//REALTIME QUERY VISITOR
  void liveQueryVisitor() async {
    final LiveQuery liveQuery = LiveQuery();

    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject('VisitorMessage'));

    Subscription subscription = await liveQuery.client.subscribe(query);

    //CREATE DATA-----------------------------------------------------
    subscription.on(LiveQueryEvent.create, (value) {
      debugPrint('*** CREATE ***: ${DateTime.now().toString()}\n $value ');

      //tambah data list ke index pertama
      if (value['done'] == false) {
        listVisitor.insert(0, value);
        Get.find<HomeController>().sendPushMessage(
            title: 'Pesan Visitor', message: "${value['pesan']}");
      }
    });

    //UPDATE DATA-----------------------------------------------------
    subscription.on(LiveQueryEvent.update, (value) {
      debugPrint('*** UPDATE ***: ${DateTime.now().toString()}\n $value ');

      String rawJson = (value as ParseObject).toString();
      final createdObject = visitorModelFromJson(rawJson);
      final index = listVisitor
          .indexWhere((element) => element.objectId == createdObject.objectId);

      listVisitor[index] = value;

      if (listVisitor[index]['done'] == true) {
        //Refresh Data Pesan visitor
        doQueryVisitorByOrdering();
        //jika data selesai maka tambah ke recent visitor
        Get.find<RecentVisitorController>()
            .recentVisitor
            .add(listVisitor[index]);
        //lalu refresh recent visitor
        Get.find<RecentVisitorController>().doQueryRecentVisitorByOrdering();
      }

      debugPrint("DIUBAH DATA : ${listVisitor[index].toString()}");
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
      final createdObject = visitorModelFromJson(rawJson);
      listVisitor
          .removeWhere((element) => createdObject.objectId == element.objectId);
      //refresh data visitor
      Get.find<RecentVisitorController>().doQueryRecentVisitorByOrdering();
    });
  }
}
