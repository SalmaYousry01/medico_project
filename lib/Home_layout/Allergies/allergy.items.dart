import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/models/my_allergies.dart';
import 'package:grad_project/DatabaseUtils/allergy_database.dart';
import 'allergy.dart';

class AllergyItem extends StatelessWidget {
  MyAllergy allergy;

  AllergyItem(
    this.allergy,
  );

  var chestController = TextEditingController();
  var nasalController = TextEditingController();
  var substanceController = TextEditingController();
  var skinController = TextEditingController();
  var foodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  'Chest allergy:',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C698D)),
                ),
                Text(
                  allergy.chest,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 0,
                ),
                Text('Nasal allergy:',
                    style: TextStyle(
                        color: Color(0xFF2C698D),
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
                Text(
                  allergy.nasal,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Active substance allergy:',
                    style: TextStyle(
                        color: Color(0xFF2C698D),
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
                Text(
                  allergy.substance,
                  style: TextStyle(fontSize: 15.5),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Skin allergy:',
                    style: TextStyle(
                        color: Color(0xFF2C698D),
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
                Text(
                  allergy.skin,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Type of food you're allergic to:",
                    style: TextStyle(
                        color: Color(0xFF2C698D),
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
                Text(
                  allergy.food,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Color(0xFF216B98),
                  height: 17,
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
            SizedBox(
              height: 150,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF2C698D),
                  borderRadius: BorderRadius.circular(12)),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    deleteallergytofirestore(allergy);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => allergy1(),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.delete,
                      size: 25,
                      color: Color(0xFF2C698D),
                    ),
                  ),
                ),
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
