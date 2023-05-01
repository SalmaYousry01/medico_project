import 'package:grad_project/models/my_doctor.dart';
import '../basenavigator.dart';

abstract class DoctorAccountNavigator extends BaseNavigator {
  void goToProfilePage(DoctorDataBase doctor);
}