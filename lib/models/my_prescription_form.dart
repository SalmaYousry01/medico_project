class Myprescriptionform {
  static const String PRESCRIPTION_FORM = "Prescription Form";
  String? id;

  String medicine;
  String dosage;
  String time;
  String test;
  String prescription;

  Myprescriptionform({
    this.id,

    required this.medicine,
    required this.dosage,
    required this.test,
    required this.time,
    required this.prescription
  });

  Myprescriptionform.fromjson(Map<String, dynamic> json)
      : this(
    id: json["id"],

    medicine: json["medicine"],
    dosage: json["dosage"],
    test: json ["test"],
    time: json ["time"],
    prescription: json ["prescription"],
  );

  Myprescriptionform.notFound()
      : this(
      id: "",

      medicine: "",
      test: "",
      dosage: "",
      time: "",
      prescription: ""
     );

  Map<String, dynamic> tojson() {
    return {
      "id": id,

      "medicine": medicine,
      "test": test,
      "dosage":dosage,
      "time":time,
      "prescription":prescription
    };
  }
}
