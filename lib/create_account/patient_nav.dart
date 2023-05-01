import 'package:grad_project/models/my_patient.dart';

import '../basenavigator.dart';

abstract class PatientAccountNavigator extends BaseNavigator {
  void goToHome(MyPatient patient);
}