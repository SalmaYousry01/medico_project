import 'package:flutter/material.dart';

enum options { Yes, No }

class family extends StatefulWidget {
  const family({Key? key}) : super(key: key);

  @override
  State<family> createState() => _familyState();
  static const String routeName = 'family';
}

class _familyState extends State<family> {
  options? _options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family History'),
        centerTitle: true,
        backgroundColor: Color(0xFF2C698D),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(top: 30, left: 15, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Does any of the family members have medical issues?',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                        dense: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        title: Text(
                          options.Yes.name,
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        ),
                        tileColor: Color(0xFF2C698D),
                        value: options.Yes,
                        groupValue: _options,
                        onChanged: (val) {
                          setState(() {
                            _options = val;
                          });
                        }),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: RadioListTile(
                        dense: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        title: Text(
                          options.No.name,
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        ),
                        tileColor: Color(0xFF2C698D),
                        value: options.No,
                        groupValue: _options,
                        onChanged: (val) {
                          setState(() {
                            _options = val;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Specify in details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  helperText: 'Ex: Allergy, Mental illness...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Type..',
                  hintStyle: TextStyle(fontSize: 16),
                  suffixIcon: Icon(Icons.medical_information),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Degree of relatedness:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              TextFormField(
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: Icon(Icons.face),
                  hintText: 'Type..',
                  helperText: 'Ex: Father, Mother...',
                  hintStyle: TextStyle(fontSize: 16),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 70),
              Center(
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF2C698D)),
                  child: MaterialButton(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      onPressed: () {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
