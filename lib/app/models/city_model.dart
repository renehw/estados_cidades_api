import 'dart:convert';

class CityModel {
  final String name;
  final String ibge;

  CityModel({
    required this.name,
    required this.ibge,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': name,
      'codigo_ibge': ibge,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {'nome': final String nome, 'codigo_ibge': final String ibge} => CityModel(
          name: nome,
          ibge: ibge,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) => CityModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CityModel && other.name == name && other.ibge == ibge;
  }

  @override
  int get hashCode => name.hashCode ^ ibge.hashCode;
}
