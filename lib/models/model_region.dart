import 'package:covid19morocco/models/model_city.dart';

class ModelRegion {
  String name, totalCases, newCases;
  List<ModelCity> cities;

  ModelRegion({
    this.name,
    this.totalCases,
    this.newCases,
    this.cities,
  });

  factory ModelRegion.fromJson(Map<String, dynamic> json, bool isArabic) =>
      ModelRegion(
        name: json["name"].toString().split(':')[isArabic ? 1 : 0].trim(),
        newCases: json["newCases"],
        totalCases: json["totalCases"],
        cities: List<ModelCity>.from(
            json["cities"].map((city) => ModelCity.fromJson(city, isArabic))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "newCases": newCases,
        "totalCases": totalCases,
        "cities": List<dynamic>.from(cities.map((city) => city.toJson())),
      };
}
