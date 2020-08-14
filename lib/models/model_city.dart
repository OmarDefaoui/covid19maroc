class ModelCity {
  String name, newCases;

  ModelCity({
    this.name,
    this.newCases,
  });

  factory ModelCity.fromJson(Map<String, dynamic> json) => ModelCity(
        name: json["name"],
        newCases: json["newCases"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "newCases": newCases,
      };
}
