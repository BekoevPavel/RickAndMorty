import 'package:flutter_clean1/future/data/models/location_model.dart';
import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';
import 'package:meta/meta.dart';

class PersonModel extends PersonEntity {
  PersonModel({
    @required id,
    @required name,
    @required status,
    @required species,
    @required type,
    @required gender,
    @required origin,
    @required location,
    @required image,
    @required episodies,
    @required created,
  }) : super(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episodies: episodies,
            created: created);

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: json['origin'] != null
            ? LocatiomModel.fromJson(json['origin'])
            : null,
        location: json['location'] != null
            ? LocatiomModel.fromJson(json['location'])
            : null,
        image: json['image'],
        episodies: ((json['episode'] as List<dynamic>).map((e) => e as String))
            .toList(),
        created: DateTime.parse(json['created'] as String));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
      'episode': episodies,
      'created': created!.toIso8601String(),
    };
  }
}
