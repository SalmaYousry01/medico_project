class MyTest {
  static const String TEST = "Test";
  String? id;

  String fileUrl;
  String num;

  MyTest({
    this.id,
    required this.fileUrl,
    required this.num,
  });

  MyTest.fromjson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          num: json["num"],
          fileUrl: json["fileUrl"],
        );

  MyTest.notFound() : this(num: "", fileUrl: "", id: "");

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "fileUrl": fileUrl,
      "num": num,
    };
  }
}
