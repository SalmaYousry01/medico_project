import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/allergy_database.dart';
import 'package:grad_project/Home_layout/allergies/allergy_navigator.dart';
import 'package:grad_project/basenavigator.dart';

import '../../models/my_allergies.dart';




class AllergyViewModel extends BaseViewModel<AllergyNavigator> {
  // var auth = FirebaseAuth.instance;

  Future<void> AddOrUpdateAllergyToDB(String chest
      , String nasal,String substance,String food , String skin) async {
    // final credential = await auth.getRedirectResult();
    try {
      var col = await DatabaseUtilsAllergy.getAllergyCollection().get();
      if (col.docs.isEmpty) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>isEMpty");
        var docId = DatabaseUtilsAllergy.getAllergyCollection().doc();
        MyAllergy allergy = MyAllergy(
          id: docId.id,
          chest: chest,
          nasal: nasal,
          substance: substance,
          food: food,
          skin: skin,

        );
        await DatabaseUtilsAllergy.AddAllergyToFirestore(allergy);
      } else {
        log(">>>>>>>>>>>>>>>>>>>>>>>isNotEMpty");
        MyAllergy? allergy = col.docs[0].data();
        await DatabaseUtilsAllergy.UpdateeAllergytofirestore(allergy);
      }
    } on Exception catch (e, stacktrace) {
      debugPrint(e.toString() + ">>>>>>>>>>>>>>>>>>>StackTrace: $stacktrace");
    }
  }

  void UpdateAllergyToDB(String id, String name,String dosage,String chest , String nasal ,String substance
      ,String food , String skin) {
    // final credential = await auth.getRedirectResult();
    MyAllergy allergy = MyAllergy(
      id: id,
      chest: chest,
      nasal: nasal,
      substance: substance,
      food: food,
      skin: skin,


    );
    // id: credential.user?.uid ?? ""

    DatabaseUtilsAllergy.AddAllergyToFirestore(allergy).then((value) {
      print("Clinic updated");
    }).catchError((error) {});
  }
}
