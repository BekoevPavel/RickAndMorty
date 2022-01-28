import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean1/future/data/datasourses/person_remote_datasourse.dart';
import 'package:flutter_clean1/future/data/models/person_model.dart';
import 'package:http/http.dart' as http;

class ServerExeption implements Exception {}

class CacheExeption implements Exception {}

class PersonRemoteDataSourseIml implements PersonRemoteDataSourse {
  final http.Client? client;

  PersonRemoteDataSourseIml({@required this.client});
  @override
  Future<List<PersonModel>> getAllPersons(int page) async {
    final response = await client!.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'),
        headers: {'Content-type': 'application/json'});

    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((e) => PersonModel.fromJson(e))
          .toList();
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<List<PersonModel>> searchPerson(String query) async {
    final response = await client!.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?name=$query'),
        headers: {'Content-type': 'application/json'});
    if (response.statusCode == 200) {
      final persons = json.decode(response.body);
      return (persons['results'] as List)
          .map((e) => PersonModel.fromJson(e))
          .toList();
    } else {
      throw ServerExeption();
    }
  }
}
