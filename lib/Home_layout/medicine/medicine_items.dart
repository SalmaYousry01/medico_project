import 'package:flutter/material.dart';
import 'package:grad_project/models/my_medicine.dart';

import 'edit_medicine.dart';

class MedicineItem extends StatelessWidget {
  Mymedicine medicine;
  int _selectedItem = -1;

  MedicineItem(
      this.medicine,
      );

  var nameController = TextEditingController();

  var dosageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF2C698D))),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: EditMedicineBottomsheet()));
          },
          child: Container(
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 7,
                  color: Color(0xFF2C698D),
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
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        //    showLoading(context, 'Deleting');

                        // deletenotetofirestore(medicine as Mynotes);
                        // hideLoading(BuildContext context) {
                        //   Navigator.pop(context);
                        // }
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
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
