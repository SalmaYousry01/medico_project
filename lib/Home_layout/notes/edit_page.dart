import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad_project/Home_layout/notes/note_page.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';

class EditorPage extends StatefulWidget {
  const EditorPage(
      {Key? key,
        required this.title,
        required this.content,
        required this.noteKey})
      : super(key: key);
  final int noteKey;
  final String title;
  final String content;
  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final _notesBox = Hive.box('notes');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();


  @override
  void initState() {
    setState(() {
      _titleController.text = widget.title;
      _contentController.text = widget.content;
    });
    super.initState;
  }

  void deleteNote() {
    if (widget.noteKey != 0) {
      _notesBox.delete(widget.noteKey);
    }
  }

  void writeNote() {
    String title = _titleController.text.trim();
    String content = _contentController.text;
    if (title == '') {
      title = 'New Note';
    }
    if (widget.noteKey != 0) {
      _notesBox.put(widget.noteKey, [title, content]);
    } else {
      _notesBox.put(_notesBox.length + 1, [title, content]);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 1500.0) {
            if ((_contentController.text != '' ||
                _titleController.text != '') &&
                widget.noteKey == 0) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Text(
                      'Are you sure?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        /*shadows: [
                            Shadow(color: Colors.amber, offset: Offset(2, 2),
                            )
                          ]*/
                      ),
                    ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFF2C698D),
                              ),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(1, 1))
                              ],
                            ),
                            onPressed: () {
                              deleteNote();
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      alignment: Alignment.bottomCenter,
                                      curve: Curves.easeInOut,
                                      duration: Duration(milliseconds: 600),
                                      reverseDuration:
                                      Duration(milliseconds: 600),
                                      type:
                                      PageTransitionType.leftToRightJoined,
                                      child: NotesPage(),
                                      childCurrent: this.widget));
                            },
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFF2C698D),
                              ),
                            ),
                            child: Icon(
                              Icons.cancel_outlined,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(1, 1))
                              ],
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            } else {
              Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 600),
                      reverseDuration: Duration(milliseconds: 600),
                      type: PageTransitionType.leftToRightJoined,
                      child: NotesPage(),
                      childCurrent: this.widget));
            }
          }
        },
        child: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                controller: _contentController,
                // ignore: avoid_types_as_parameter_names
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'please enter note contnet';
                  }
                  return null;
                },
                style: GoogleFonts.aBeeZee(fontSize: 20),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    hintText: 'Note contnet'),
                expands: true,
                maxLines: null,
                minLines: null,
                maxLength: 1000,
                keyboardType: TextInputType.multiline,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF2C698D),
              onPressed: () {
                if(!_titleController.text.isEmpty &&
                    !_contentController.text.isEmpty ){

                  writeNote();
                  Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.bottomCenter,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 600),
                          reverseDuration: Duration(milliseconds: 600),
                          type: PageTransitionType.leftToRightJoined,
                          child: NotesPage(),
                          childCurrent: this.widget));
                }
              },
              child: Icon(
                Icons.check,
                shadows: [Shadow(color: Colors.black, offset: Offset(1, 1))],
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                FloatingActionButton(
                  onPressed: () {
                    if (_contentController.text != '' ||
                        _titleController.text != '') {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text(
                              'Are you sure?',
                              style: GoogleFonts.aBeeZee(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                          Color(0xFF2C698D),
                                        )),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(1, 1))
                                      ],
                                    ),
                                    onPressed: () {
                                      deleteNote();
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              alignment: Alignment.bottomCenter,
                                              curve: Curves.easeInOut,
                                              duration:
                                              Duration(milliseconds: 600),
                                              reverseDuration:
                                              Duration(milliseconds: 600),
                                              type: PageTransitionType
                                                  .leftToRightJoined,
                                              child: NotesPage(),
                                              childCurrent: this.widget));
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                        Color(0xFF2C698D),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(1, 1))
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Navigator.push(
                          context,
                          PageTransition(
                              alignment: Alignment.bottomCenter,
                              curve: Curves.easeInOut,
                              duration: Duration(milliseconds: 600),
                              reverseDuration: Duration(milliseconds: 600),
                              type: PageTransitionType.leftToRightJoined,
                              child: NotesPage(),
                              childCurrent: this.widget));
                    }
                  },
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Align(
                    child: Icon(
                      Icons.delete_outline,
                      size: 30,
                      color: Colors.black,
                      /*  shadows: [
                        Shadow(color: Colors.black, offset: Offset(1, 1))
                      ],*/
                    ),
                  ),
                ),
              ],
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: TextFormField(
                controller: _titleController,
                validator: (Text) {
                  if (Text == '') {
                    return 'please enter title';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'title'),
              ),
            )),
      ),
    );
  }
}
