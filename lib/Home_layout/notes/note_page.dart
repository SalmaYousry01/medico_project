import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/home.dart';
import 'package:grad_project/Home_layout/notes/edit_page.dart';
import 'package:grad_project/Home_layout/notes/note_mini.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

class NotesPage extends StatefulWidget {
  static const String routeName = 'NotesPage';

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _notesBox = Hive.box('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF2C698D),
        elevation: 0,
        toolbarHeight: 100.0,
        title: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => home()));
                },
                icon: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    'My Notes',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx < 1500.0) {
            Navigator.push(
                context,
                PageTransition(
                    alignment: Alignment.bottomCenter,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 600),
                    reverseDuration: Duration(milliseconds: 600),
                    type: PageTransitionType.rightToLeftJoined,
                    child: EditorPage(noteKey: 0, content: '', title: ''),
                    childCurrent: this.widget));
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.bottomCenter,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 600),
                          reverseDuration: Duration(milliseconds: 600),
                          type: PageTransitionType.rightToLeftJoined,
                          child: EditorPage(noteKey: 0, content: '', title: ''),
                          childCurrent: this.widget));
                },
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  elevation: 2,
                  shadowColor: Color(0xFF2C698D),
                  child: Container(
                    width: 10,
                    height: 150,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(54, 158, 158, 158),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Icon(Icons.add, color: Color(0xFF2C698D), shadows: [
                      Shadow(color: Colors.black, offset: Offset(1, 1))
                    ]),
                  ),
                ),
              ),
              for (int key in _notesBox.keys)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 600),
                            reverseDuration: Duration(milliseconds: 600),
                            type: PageTransitionType.rightToLeftJoined,
                            child: EditorPage(
                                noteKey: key,
                                content: _notesBox.get(key)[1],
                                title: _notesBox.get(key)[0]),
                            childCurrent: this.widget));
                  },
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    elevation: 2,
                    shadowColor: Color(0xFF2C698D),
                    child: NoteMini(
                        title: _notesBox.get(key)[0],
                        content: _notesBox.get(key)[1]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
