class Myprescpdf {
  static const String PRESC_PDF = "prescpdf";
  String? id;
  String fileUrl;
  String num;

  Myprescpdf({
    this.id,
    required this.fileUrl,
    required this.num,
  });

  Myprescpdf.fromjson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          num: json["num"],
          fileUrl: json["fileUrl"],
        );

  Myprescpdf.notFound() : this(num: "", fileUrl: "", id: "");

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "fileUrl": fileUrl,
      "num": num,
    };
  }
}
