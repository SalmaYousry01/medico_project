import 'package:flutter/material.dart';

class picker extends StatefulWidget {
  const picker({Key? key}) : super(key: key);
    static const String routeName = 'picker';

  @override
  State<picker> createState() => _pickerState();
}

class _pickerState extends State<picker> {
  DateTimeRange? _selectDateTime;
  void _show() async{
    final DateTimeRange? result = await showDateRangePicker(context: context, firstDate: DateTime(2022,1,), lastDate: DateTime(2100,12,31),
        currentDate: DateTime.now(),
        saveText: 'Done');
    if (result !=null){
      print(result.start.toString());
      setState(() {
        _selectDateTime = result;

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Timer'),
        backgroundColor: Color(0xFF2C698D),
      ),
      body: _selectDateTime==null ? const Center(
        child: Text('Press the button to show the picker'),
      )
          : Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Start date:${_selectDateTime?.start.toString().split(' ')[0]}',
            style: TextStyle(fontSize: 24,color: Color(0xFF2C698D)),
            ),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2C698D),
        onPressed: _show,
        child: const Icon(Icons.date_range),
      ),
    );
  }
}