import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import 'package:grad_project/models/my_patient.dart';
import '../../basenavigator.dart';
import 'all_navP.dart';

class AllPatientViewModel extends BaseViewModel<AllPatientNavigator> {
  // void DoctorViewPateintHome(
  //     String username, String fullname, String image) async {
  //   var docId = DatabaseUtilspatient.getUsersCollection().doc();
  //   MyPatient patient = MyPatient(
  //       username: username,
  //       fullname: fullname,
  //       id: docId.id,
  //       image: image,
  //       email: '',
  //       phonenumber: '',
  //       qrcode: '');
  //   await DatabaseUtilspatient.readPateintFromFiresore(docId.id);
  //     //Go To Home
  //     navigator!.goToHomePage(patient);
  // }
}
