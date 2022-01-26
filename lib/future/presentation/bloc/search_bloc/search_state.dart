import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';

abstract class PersonSearchState extends Equatable {
  PersonSearchState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonSearchEmpty extends PersonSearchState {}

class PersonSearchLoading extends PersonSearchState {} // загружаются

class PersonSearchLoaded extends PersonSearchState {
  List<PersonEntity>? persons;

  PersonSearchLoaded({@required this.persons});

  @override
  // TODO: implement props
  List<Object?> get props => [persons];
} // загрузились

class PersonSearchError extends PersonSearchState {
  String? message;
  PersonSearchError({@required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
