import 'package:covid19morocco/models/model_city.dart';
import 'package:flutter/foundation.dart';

class ProviderSelectedRegion extends ChangeNotifier {
  String region = '';
  List<ModelCity> cityCases = [];

  void selectRegion(String region, List<ModelCity> cityCases) {
    this.region = region;
    this.cityCases = cityCases;
    notifyListeners();
  }

  String get getRegion => region;
  List<ModelCity> get getCityCases => cityCases;
}
