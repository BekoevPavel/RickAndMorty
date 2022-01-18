import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean1/core/error/failure.dart';
import 'package:flutter_clean1/core/usecases/usecase.dart';
import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';
import 'package:flutter_clean1/future/domain/repositories/person_repository.dart';

class SearchPersons extends UseCase<List<PersonEntity>, SearchPersonParams> {
  PersonRepository? personRepository;

  SearchPersons(this.personRepository);
  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      SearchPersonParams params) async {
    return await personRepository!.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  String? query;
  SearchPersonParams(this.query);

  @override
  // TODO: implement props
  List<Object?> get props => [query];
}
