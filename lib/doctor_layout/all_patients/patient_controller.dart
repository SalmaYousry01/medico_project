import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/my_patient.dart';

class PatientController extends GetxController {
  var _patients = {}.obs;

  void addPatient(MyPatient patient) {
    if (_patients.containsKey(patient)) {
      _patients[patient] += 1;
    } else {
      _patients[patient] = 1;
    }

    Get.snackbar("Patient Added",
        "you have added Patient ${patient.fullname} to your Patients",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }

  void removePatients(MyPatient patient) {
    if (_patients.containsKey(patient)) {
      _patients.removeWhere((key, value) => key == patient);
    }
    Get.snackbar("Patient Removed",
        "you have Removed patient ${patient.fullname} from your Patients",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }

  get patients => _patients;
}
