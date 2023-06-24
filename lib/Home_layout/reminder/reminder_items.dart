import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/reminder/reminder.dart';
import '../../DatabaseUtils/reminder_database.dart';
import '../../models/my_reminder.dart';

class ReminderItem extends StatelessWidget {
  MyReminder Reminder;

  ReminderItem(
    this.Reminder,
  );

  var titleController = TextEditingController();
  var descriptionsController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Reminder.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    Reminder.descriptions,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(Reminder.date),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    Reminder.time,
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
                    deleteRemindertofirestore(Reminder);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => reminder1(),
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
