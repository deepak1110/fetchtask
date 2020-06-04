import 'package:fetchtask/pages/Models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Commons extends ChangeNotifier {
  Stream<JsonModel> hotData;
  JsonModel newData;

  getHotData() {
    return hotData;
  }

  setHotData(Stream<JsonModel> data) {
    hotData = data;
    notifyListeners();
  }

  getNewData() {
    return hotData;
  }

  setNewData(Stream<JsonModel> data) {
    hotData = data;
    notifyListeners();
  }
}
