import 'dart:developer';

import 'package:mai/feature/setting/models/models.dart';
import 'package:dio/dio.dart';

import 'i_setting_data.dart';

class SettingClient implements ISettingWebDataSource {
  final _baseUrl = 'https://jutter.online/mai_v2//api';
  final _apiKey = 'fe2a7095-c894-4d07-a68f-e9e27be2b175';
  var dio = Dio();

  @override
  Future<List<Group>> getGroupByName(String name) async {
    log('getGroupByName $name');

    var url = '/groups/search/$name';

    dio.options.headers['ApiKey'] = _apiKey;

    final response = await dio.get(_baseUrl + url);
    log(response.toString());

    final dataList = response.data['data'];

    List<Group> result = [];

    for (var i in dataList) {
      result.add(Group.fromJson(i));
    }
    return result;
  }
}


