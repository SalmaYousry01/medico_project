import 'package:grad_project/models/base_data.dart';

class MyPatient extends BaseData {
  static const String COLLECTION_NAME = "Patients";
  String id;
  String fullname;
  String username;
  String email;
  String phonenumber;
  String age;
  String image;
  String blood_sugar;
  String blood_pressure;
  String heart;
  String kidney;
  String liver;
  String blood_type;
  String surgery;

  MyPatient({
    required this.id,
    required this.email,
    required this.username,
    required this.fullname,
    required this.phonenumber,
    required this.age,
    required this.image,
    required this.blood_sugar,
    required this.blood_pressure,
    required this.heart,
    required this.kidney,
    required this.liver,
    required this.blood_type,
    required this.surgery
  });

  MyPatient.fromjson(Map<String, dynamic> json)
      : this(
    id: json["id"],
    fullname: json["fullname"],
    username: json["username"],
    phonenumber: json["phonenumber"],
    age: json["age"],
    email: json["email"],
    image: json["image"],
    blood_sugar: json["blood_sugar"],
    blood_pressure: json["blood_pressure"],
    heart: json["heart"],
    kidney: json["kidney"],
    liver: json["liver"],
    blood_type: json["blood_type"],
    surgery: json["surgery"],
  );

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "fullname": fullname,
      "username": username,
      "phonenumber": phonenumber,
      "age": age,
      "email": email,
      "image": image,
      "blood_sugar": blood_sugar,
      "blood_pressure": blood_pressure,
      "heart": heart,
      "kidney": kidney,
      "liver": liver,
      "blood_type": blood_type,
      "surgery":surgery
    };
  }
}
