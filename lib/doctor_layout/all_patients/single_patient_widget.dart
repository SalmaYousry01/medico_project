import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../models/my_patient.dart';
import 'patient_controller.dart';

class SinglePatientWidget extends StatelessWidget {
  final controller = Get.put(PatientController());
  MyPatient patient;

  SinglePatientWidget(this.patient);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(patient.image)),
        title: Text(patient.fullname),
        subtitle: Text(patient.email),
      ),
    );
  }
}
