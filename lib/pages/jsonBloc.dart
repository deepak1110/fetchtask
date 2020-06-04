import 'package:fetchtask/pages/Models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'serviceManager/serviceManager.dart';

class JsonBloc {
  final datasJson = BehaviorSubject<JsonModel>();
  // JsonModel oldjson = JsonModel();
  Stream<JsonModel> get dataOut => datasJson.stream;

  fetchData({@required int type}) async {
    ServiceManager serviceManager = ServiceManager();

    JsonModel data = await serviceManager.serviceManager(type: type);
    datasJson.add(data);
    // print('datas')
  }

  void dispose() {
    datasJson.close();
  }
}
