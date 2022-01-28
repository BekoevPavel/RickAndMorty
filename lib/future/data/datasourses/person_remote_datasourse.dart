import 'package:flutter_clean1/future/data/models/person_model.dart';
import 'package:flutter_clean1/future/domain/usecases/get_all_persons.dart';

abstract class PersonRemoteDataSourse {
  /// Calls the https://rickandmortyapi.com/api/character/?page=1 endpoint
  ///
  /// Throws a [ServerExeption] for all errors codes
  Future<List<PersonModel>> getAllPersons(int page);

  /// Calls the https://rickandmortyapi.com/api/character/?name=rick endpoint
  ///
  /// Throws a [ServerExeption] for all errors codes
  Future<List<PersonModel>> searchPerson(String query);
}
