import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/models/my_measurments.dart';
import '../../DatabaseUtils/measurments_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'measurments_navigator.dart';

class MeasurmentsViewModel extends BaseViewModel<MeasurmentsNavigator> {
  // var auth = FirebaseAuth.instance;

  Future<void> AddOrUpdateMeasurmentsToDB(
    String height,
    String weight,
    String blood_pressure,
    String blood_sugar,
  ) async {
    // final credential = await auth.getRedirectResult();
    try {
      var col = await DatabaseUtilsMeasurments.getMeasurmentsCollection().get();
      if (col.docs.isEmpty) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>isEMpty");
        var docId = DatabaseUtilsMeasurments.getMeasurmentsCollection().doc();
        Mymeasurments measurments = Mymeasurments(
            id: docId.id,
            height: height,
            weight: weight,
            blood_pressure: blood_pressure,
            blood_sugar: blood_sugar);
        await DatabaseUtilsMeasurments.AddMeasurmentsToFirestore(measurments);
      } else {
        log(">>>>>>>>>>>>>>>>>>>>>>>isNotEMpty");
        Mymeasurments? measurments = col.docs[0].data();
        await DatabaseUtilsMeasurments.UpdateMeasurmentsToFirestore(
            measurments);
      }
    } on Exception catch (e, stacktrace) {
      debugPrint(e.toString() + ">>>>>>>>>>>>>>>>>>>StackTrace: $stacktrace");
    }
  }

  void UpdateMeasurmentsToDB(
    String height,
    String weight,
    String blood_pressure,
    String blood_sugar,
  ) {
    // final credential = await auth.getRedirectResult();
    Mymeasurments measurments = Mymeasurments(
        height: height,
        weight: weight,
        blood_pressure: blood_pressure,
        blood_sugar: blood_sugar
        // id: credential.user?.uid ?? ""
        );
    DatabaseUtilsMeasurments.UpdateMeasurmentsToFirestore(measurments)
        .then((value) {
      print("Measurements updated");
    }).catchError((error) {});
  }
}
