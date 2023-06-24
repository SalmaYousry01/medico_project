import 'package:flutter/material.dart';

class MyReminder {
  static const String COLLECTION_NAME = "Reminder";
  String ?id;
  String title;
  String descriptions;
  String date;
  String time;
  MyReminder({this.id , required this.descriptions, required this.title,
    required this.date,required this.time
  });
  MyReminder.fromjson(Map<String ,dynamic> json):
        this(
        id: json ["id"],
        title: json ["title"],
        descriptions: json ["descriptions"],
        date: json ["date"],
        time: json ["time"],
      );



  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "title": title,
      "descriptions": descriptions,
      "date" : date,
      "time" : time,


    };
  }
}

final List<String> descriptions = [];
final List<String> title = [];
final List<String> date =[];
final List<String> time =[];

TextEditingController titleController = new TextEditingController();
TextEditingController descriptionsController = new TextEditingController();
TextEditingController dateController = new TextEditingController();
TextEditingController timeController= new TextEditingController();

FocusNode textSecondFocusNode = new FocusNode();

String deletedtitle = "";
String deleteddescriptions = "";
String deletedate ="";
String deletetime ="";