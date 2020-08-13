import 'package:covid19morocco/models/model_city.dart';

class ModelRegion {
  final String name, totalCases, newCases;
  final List<ModelCity> cities;

  ModelRegion({
    this.name,
    this.totalCases,
    this.newCases,
    this.cities,
  });

  factory ModelRegion.fromJson(Map<String, dynamic> json) => ModelRegion(
        name: json["name"],
        newCases: json["newCases"],
        totalCases: json["totalCases"],
        cities: List<ModelCity>.from(
            json["cities"].map((city) => ModelCity.fromJson(city))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "newCases": newCases,
        "totalCases": totalCases,
        "cities": List<dynamic>.from(cities.map((city) => city.toJson())),
      };
}
