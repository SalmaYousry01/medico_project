import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/clinic_database.dart';
import 'package:grad_project/Home_layout/prescription/prescription_form/prescription_form_navigator.dart';
import 'package:grad_project/Profile/clinicProfile.dart';
import 'package:grad_project/Profile/clinicProfile_navigator.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/models/my_clinic.dart';
import 'package:grad_project/models/my_prescription_form.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;

import '../../../DatabaseUtils/prescription_form_database.dart';


class PrescriptionFormViewModel extends BaseViewModel<PrescriptionFormNavigator> {
  // var auth = FirebaseAuth.instance;

  Future<void> AddOrUpdatePrescriptionFormToDB(String medicine, String dosage, String time,
      String test, String prescription)  async{
    // final credential = await auth.getRedirectResult();
    try {
      var col = await DatabaseUtilsPrescriptionForm.getPrescriptionFormCollection().get();
      if(col.docs.isEmpty){
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>isEMpty");
        var docId = DatabaseUtilsPrescriptionForm.getPrescriptionFormCollection().doc();
        Myprescriptionform prescriptionform = Myprescriptionform(
          id: docId.id,

          medicine: medicine,
          dosage: dosage,
          time: time,
          test: test,
          prescription: prescription

        );
        await DatabaseUtilsPrescriptionForm.AddPrescriptionFormToFirestore(prescriptionform);
      }else{
        log(">>>>>>>>>>>>>>>>>>>>>>>isNotEMpty");
        Myprescriptionform? prescriptionform = col.docs[0].data();
        await DatabaseUtilsPrescriptionForm.UpdatePrescriptionFormToFirestore(prescriptionform);
      }
    } on Exception catch (e, stacktrace) {
      debugPrint(e.toString() + ">>>>>>>>>>>>>>>>>>>StackTrace: $stacktrace" );
    }

  }
  void UpdatePrescriptionFormToDB(String medicine, String dosage, String time,
      String test, String prescription)  {
    // final credential = await auth.getRedirectResult();
    Myprescriptionform prescriptionform = Myprescriptionform(
      medicine: medicine,
      dosage: dosage,
      time: time,
      test: test,
      prescription: prescription
      // id: credential.user?.uid ?? ""
    );
    DatabaseUtilsPrescriptionForm.UpdatePrescriptionFormToFirestore(prescriptionform).then((value) {
      print("Clinic updated");
    }).catchError((error) {});
  }
}
