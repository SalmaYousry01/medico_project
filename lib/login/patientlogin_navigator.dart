import 'package:grad_project/models/my_patient.dart';

import '../basenavigator.dart';

abstract class PatientLoginNavigator extends BaseNavigator {
  
  void goToHome(MyPatient patient);
}