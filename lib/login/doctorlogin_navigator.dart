import 'package:grad_project/models/my_doctor.dart';

import '../basenavigator.dart';

abstract class DoctorLoginNavigator extends BaseNavigator {
  void goToProfilePage(DoctorDataBase doctor);
}
