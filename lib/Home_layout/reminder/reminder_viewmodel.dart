import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/reminder_database.dart';
import 'package:grad_project/Home_layout/Reminder/reminder_navigator.dart';
import 'package:grad_project/basenavigator.dart';

import '../../models/my_reminder.dart';

class ReminderViewModel extends BaseViewModel<ReminderNavigator> {
  Future<void> AddOrUpdateReminderToDB(
      String descriptions, String title, String date, String time) async {
    try {
      var col = await DatabaseUtilsReminder.getReminderCollection().get();
      if (col.docs.isEmpty) {
        log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>isEMpty");
        var docId = DatabaseUtilsReminder.getReminderCollection().doc();
        MyReminder reminder = MyReminder(
          id: docId.id,
          title: title,
          descriptions: descriptions,
          date: date,
          time: time,
        );
        await DatabaseUtilsReminder.AddReminderToFirestore(reminder);
      } else {
        log(">>>>>>>>>>>>>>>>>>>>>>>isNotEMpty");
        MyReminder? reminder = col.docs[0].data();
        await DatabaseUtilsReminder.UpdateeRemindertofirestore(reminder);
      }
    } on Exception catch (e, stacktrace) {
      debugPrint(e.toString() + ">>>>>>>>>>>>>>>>>>>StackTrace: $stacktrace");
    }
  }

  void UpdateReminderToDB(
      String id, String descriptions, String title, String date, String time) {
    MyReminder reminder = MyReminder(
      id: id,
      descriptions: descriptions,
      title: title,
      date: date,
      time: time,
    );

    DatabaseUtilsReminder.AddReminderToFirestore(reminder).then((value) {
      print("reminder updated");
    }).catchError((error) {});
  }
}
