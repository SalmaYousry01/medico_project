import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:grad_project/models/my_doctor.dart';

class DoctorController extends GetxController {
  var _doctors = {}.obs;

  void addDoctor(DoctorDataBase doctor) {
    if (_doctors.containsKey(doctor) && _doctors[doctor]==1 ) {
      _doctors[doctor] += 1;
    } else {
      _doctors[doctor] = 1;
    }

    Get.snackbar("Doctor Added",
        "you have added doctor ${doctor.fullName} to your doctors",
        snackPosition: SnackPosition.TOP, duration: Duration(seconds: 1));
  }

  void removeDoctor(DoctorDataBase doctor) {
    if (_doctors.containsKey(doctor)) {
      _doctors.removeWhere((key, value) => key == doctor);
    }
    Get.snackbar("Doctor Removed",
        "you have Removed doctor ${doctor.fullName} from your doctors",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }

  get doctors => _doctors;
}
