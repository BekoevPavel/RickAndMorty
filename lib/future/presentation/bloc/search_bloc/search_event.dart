import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {
  PersonSearchEvent();
  @override // TODO: implement props
  List<Object?> get props => [];
}

class SearchPerson extends PersonSearchEvent {
  final String personQuery;

  SearchPerson(this.personQuery);
}
