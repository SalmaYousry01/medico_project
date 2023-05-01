import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grad_project/DatabaseUtils/doctor_database.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/login/doctorlogin_navigator.dart';
import 'package:grad_project/shared/components/firebase_errors.dart';
import '../models/my_doctor.dart';

class doctorloginViewModel extends BaseViewModel<DoctorLoginNavigator> {
  var auth = FirebaseAuth.instance;

  void DoctorloginWithFirebaseAuth(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DoctorDataBase? doctorDataBase = await DatabaseUtilsdoctor.readUserFromFiresore(
          credential.user?.uid ?? "");
      if (doctorDataBase != null) {
        //Go To profilePage
        navigator!.goToProfilePage(doctorDataBase);
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.Wrongemail) {
        print('no match fount please enter the right email.');
      } else if (e.code == FirebaseError.weakPassword) {
        print('password not correct.');
      }
    } catch (e) {
      print(e);
    }
  }
}
