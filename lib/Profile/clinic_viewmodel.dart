import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/clinic_database.dart';
import 'package:grad_project/Profile/clinicProfile_navigator.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/models/my_clinic.dart';

class ClinicViewModel extends BaseViewModel<clinicProfileNavigator> {
  // var auth = FirebaseAuth.instance;

  Future<void> AddOrUpdateClinicToDB(
      String address,
      String phoneNumber,
      String startTime,
      String endTime,
      String fees,
      String about,
      String image) async {
    try {
      var col = await DatabaseUtilsClinic.getClinicsCollection().get();
      if (col.docs.isEmpty) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>isEMpty");
        var docId = DatabaseUtilsClinic.getClinicsCollection().doc();
        MyClinic clinic = MyClinic(
            address: address,
            phoneNumber: phoneNumber,
            startTime: startTime,
            endTime: endTime,
            fees: fees,
            about: about,
            id: docId.id,
            image: image);
        await DatabaseUtilsClinic.AddClinicToFirestore(clinic);
      } else {
        log(">>>>>>>>>>>>>>>>>>>>>>>isNotEMpty");
        MyClinic? clinic = col.docs[0].data();
        await DatabaseUtilsClinic.UpdateClinicToFirestore(clinic);
      }
    } on Exception catch (e, stacktrace) {
      debugPrint(e.toString() + ">>>>>>>>>>>>>>>>>>>StackTrace: $stacktrace");
    }
  }

  void UpdateClinicToDB(String address, String phoneNumber, String startTime,
      String endTime, String fees, String about, String image) {
    MyClinic clinic = MyClinic(
        address: address,
        phoneNumber: phoneNumber,
        startTime: startTime,
        endTime: endTime,
        fees: fees,
        about: about,
        image: image
        );
    DatabaseUtilsClinic.UpdateClinicToFirestore(clinic).then((value) {
      print("Clinic updated");
    }).catchError((error) {});
  }
}
