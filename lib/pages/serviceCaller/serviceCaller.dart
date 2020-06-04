// import 'dart:js';

import 'package:dio/dio.dart';
import 'package:fetchtask/constants/constants.dart';
import 'package:fetchtask/pages/Models/model.dart';
import 'package:flutter/cupertino.dart';

class FetchJsonSC {
  Future<JsonModel> fetchJsonSC({
    @required int type,
  }) async {
    try {
      JsonModel datas;
      Dio _dio = Dio();
      String url =
          type == Constants.hotPageType ? Constants.hotUrl : Constants.newUrl;
      var result = await _dio.get(url);
      datas = JsonModel.fromJson(result.data);
      return datas;
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }
}
