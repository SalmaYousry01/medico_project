class MyClinic {
  static const String CLINIC_PROFILE = "Clinic";
  String? id;
  String address;
  String phoneNumber;
  String startTime;
  String endTime;
  String fees;
  String about;
  String image;


  MyClinic(
      {this.id,
        required this.address,
        required this.phoneNumber,
        required this.startTime,
        required this.endTime,
        required this.fees,
        required this.about,
      required this.image});

  MyClinic.fromJson(Map<String, dynamic> json)
      : this(
    id: json["id"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    fees: json["fees"],
    about: json["about"],
    image: json["image"]

  );
  MyClinic.notFound(): this(about: "",fees: "",endTime: "",startTime: "",phoneNumber: "",address: "",id: "",image: "");

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "address": address,
      "phoneNumber": phoneNumber,
      "startTime": startTime,
      "endTime": endTime,
      "fees": fees,
      "about": about,
      "image":image
    };
  }
}