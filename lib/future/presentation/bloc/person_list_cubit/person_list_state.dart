import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  List<PersonEntity>? oldPersonsList;
  bool? isFirstFetch;

  PersonLoading(this.oldPersonsList, {this.isFirstFetch = false});
  @override
  List<Object?> get props => [oldPersonsList];
}

class PersonLoaded extends PersonState {
  List<PersonEntity>? personsList;

  PersonLoaded(this.personsList);
  @override
  List<Object?> get props => [personsList];
}

class PersonError extends PersonState {
  String? message;
  PersonError({@required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
