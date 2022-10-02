import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mai/feature/info/models/campus.dart';

import '../models/live.dart';

abstract class ICampusWebDataProvider {
  Future<List<Buffet>> getBuffets();

  Future<List<Library>> getLibraries();

  Future<List<Stadium>> getStadiums();

  Future<List<StudentOrganization>> getStudentOrganizations();

  Future<List<CreativeOrganizations>> getCreativeOrganizations();
}

class CampusWebDataProvider implements ICampusWebDataProvider {
  final _baseUrl = 'https://jutter.online/mai_v2//api';
  final _apiKey = 'fe2a7095-c894-4d07-a68f-e9e27be2b175';
  var dio = Dio();

  @override
  Future<List<Buffet>> getBuffets() async {
    var url = '/canteens/all';
    dio.options.headers['ApiKey'] = _apiKey;
    final response = await dio.get(_baseUrl + url);

    final dataList = response.data['data'];

    List<Buffet> result = [];

    for (var i in dataList) {
      result.add(Buffet.fromJson(i));
    }

    return result;
  }

  @override
  Future<List<Library>> getLibraries() async {
    var url = '/library/all';
    dio.options.headers['ApiKey'] = _apiKey;
    final response = await dio.get(_baseUrl + url);

    final dataList = response.data['data'];

    List<Library> result = [];

    for (var i in dataList) {
      result.add(Library.fromJson(i));
    }

    return result;
  }

  @override
  Future<List<Stadium>> getStadiums() async {
    var url = '/sport/all';
    dio.options.headers['ApiKey'] = _apiKey;
    final response = await dio.get(_baseUrl + url);

    final dataList = response.data['data'];

    List<Stadium> result = [];

    for (var i in dataList) {
      result.add(Stadium.fromJson(i));
    }

    return result;
  }

  @override
  Future<List<StudentOrganization>> getStudentOrganizations() async {
    var url = '/studorg/all';
    dio.options.headers['ApiKey'] = _apiKey;
    final response = await dio.get(_baseUrl + url);

    final dataList = response.data['data'];

    List<StudentOrganization> result = [];

    for (var i in dataList) {
      result.add(StudentOrganization.fromJson(i));
    }

    return result;
  }

  @override
  Future<List<CreativeOrganizations>> getCreativeOrganizations() async {
    var url = '/creative/all';
    dio.options.headers['ApiKey'] = _apiKey;
    final response = await dio.get(_baseUrl + url);

    final dataList = response.data['data'];

    List<CreativeOrganizations> result = [];

    for (var i in dataList) {
      result.add(CreativeOrganizations.fromJson(i));
    }

    return result;
  }
}
