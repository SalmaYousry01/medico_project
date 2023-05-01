import 'package:flutter/material.dart';

class Mymedicine {
  static const String COLLECTION_NAME = "Medicine";
  String ?id;
  String name;
  String dosage;


  Mymedicine({this.id , required this.dosage, required this.name,});
  Mymedicine.fromjson(Map<String ,dynamic> json):
        this(
        id: json ["id"],
        name: json ["name"],
        dosage: json ["dosage"],

      );
  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "name": name,
      "dosage": dosage,
      "photo" : photo,


    };
  }
}

final List<String> dosage = [];
final List<String> name= [];
final List<String> photo =[];


TextEditingController nameController = new TextEditingController();
TextEditingController dosageController = new TextEditingController();
TextEditingController photoController = new TextEditingController();


FocusNode textSecondFocusNode = new FocusNode();

String deletedname= "";
String deleteddosage = "";
String deletedphoto ="";

