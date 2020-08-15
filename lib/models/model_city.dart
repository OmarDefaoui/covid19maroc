class ModelCity {
  String name, newCases;

  ModelCity({
    this.name,
    this.newCases,
  });

  factory ModelCity.fromJson(Map<String, dynamic> json, bool isArabic) =>
      ModelCity(
        name: json["name"].toString().split(':')[isArabic ? 1 : 0].trim(),
        newCases: json["newCases"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "newCases": newCases,
      };
}
