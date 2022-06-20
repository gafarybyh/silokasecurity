import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class RecentEmergencyController extends GetxController {
  RxList<ParseObject> recentEmergency = RxList<ParseObject>();

  @override
  void onInit() {
    doQueryRecentEmergencyByOrdering();
    super.onInit();
  }

  //QUERY HTTP DATA EMERGENCY
  void doQueryRecentEmergencyByOrdering() async {
    // Create your query
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('EmergencyMessage'));

    // orderByDescending
    parseQuery
      ..whereEqualTo('done', true)
      ..orderByDescending('updatedAt');

    // The query will resolve only after calling this method, retrieving
    // an array of `ParseObjects`, if success
    final ParseResponse apiResponse = await parseQuery.query();

    if (apiResponse.success && apiResponse.results != null) {
      // Let's show the results
      for (var o in apiResponse.results!) {
        debugPrint((o as ParseObject).toString());
      }

      recentEmergency.value = apiResponse.results as List<ParseObject>;
    } else {
      recentEmergency.value = [];
    }
  }
}
