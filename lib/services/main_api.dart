import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Dio dio = Dio();
Response? response;

class Api extends ChangeNotifier {
  String endPointIndodax = 'https://indodax.com/api/pairs';
  String endPointIndodaxDetail = 'https://indodax.com/api/ticker';
  bool isLGeneral = false;
  List<dynamic>? dataIndodax;
  Map? dataIndodaxDetail;

  Future<dynamic> goUrl(
    String url,
    Map<String, dynamic> param,
  ) async {
    try {
      FormData formData = FormData.fromMap(param);
      response = await dio.post(url, data: formData);
      try {
        return response!.data;
      } on FormatException {
        EasyLoading.showError('Terjadi masalah di server {notJson}');
        return {};
      }
    } on DioException catch (e) {
      EasyLoading.showError(e.error.toString());
      return {};
    }
  }

  Future getDataIndodax(BuildContext context,
      {bool mounted = true, bool loading = true}) async {
    final param = {
      'null': 'null',
    };
    dataIndodaxDetail = {};
    final respons = await goUrl(
      endPointIndodax,
      param,
    );
    if (respons != {}) {
      for (var item in respons) {
        dataIndodaxDetail?[item['id'].toString()] = null;
      }
      dataIndodax = respons;
    }
    notifyListeners();
  }

  Future getDataIndodaxDet(BuildContext context, String id,
      {bool mounted = true, bool loading = true}) async {
    final param = {
      'null': 'null',
    };
    final respons = await goUrl(
      '$endPointIndodaxDetail/$id',
      param,
    );
    if (respons != {}) {
      dataIndodaxDetail?[id] = respons['ticker'];
    }
    notifyListeners();
  }

  Future getLoopDetail(BuildContext context, String id,
      {bool mounted = true, bool loading = true}) async {
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      getDataIndodaxDet(context, id);
    });
  }
}
