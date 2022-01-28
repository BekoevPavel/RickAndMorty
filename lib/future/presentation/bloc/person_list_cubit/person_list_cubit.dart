import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean1/core/error/failure.dart';
import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';
import 'package:flutter_clean1/future/domain/usecases/get_all_persons.dart';
import 'package:flutter_clean1/future/presentation/bloc/person_list_cubit/person_list_state.dart';

class PersonListCubit extends Cubit<PersonState> {
  GetAllPersons? getAllPersons;
  PersonListCubit({@required this.getAllPersons}) : super(PersonEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is PersonLoading) {
      return;
    }

    final currentState = state;
    var oldPerson = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPerson = currentState.personsList!;
    }
    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons!(PagePersonParams(page: page));
    failureOrPerson.fold(
        (error) => emit(PersonError(message: _mapFailureToMessage(error))),
        (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons!.addAll(character);
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unenspected error';
    }
  }
}
