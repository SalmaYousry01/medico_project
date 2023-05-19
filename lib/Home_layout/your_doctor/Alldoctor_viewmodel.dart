import '../../DatabaseUtils/doctor_database.dart';
import '../../basenavigator.dart';
import '../../models/my_clinic.dart';
import '../../models/my_doctor.dart';

class AllDoctorViewModel extends BaseViewModel {
  List<DoctorDataBase> doctor = [];
  MyClinic? clinic;

  void readDoctors() {
    DatabaseUtilsdoctor.readDoctorFromFirestore().then((value) {
      doctor = value;
      notifyListeners();
    });
  }

// void readDoctorClinic(){
//   DatabaseUtilsClinic.readClinicFromFiresore().then((value) {
//     clinic = value;
//     notifyListeners();
//   });
// }
}
