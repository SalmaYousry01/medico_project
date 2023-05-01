import 'package:flutter/material.dart';

showLoading(BuildContext context,

String message){
  showDialog(context: context, barrierDismissible : false,builder: ((context) => 
  AlertDialog(title: 
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
CircularProgressIndicator(),
SizedBox(height: 5,),
Text(message)
    ],),
  ),)));

  hideLoading(BuildContext context){
    Navigator.pop(context);
  }
}