import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LocationEntity {
  String? name;
  String? url;
  LocationEntity({this.name, this.url});
}

class PersonEntity extends Equatable {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;

  final LocationEntity? origin;
  final LocationEntity? location;

  final String? image;

  final List<String>? episodies;

  final DateTime? created;

  PersonEntity({
    @required this.id,
    @required this.name,
    @required this.status,
    @required this.species,
    @required this.type,
    @required this.gender,
    @required this.origin,
    @required this.location,
    @required this.image,
    @required this.episodies,
    @required this.created,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episodies,
        created
      ];
}
