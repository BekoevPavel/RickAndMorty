import 'package:flutter_clean1/future/domain/entities/peson_entity.dart';

class LocatiomModel extends LocationEntity {
  LocatiomModel({name, url}) : super(name: name, url: url);

  factory LocatiomModel.fromJson(Map<String, dynamic> json) {
    return LocatiomModel(name: json['name'], url: 'url');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
