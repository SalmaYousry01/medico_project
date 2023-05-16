import 'package:flutter/material.dart';

class MyAllergy {
  static const String COLLECTION_NAME = "allergy";
  String? id;
  String nasal;
  String chest;
  String substance;
  String skin;
  String food;

  MyAllergy(
      {this.id,
      required this.chest,
      required this.nasal,
      required this.substance,
      required this.skin,
      required this.food});

  MyAllergy.fromjson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            chest: json["chest"],
            nasal: json["nasal"],
            substance: json["substance"],
            skin: json["skin"],
            food: json["food"]);

  MyAllergy.notFound()
      : this(id: "", chest: "", nasal: "", substance: "", skin: "", food: "");

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "chest": chest,
      "nasal": nasal,
      "substance": substance,
      "skin": skin,
      "food": food,
    };
  }
}

final List<String> chest = [];
final List<String> nasal = [];
final List<String> skin = [];
final List<String> food = [];
final List<String> substance = [];

TextEditingController chestController = new TextEditingController();
TextEditingController nasalController = new TextEditingController();
TextEditingController skinController = new TextEditingController();
TextEditingController foodController = new TextEditingController();
TextEditingController substanceController = new TextEditingController();

FocusNode textSecondFocusNode = new FocusNode();

String deletedname = "";
String deleteddosage = "";
String deletedphoto = "";
