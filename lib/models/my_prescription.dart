class Myprescription {
  static const String PRESCRIPTION = "Prescription";
  String? id;

  // String title;
  // String descriptions;
  // String image;
  String fileUrl;
  String num;

  Myprescription({
    this.id,
    // required this.descriptions,
    // required this.title,
    // required this.image,
    required this.fileUrl,
    required this.num,
  });

  Myprescription.fromjson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          num: json["num"],
          fileUrl: json["fileUrl"],
          // image: json ["image"],
        );

  Myprescription.notFound()
      : this(
            num: "",
            fileUrl: "",
            // image: "",
            id: "");

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "fileUrl": fileUrl,
      "num": num,
      // "attachment":image
    };
  }
}
