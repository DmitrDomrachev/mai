import 'dart:developer';

import 'package:mai/feature/schedule/exceptiion/loading_exception.dart';
import 'package:mai/feature/setting/models/models.dart';

import 'package:mai/feature/schedule/data_provider/i_shedule_data.dart';
import 'package:mai/feature/schedule/models/models.dart';
import 'package:dio/dio.dart';

class ScheduleClient extends IScheduleWebDataSource {
  final _baseUrl = 'https://jutter.online/mai_v2/api';
  final _apiKey = 'fe2a7095-c894-4d07-a68f-e9e27be2b175';
  // final _apiKey = 'fe2a7095-c894-4d07-a68f-e9e27b75';
  var dio = Dio();

  @override
  Future<List<Week>> getScheduleByGroup(Group group) async {
    log('getScheduleByGroup from web');
    var url = '/schedule/all/${group.id}';
    dio.options.headers['ApiKey'] = _apiKey;
    var response;
    try {
      response = await dio.get(_baseUrl + url);
    } catch (exception) {
      throw ScheduleLoadingException('Connection error: ${exception.toString()}');
    }
    if (response.statusCode != 200) {
      throw ScheduleLoadingException('Response code: ${response.statusCode}');
    }
    if (!response.data['success']) {
      throw ScheduleLoadingException('Response error: ${response.data['message']}');
    }

    final dataList = response.data['data'];

    List<Week> result = [];

    for (var i in dataList) {
      result.add(Week.fromJson(i));
    }
    return result;
  }
}
