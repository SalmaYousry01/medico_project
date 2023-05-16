import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grad_project/Home_layout/your_doctor/single_doctor_clinic_profile.dart';
import '../../DatabaseUtils/yourDoctor_database.dart';
import '../../models/my_clinic.dart';
import '../../models/my_doctor.dart';
import 'package:grad_project/DatabaseUtils/clinic_database.dart';
import 'doctor_controller.dart';

class SingleDoctorWithoutPlus extends StatelessWidget {
  final controller = Get.put(DoctorController());
  DoctorDataBase doctor;

  SingleDoctorWithoutPlus(this.doctor);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {
          DatabaseUtilsClinic.getDoctorClinicsCollectionFromId(doctor.id).then(
                  (clinic) => Navigator.pushNamed(
                  context, SingleDoctorClinicProfile.routeName,
                  arguments:
                  DoctorClinicModel(doctor: doctor, clinic: clinic!)));
        },
        leading: CircleAvatar(backgroundImage: NetworkImage(doctor.image)),
        title: Text(doctor.fullName),
        subtitle: Text(doctor.Field),
        trailing: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Color.fromARGB(0, 63, 36, 36),
          padding: EdgeInsets.zero,
          onPressed: () {
            // controller.addOrRemoveDoctor(doctor);
            // controller.addDoctor(doctor);
            DoctorDataBase yourdoctor = DoctorDataBase(
                Field: doctor.Field,
                email: doctor.email,
                fullName: doctor.fullName,
                image: doctor.image,
                id: doctor.id,
                nationalID: doctor.nationalID,
                phoneNumber: doctor.phoneNumber);
            DatabaseUtilsDoctorPatient.deletedoctorfirestore(yourdoctor);
            // controller.addDoctor();
            // widget.doctorController.addDoctor(widget.doctor);
            // Get.to(() => YourDoctors());
          },
          icon: CircleAvatar(
            backgroundColor: Color(0xFF2C698D),
            radius: 10.0,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}

class DoctorClinicModel {
  final DoctorDataBase doctor;
  final MyClinic clinic;

  DoctorClinicModel({required this.doctor, required this.clinic});
}
