import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean1/core/error/failure.dart';
import 'package:flutter_clean1/core/usecases/usecase.dart';
import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';
import 'package:flutter_clean1/future/domain/repositories/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  PersonRepository? personRepository;

  GetAllPersons(this.personRepository);
  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepository!.getAllPesons(params.page);
  }
}

class PagePersonParams extends Equatable {
  int? page;

  PagePersonParams({@required this.page});
  @override
  // TODO: implement props
  List<Object?> get props => [page];
}
