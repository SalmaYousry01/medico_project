class Myprescription {
  static const String PRESCRIPTION = "Prescription";
  String? id;
  String fileUrl;
  String num;

  Myprescription({
    this.id,
    required this.fileUrl,
    required this.num,
  });

  Myprescription.fromjson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          num: json["num"],
          fileUrl: json["fileUrl"],
        );

  Myprescription.notFound() : this(num: "", fileUrl: "", id: "");

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "fileUrl": fileUrl,
      "num": num,
    };
  }
}
