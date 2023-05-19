import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import 'package:grad_project/Home_layout/your_doctor/single_doctor_clinic_profile.dart';
import '../../DatabaseUtils/yourDoctor_database.dart';
import '../../models/my_clinic.dart';
import '../../models/my_doctor.dart';
import 'package:grad_project/DatabaseUtils/clinic_database.dart';
import 'doctor_controller.dart';

class SingleDoctortWidget extends StatelessWidget {
  final controller = Get.put(DoctorController());
  DoctorDataBase doctor;

  // MyPatient patient;

  SingleDoctortWidget(this.doctor);

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
          onPressed: () async {
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
            await Future.wait([
              DatabaseUtilsDoctorPatient.addPatientDoctorToFirestore(yourdoctor),
              DatabaseUtilspatient.readPateintFromFiresore(FirebaseAuth.instance.currentUser!.uid).then((value) {
                print(">>>>>>>>>>>>>>>>>>> Doctor ID : ${yourdoctor.id}");
                DatabaseUtilsDoctorPatient.addPetientToDoctorFirestore(yourdoctor, value!);
                print("Success!!!");
              }
              ),
            ],);
            // MyPatient mypatient = MyPatient(
            //     id: patient.id,
            //     email: patient.email,
            //     username: patient.username,
            //     fullname: patient.fullname,
            //     phonenumber: patient.phonenumber,
            //     age: patient.age,
            //     image: patient.image,
            //     qrcode: patient.qrcode,
            //     blood_sugar: patient.blood_sugar,
            //     blood_pressure: patient.blood_pressure,
            //     heart: patient.heart,
            //     kidney: patient.kidney,
            //     liver: patient.liver,
            //     blood_type: patient.blood_type);
            // DatabaseUtilsPateintAddedToDatabase.AddAddedPatientToFirestore(mypatient);
            // controller.addDoctor();
            // widget.doctorController.addDoctor(widget.doctor);
            // Get.to(() => YourDoctors());
          },
          icon: CircleAvatar(
            backgroundColor: Color(0xFF2C698D),
            radius: 10.0,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 20.0,
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
