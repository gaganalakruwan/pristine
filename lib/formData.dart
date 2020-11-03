import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pristine_flutter_assignment/models/mobile.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'models/note.dart';
import 'utils/database_helper.dart';
import 'form.dart';
import 'package:sqflite/sqflite.dart';

class FormData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FormDataState();
  }
}

class FormDataState extends State<FormData> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  Mobile mobile;
  List<Mobile> mobileList;
  int count = 0;
  int numcount = 0;
  final titleController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(
              Note('', '', '', '', '', '', '', '', '', ''), 'Add Note');
        },
        tooltip: 'Add Data',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
//            leading: CircleAvatar(
//              backgroundColor: getPriorityColor(this.noteList[position].priority),
//              child: getPriorityIcon(this.noteList[position].priority),
//            ),

            title: Text(
              this.noteList[position].fname +
                  " " +
                  this.noteList[position].lname,
              style: titleStyle,
            ),

            subtitle: Text(this.noteList[position].address),

            trailing: Wrap(
              spacing: 12,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _delete(context, noteList[position]);
                  },
                ),
                GestureDetector(
                  child: Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _openPopup(context, this.noteList[position]);
                  },
                ),
                GestureDetector(
                  child: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _openPopupDetails(context, this.noteList[position]);
                  },
                ),
              ],
            ),
            leading: GestureDetector(
              child: Icon(
                Icons.contact_phone,
                color: Colors.grey,
              ),
              onTap: () {
                updateMobileNumberView(noteList[position].id);
                _opencustomercontactNo(context, noteList[position]);
              },
            ),

            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.noteList[position], 'Edit Note');
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FormScreen(note);
    }));

    if (result == true) {
      updateListView();
    }
  }

  _openPopup(context, Note note) {
    mobileController.text = "";
    titleController.text = "";
    Alert(
        context: context,
        title: "Add Contact Number",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Title',
              ),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.phone),
                labelText: 'Mobile Number',
              ),
              maxLength: 10,
              keyboardType: TextInputType.phone,
              controller: mobileController,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              _addMobileNumber(note.id);
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void _addMobileNumber(int userId) async {
    Mobile newmobile =
        new Mobile(userId, mobileController.text, titleController.text);

    int result;
    result = await databaseHelper.insertmobile(newmobile);

    if (result != 0) {
      // Success
//      _showSnackBar(context, 'Number Saved Successfully');
    } else {
      // Failure
//      _showSnackBar(context, 'Problem Saving Number');
    }
    mobileController.text = "";
    titleController.text = "";
    updateMobileNumberView(userId);
  }

  _openPopupDetails(context, Note note) {
    Alert(
      context: context,
      title: "Details",
      content: Column(children: <Widget>[
        _buildName(title: 'Name :', value: note.fname + " " + note.lname),
        _buildName(title: 'Email :', value: note.email),
        _buildName(title: 'Address :', value: note.address),
        _buildName(title: 'City :', value: note.city),
        _buildName(title: 'State :', value: note.state),
        _buildName(title: 'Zip code :', value: note.zipCode),
        _buildName(title: 'Phone No :', value: note.phoneNumber),
        _buildName(title: 'Mobile No :', value: note.mobileNumber),
        _buildName(title: 'Birthday :', value: note.birthday),
      ]),
    ).show();
  }

  Widget _buildName({String title, String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),
          Container(height: 2, color: Colors.redAccent),
          SizedBox(height: 12),
          Row(
            children: <Widget>[Text(title), Spacer(), Text(value)],
          ),
        ],
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  void updateMobileNumberView(int userId) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Mobile>> mobileListFuture =
          databaseHelper.getMobileList(userId);
      mobileListFuture.then((mobList) {
        setState(() {
          this.mobileList = mobList;
          this.numcount = mobileList.length;
        });
      });
    });

    print("row count:" + this.numcount.toString());
//    print("row count:"+this.mobileList[0].title);
//    print("row mobile:"+this.mobileList[0].mobile);
  }

  _opencustomercontactNo(context, Note note) {
    updateMobileNumberView(note.id);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 16,
          child: Container(
            height: 400.0,
            width: 360.0,
            child: ListView.builder(
                itemCount: numcount,
                itemBuilder: (BuildContext context, int position) {
                  return _buildName(
                      title: this.mobileList[position].title,
                      value: this.mobileList[position].mobile);
                }),
          ),
        );
      },
    );
  }


//  void _showAlertDialog(String title, String message) {
//    AlertDialog alertDialog = AlertDialog(
//      title: Text(title),
//      content: Text(message),
//    );
//    showDialog(context: context, builder: (_) => alertDialog);
//  }
}
