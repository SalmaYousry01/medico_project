
import 'package:flutter/material.dart';


class searchh extends StatefulWidget {
  const searchh({Key? key}) : super(key: key);

  @override
  _searchhState createState() => _searchhState();
}

class _searchhState extends State<searchh> {

  final List<Map<String, dynamic>> _allUsers = [
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
    {"image": 'assets/images/FDr1.png', "name": 'Dr.Amal Elsayed', "use": 'Neurologist'},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {

    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundUsers =results;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Listview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  //key: ValueKey(_foundUsers[index]["id"]),
                  //color: Colors.blue,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Text(
                      _foundUsers[index]["image"].toString(),
                      style: const TextStyle(fontSize: 24, color:Colors.white),
                    ),
                    title: Text(_foundUsers[index]['name'], style:TextStyle(
                        color:Colors.white
                    )),
                    subtitle: Text(_foundUsers[index]['field'], style:TextStyle(
                        color:Colors.white
                    )),
                  ),
                ),
              )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}