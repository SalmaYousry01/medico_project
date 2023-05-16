import 'package:grad_project/models/my_patient.dart';
import '../../basenavigator.dart';

abstract class AllPatientNavigator extends BaseNavigator {
  void goToHomePage(MyPatient patient);
}
