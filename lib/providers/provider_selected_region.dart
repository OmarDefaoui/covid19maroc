import 'package:covid19morocco/models/model_city.dart';
import 'package:flutter/foundation.dart';

class ProviderSelectedRegion extends ChangeNotifier {
  String region = '';
  List<ModelCity> cityCases = [];
  int index = 0;

  void selectRegion(int index, String region, List<ModelCity> cityCases) {
    this.region = region;
    this.cityCases = cityCases;
    this.index = index;
    notifyListeners();
  }

  String get getRegion => region;
  List<ModelCity> get getCityCases => cityCases;
  int get selectedIndex => index;
}
