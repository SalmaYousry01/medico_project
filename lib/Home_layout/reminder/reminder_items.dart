import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/my_reminder.dart';
import 'Edit_reminder.dart';


class ReminderItem extends StatelessWidget {
  MyReminder Reminder;
  int _selectedItem = -1;

  ReminderItem(
      this.Reminder,
      );

  var  titleController =  TextEditingController();
  var descriptionsController =  TextEditingController();
  var dateController = TextEditingController();
  var timeController=  TextEditingController();

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
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: EditReminderBottomsheet()));
          },
          child:
          Container(
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
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
                        Reminder.title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(Reminder.date,
                          style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(
                        height: 15,
                      ),
                      Text(Reminder.time,
                          style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(
                        height: 15,
                      ),
                      Text(Reminder.descriptions,
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
                          Icons.notification_add,
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
        ),
      );
  }
}
