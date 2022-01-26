import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_clean1/core/error/exeption.dart';
import 'package:flutter_clean1/future/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataCourse {
  /// Gets the cached  which [List<PersonModel>] was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheExeption] if no cached data is present

  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personToChahe(List<PersonModel> persons);
}

class PersonLocalDataSourseImpl implements PersonLocalDataCourse {
  SharedPreferences? sharedPreferences;

  PersonLocalDataSourseImpl({@required this.sharedPreferences});
  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences!.getStringList('cachedPersonsList');
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheExeption();
    }
  }

  @override
  Future<void> personToChahe(List<PersonModel> persons) {
    List<String> jsonPersonList =
        persons.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences!.setStringList('cachedPersonsList', jsonPersonList);
    print('Persons to write Cache ${jsonPersonList.length}');

    return Future.value(jsonPersonList);
  }
}
