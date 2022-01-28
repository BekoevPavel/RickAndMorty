import 'package:flutter/cupertino.dart';
import 'package:flutter_clean1/core/error/exeption.dart';
import 'package:flutter_clean1/core/platform/network_info.dart';
import 'package:flutter_clean1/future/data/datasourses/person_local_datasourse.dart';
import 'package:flutter_clean1/future/data/datasourses/person_remote_datasourse.dart';

import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';
import 'package:flutter_clean1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean1/future/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  PersonRemoteDataSourseIml? remoteDataSourse;
  PersonLocalDataSourseImpl? localDataCourse;
  NetworkInfo? networkInfo;
  PersonRepositoryImpl(
      {@required this.remoteDataSourse,
      @required this.localDataCourse,
      @required this.networkInfo});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPesons(int? page) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePerson = await remoteDataSourse!.getAllPersons(page!);
        localDataCourse!.personToChahe(remotePerson);
        return Right(remotePerson);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataCourse!.getLastPersonsFromCache();

        return Right(localPerson);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(
      String? query) async {
    if (await networkInfo!.isConnected) {
      try {
        final remotePerson = await remoteDataSourse!.searchPerson(query!);
        localDataCourse!.personToChahe(remotePerson);
        return Right(remotePerson);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataCourse!.getLastPersonsFromCache();

        return Right(localPerson);
      } on CacheExeption {
        return Left(CacheFailure());
      }
    }
  }
}
