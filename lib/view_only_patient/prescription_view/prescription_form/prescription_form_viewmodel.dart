import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/models/my_prescription_form.dart';
import 'package:grad_project/view_only_patient/prescription_view/prescription_form/prescription_form_navigator.dart';
import '../../../DatabaseUtils/prescription_form_database.dart';

class PrescriptionFormViewModel
    extends BaseViewModel<PrescriptionFormNavigator> {
  Future<void> AddOrUpdatePrescriptionFormToDB(String medicine, String dosage,
      String time, String test, String prescription) async {
    try {
      var col =
          await DatabaseUtilsPrescriptionForm.getPrescriptionFormCollection()
              .get();
      if (col.docs.isEmpty) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>isEMpty");
        var docId =
            DatabaseUtilsPrescriptionForm.getPrescriptionFormCollection().doc();
        Myprescriptionform prescriptionform = Myprescriptionform(
            id: docId.id,
            medicine: medicine,
            dosage: dosage,
            time: time,
            test: test,
            prescription: prescription);
        await DatabaseUtilsPrescriptionForm.AddPrescriptionFormToFirestore(
            prescriptionform);
      } else {
        log(">>>>>>>>>>>>>>>>>>>>>>>isNotEMpty");
        Myprescriptionform? prescriptionform = col.docs[0].data();
        await DatabaseUtilsPrescriptionForm.UpdatePrescriptionFormToFirestore(
            prescriptionform);
      }
    } on Exception catch (e, stacktrace) {
      debugPrint(e.toString() + ">>>>>>>>>>>>>>>>>>>StackTrace: $stacktrace");
    }
  }
}
