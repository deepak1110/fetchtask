import 'package:fetchtask/constants/constants.dart';
import 'package:fetchtask/db/databaseProvider.dart';
import 'package:fetchtask/pages/Models/model.dart';
import 'package:fetchtask/pages/serviceCaller/serviceCaller.dart';
import 'package:flutter/cupertino.dart';

class ServiceManager {
  Future<JsonModel> serviceManager({
    @required int type,
  }) async {
    JsonModel datas;
    DatabaseHelper db = DatabaseHelper();
    FetchJsonSC fetchJsonSC = FetchJsonSC();
    String dbTableName =  type == Constants.hotPageType ? Constants.dBTablHot :Constants.dBTablNew;
    var user = await db.getJson(
      dbTableName: dbTableName
    );
    if (user == null) {
      datas = await fetchJsonSC.fetchJsonSC(
        type: type,
      );
      if (datas.children != null && datas.children.length > 0) {
        datas.children.forEach((datas) async {
          await db.saveJson(
            datas,
            dbTableName: dbTableName,
          );
        });
      }
    } else {
      JsonModel jsonDbData = JsonModel();
      jsonDbData.children = user;

      datas = jsonDbData;
    }

    return datas;
  }
}
