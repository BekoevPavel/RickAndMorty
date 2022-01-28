import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean1/core/error/failure.dart';
import 'package:flutter_clean1/future/domain/usecases/search_person.dart';
import 'package:flutter_clean1/future/presentation/bloc/search_bloc/search_event.dart';
import 'package:flutter_clean1/future/presentation/bloc/search_bloc/search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  SearchPersons? searchPersons;

  PersonSearchBloc({@required this.searchPersons})
      : super(PersonSearchEmpty()) {}
  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is SearchPerson) {
      yield* _mapFetchPersonToState(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonToState(String personQuery) async* {
    yield PersonSearchLoading();
    (SearchPersonParams(query: personQuery));

    final failureOrPerson =
        await searchPersons!(SearchPersonParams(query: personQuery));

    yield failureOrPerson.fold(
        (failure) => PersonSearchError(message: 'errorBitch'),
        (person) => PersonSearchLoaded(persons: person));
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
