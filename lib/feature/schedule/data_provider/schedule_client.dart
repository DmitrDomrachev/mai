import 'dart:developer';

import 'package:mai/feature/setting/models/models.dart';

import 'package:mai/feature/schedule/data_provider/i_shedule_data.dart';
import 'package:mai/feature/schedule/models/models.dart';
import 'package:dio/dio.dart';

class ScheduleClient extends IScheduleWebDataSource {
  final _baseUrl = 'https://jutter.online/mai_v2//api';
  final _apiKey = 'fe2a7095-c894-4d07-a68f-e9e27be2b175';
  var dio = Dio();

  @override
  Future<List<Week>> getScheduleByGroup(Group group) async {
    log('getScheduleByGroup from web');
    var url = '/schedule/all/${group.id}';
    dio.options.headers['ApiKey'] = _apiKey;
    final response = await dio.get(_baseUrl + url);
    final dataList = response.data['data'];

    List<Week> result = [];

    for (var i in dataList) {
      result.add(Week.fromJson(i));
    }
    return result;
  }
}
