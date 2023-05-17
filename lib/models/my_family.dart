import 'package:flutter/material.dart';

class MyFamilyhistory {
  static const String COLLECTION_NAME = "familyhistory";
  String? id;
  String details;
  String degree;

  MyFamilyhistory({
    this.id,
    required this.details,
    required this.degree,
  });
  MyFamilyhistory.fromjson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          details: json["details"],
          degree: json["degree"],
        );
  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "details": details,
      "degree": degree,
    };
  }
}

List<String> details = [];
List<String> degree = [];

TextEditingController degreeController = new TextEditingController();
TextEditingController detailsController = new TextEditingController();

FocusNode textSecondFocusNode = new FocusNode();

String deleteddegree = "";
String deleteddetails = "";
