import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class Firstpage extends StatefulWidget {
  static const String routeName = 'Firstpage';

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        Image.asset(
          'assets/images/background.png',
          fit: BoxFit.fitWidth,
          width: double.infinity,
        ),
        Form(
            child: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Join as',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() {
                    //Here is the part that I want to change the DrawerListTile's isSelected value

                    Navigator.pushNamed(context, 'patientsignup');
                  }),
                  child: Container(
                    child: Image.asset('assets/images/male-patient 3.png'),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Patient',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => setState(() {
                    //Here is the part that I want to change the DrawerListTile's isSelected value
                    Navigator.pushNamed(context, 'DoctorSignup');
                  }),
                  child: Container(
                    child: Image.asset('assets/images/Group 99.png'),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Doctor',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
