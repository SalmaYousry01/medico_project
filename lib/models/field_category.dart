import 'package:flutter/foundation.dart';

class FieldCategory {
  static String DermatologistsId = "Dermatologist";
  static String UrologistsId = "Urologist";
  static String RadiologistsId = "Radiologist";
  static String MedicalGeneticistsId = "Medical Geneticist";
  static String ImmunologistsId = "Immunologist";
  static String DentistId = "dentist";
  static String SurgeonId = "Surgeon";

  String id;
  late String name;

  FieldCategory(this.id, this.name);

  FieldCategory.fromId(this.id) {
    name = id;
  }

  static List<FieldCategory> getCategories() {
    return [
      FieldCategory.fromId(DermatologistsId),
      FieldCategory.fromId(UrologistsId),
      FieldCategory.fromId(RadiologistsId),
      FieldCategory.fromId(MedicalGeneticistsId),
      FieldCategory.fromId(ImmunologistsId),
      FieldCategory.fromId(DentistId),
      FieldCategory.fromId(SurgeonId),
    ];
  }
}
