import 'package:flutter_clean1/core/error/failure.dart';
import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPesons(int? page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String? query);
}
