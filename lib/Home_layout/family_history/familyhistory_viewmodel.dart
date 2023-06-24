import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../DatabaseUtils/familyhistory_database.dart';
import '../../basenavigator.dart';
import '../../models/my_family.dart';
import 'familyhistory_navigator.dart';

class FamilyhistoryViewModel extends BaseViewModel<FamilyhistoryNavigator> {
  // var auth = FirebaseAuth.instance;

  Future<void> AddOrUpdateFamilyhistoryToDB(
    String details,
    String degree,
  ) async {
    try {
      var col =
          await DatabaseUtilsFamilyhistory.getFamilyhistoryCollection().get();
      if (col.docs.isEmpty) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>isEMpty");
        var docId =
            DatabaseUtilsFamilyhistory.getFamilyhistoryCollection().doc();
        MyFamilyhistory familyhistory = MyFamilyhistory(
          id: docId.id,
          details: details,
          degree: degree,
        );
        await DatabaseUtilsFamilyhistory.AddFamilyhistoryToFirestore(
            familyhistory);
      } else {
        log(">>>>>>>>>>>>>>>>>>>>>>>isNotEMpty");
        MyFamilyhistory? familyhistory = col.docs[0].data();
        await DatabaseUtilsFamilyhistory.UpdateeFamilyhistorytofirestore(
            familyhistory);
      }
    } on Exception catch (e, stacktrace) {
      debugPrint(e.toString() + ">>>>>>>>>>>>>>>>>>>StackTrace: $stacktrace");
    }
  }

  void UpdateFamilyhistoryToDB(
    String id,
    String details,
    String degree,
  ) {
    MyFamilyhistory familyhistory = MyFamilyhistory(
      id: id,
      details: details,
      degree: degree,
    );

    DatabaseUtilsFamilyhistory.AddFamilyhistoryToFirestore(familyhistory)
        .then((value) {
      print("Clinic updated");
    }).catchError((error) {});
  }
}
