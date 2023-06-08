import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/medicine_database.dart';
import 'package:grad_project/models/my_medicine.dart';
import 'medicine_screen.dart';

class MedicineItem extends StatelessWidget {
  Mymedicine medicine;
  int _selectedItem = -1;

  MedicineItem(
    this.medicine,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF2C698D))),
      child: Container(
        child: Row(
          children: [
            InkWell(
              onTap: () {
                deletemedicinetofirestore(medicine);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineScreen(),
                    ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
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
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(medicine.dosage,
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: Color(0xFF2C698D),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ],
        ),
      ),
    );
  }
}
