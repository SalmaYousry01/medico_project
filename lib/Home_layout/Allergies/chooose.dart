import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/Allergies/allergytry.dart';
import 'package:grad_project/Home_layout/Allergies/history.dart';
import 'package:grad_project/Home_layout/family_history/family_history.dart';
import 'package:grad_project/Home_layout/home.dart';

class chooose extends StatelessWidget {
  static const String routeName = 'chooose';

  const chooose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => home(),
        //         ),
        //       );
        //     },
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Colors.black,
        //     )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 260,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => allergy1(),
                      ),
                    );
                  },
                  child: Text(
                    "Allergies",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFF2C698D),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 260,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FamilyHistory(),
                      ),
                    );
                  },
                  child: Text(
                    "Family History",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Color(0xFF2C698D),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
