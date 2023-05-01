import 'dart:convert';

import 'package:grad_project/models/base_data.dart';

class DoctorDataBase extends BaseData {
  static const String COLLECTION_NAME = "Doctors";
  String id;
  String fullName;
  String phoneNumber;
  String email;
  String nationalID;
  String Field;
  String image;

  DoctorDataBase(
      {required this.email,
      required this.fullName,
      required this.id,
      required this.phoneNumber,
      required this.nationalID,
      required this.Field,
      required this.image});

  DoctorDataBase.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            fullName: json["fullName"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            nationalID: json["ID Number"],
            Field: json["Field"],
            image: json["image"]);

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "ID Number": nationalID,
      "Field": Field,
      "image": image
    };
  }
}
