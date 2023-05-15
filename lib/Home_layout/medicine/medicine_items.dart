import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/medicine_database.dart';
import 'package:grad_project/DatabaseUtils/notes_database.dart';
import 'package:grad_project/Home_layout/reminder/reminder.dart';
import 'package:grad_project/models/my_medicine.dart';
import 'package:grad_project/models/my_notes.dart';


class MedicineItem extends StatelessWidget {
  Mymedicine medicine;
  int _selectedItem = -1;

  MedicineItem(
      this.medicine,
      );



  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF2C698D))),
        child: Container(
          child: Row(
            children: [

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
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // showLoading(context, 'Deleting');
                      deletemedicinetofirestore(medicine);
                      // hideLoading(BuildContext context) {
                      //   Navigator.pop(context);
                      // }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => reminder1(),
                        ),  );
                      },
                          icon: Icon(Icons.notification_add,color: Color(0xFF2C698D) ,)),
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
