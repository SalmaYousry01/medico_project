import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grad_project/Home_layout/your_doctor/doctor_controller.dart';
import 'package:grad_project/Home_layout/your_doctor/doctor_details.dart';
import 'package:grad_project/Home_layout/your_doctor/modell.dart';



class SingleDoctortWidget extends StatefulWidget {
  final int index;
  final doctorController = Get.put(DoctorController());
  final Doctor doctor;

  SingleDoctortWidget(
      {super.key,
      required this.doctor,
      required this.index,
      required DoctorController controller});

  @override
  State<SingleDoctortWidget> createState() => _SingleDoctortWidgetState();
}

class _SingleDoctortWidgetState extends State<SingleDoctortWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.00, right: 15.00),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DoctorDetailsPage(
                      doctor: widget.doctor,
                    )));
          },
          leading: Container(
              width: 50, height: 150, child: Image.asset(widget.doctor.image)),
          title: Text(
            widget.doctor.name,
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
          subtitle: Text(
            " ${(widget.doctor.use.toString())}",
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
          trailing: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.zero,
            onPressed: () {
              // doctorController.addDoctor(Doctor.items);
              widget.doctorController.addDoctor(widget.doctor);
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
        ));
  }
}
