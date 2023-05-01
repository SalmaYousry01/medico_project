import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import 'package:grad_project/shared/components/firebase_errors.dart';
import 'package:grad_project/create_account/patient_nav.dart';
import 'package:grad_project/models/my_patient.dart';
import '../basenavigator.dart';

class patientsignupViewModel extends BaseViewModel<PatientAccountNavigator> {
  var auth = FirebaseAuth.instance;

  void signupViewModel(String email, String password, String fullname,
      String username, String phonenumber, String image, String qrcode) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyPatient patient = MyPatient(
          id: credential.user?.uid ?? "",
          fullname: fullname,
          username: username,
          phonenumber: phonenumber,
          email: email,
          image: image,
          qrcode: qrcode);
      DatabaseUtilspatient.AddUserToFirestore(patient).then((value) {
        navigator!.goToHome(patient);
        return;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.weakPassword) {
        print('The password provided is too weak.');
      } else if (e.code == FirebaseError.emailInUse) {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
