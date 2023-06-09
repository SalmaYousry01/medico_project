import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/family_history/familyhistory.dart';

import '../../models/my_family.dart';
import 'package:grad_project/DatabaseUtils/familyhistory_database.dart';

class FamilyhistoryContainer extends StatelessWidget {
  MyFamilyhistory familyhistory;

  FamilyhistoryContainer(
    this.familyhistory,
  );

  var detailsController = TextEditingController();
  var degreeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF2C698D))),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Medical issue :',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C698D)),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  familyhistory.details,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 12,
                ),
                Text('Degree of relatedness:',
                    style: TextStyle(
                        color: Color(0xFF2C698D),
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 4,
                ),
                Text(
                  familyhistory.degree,
                  style: TextStyle(fontSize: 17),
                ),
                const Divider(
                  color: Color(0xFF216B98),
                  height: 17,
                ),
              ],
            ),
            SizedBox(
              height: 150,
              width: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Color(0xFF2C698D),
                  borderRadius: BorderRadius.circular(12)),
            ),
            Spacer(),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
