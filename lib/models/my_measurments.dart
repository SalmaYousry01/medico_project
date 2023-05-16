class Mymeasurments {
  static const String MEASURMENTS = "Measurments";
  String? id;

  String height;
  String weight;
  String blood_pressure;
  String blood_sugar;

  Mymeasurments({
    this.id,
    required this.height,
    required this.weight,
    required this.blood_pressure,
    required this.blood_sugar,
  });

  Mymeasurments.fromjson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          height: json["height"],
          weight: json["weight"],
          blood_pressure: json["blood_pressure"],
          blood_sugar: json["blood_sugar"],
        );

  Mymeasurments.notFound()
      : this(
          id: "",
          height: "",
          weight: "",
          blood_pressure: "",
          blood_sugar: "",
        );

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "height": height,
      "weight": weight,
      "blood pressure": blood_pressure,
      "blood sugar": blood_sugar,
    };
  }
}
