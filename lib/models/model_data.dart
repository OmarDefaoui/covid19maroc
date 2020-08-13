import 'package:covid19morocco/models/model_region.dart';
import 'package:intl/intl.dart';

class ModelData {
  final String date,
      totalCases,
      newCases,
      totalDeaths,
      newDeaths,
      totalRecovred,
      newRecovred,
      totalActive,
      newActive,
      totalCritical,
      newCritical,
      totalTests,
      newTests;
  final List<ModelRegion> regions;

  ModelData({
    this.date,
    this.totalCases,
    this.newCases,
    this.totalDeaths,
    this.newDeaths,
    this.totalRecovred,
    this.newRecovred,
    this.totalActive,
    this.newActive,
    this.totalCritical,
    this.newCritical,
    this.totalTests,
    this.newTests,
    this.regions,
  });

  factory ModelData.fromJson(Map<String, dynamic> json) => ModelData(
        date: DateFormat("yMMMMEEEEd", 'fr').format(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(json["date"].toString()))),
        totalCases: json["totalCases"],
        newCases: json["newCases"],
        totalDeaths: json["totalDeaths"] ?? '-',
        newDeaths: json["newDeaths"] ?? '-',
        totalRecovred: json["totalRecovred"] ?? '-',
        newRecovred: json["newRecovred"] ?? '-',
        totalActive: json["totalActive"] ?? '-',
        newActive: json["newActive"] ?? '-',
        totalCritical: json["totalCritical"] ?? '-',
        newCritical: json["newCritical"] ?? '-',
        totalTests: json["totalTests"] ?? '-',
        newTests: json["newTests"] ?? '-',
        regions: List<ModelRegion>.from(
            json["regions"].map((region) => ModelRegion.fromJson(region))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "totalCases": totalCases,
        "newCases": newCases,
        "totalDeaths": totalDeaths,
        "newDeaths": newDeaths,
        "totalRecovred": totalRecovred,
        "newRecovred": newRecovred,
        "totalActive": totalActive,
        "newActive": newActive,
        "totalCritical": totalCritical,
        "newCritical": newCritical,
        "totalTests": totalTests,
        "newTests": newTests,
        "regions": List<dynamic>.from(regions.map((region) => region.toJson())),
      };
}
