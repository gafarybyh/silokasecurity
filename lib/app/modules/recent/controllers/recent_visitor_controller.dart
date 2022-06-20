import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class RecentVisitorController extends GetxController {
  RxList<ParseObject> recentVisitor = RxList<ParseObject>();

  @override
  void onInit() {
    doQueryRecentVisitorByOrdering();
    super.onInit();
  }

//QUERY HTTP DATA VISITOR
  void doQueryRecentVisitorByOrdering() async {
    // Create your query
    final QueryBuilder<ParseObject> parseQuery =
        QueryBuilder<ParseObject>(ParseObject('VisitorMessage'));

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

      recentVisitor.value = apiResponse.results as List<ParseObject>;
    } else {
      recentVisitor.value = [];
    }
  }
}
