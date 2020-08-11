import 'package:covid19morocco/data.dart';
import 'package:covid19morocco/models/model_region.dart';
import 'package:covid19morocco/models/model_statistics.dart';

class ServiceData {
  static Future<ModelStatistics> getStatistics() async {
    ModelStatistics statistics = Data.modelStatistics;
    return statistics;
  }

  static Future<List<ModelRegion>> getRegionsData() async {
    List<ModelRegion> regions = Data.listRegions;
    return regions;
  }
}
