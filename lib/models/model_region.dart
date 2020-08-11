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
}
