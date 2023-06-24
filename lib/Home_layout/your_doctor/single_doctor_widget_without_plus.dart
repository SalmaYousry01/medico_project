import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../DatabaseUtils/yourDoctor_database.dart';
import '../../models/my_clinic.dart';
import '../../models/my_doctor.dart';
import 'doctor_controller.dart';

class SingleDoctorWithoutPlus extends StatefulWidget {
  DoctorDataBase doctor;

  SingleDoctorWithoutPlus(this.doctor);

  @override
  State<SingleDoctorWithoutPlus> createState() =>
      _SingleDoctorWithoutPlusState();
}

class _SingleDoctorWithoutPlusState extends State<SingleDoctorWithoutPlus> {
  final controller = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {},
        leading:
            CircleAvatar(backgroundImage: NetworkImage(widget.doctor.image)),
        title: Text(widget.doctor.fullName),
        subtitle: Text(widget.doctor.Field),
        trailing: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Color.fromARGB(0, 63, 36, 36),
          padding: EdgeInsets.zero,
          onPressed: () async {
            DoctorDataBase yourdoctor = DoctorDataBase(
                Field: widget.doctor.Field,
                email: widget.doctor.email,
                fullName: widget.doctor.fullName,
                image: widget.doctor.image,
                id: widget.doctor.id,
                nationalID: widget.doctor.nationalID,
                phoneNumber: widget.doctor.phoneNumber);
            await DatabaseUtilsDoctorPatient.deleteDoctorFirestore(yourdoctor);

            setState(() {});
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
