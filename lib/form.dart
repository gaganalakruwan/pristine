import 'package:flutter/material.dart';
import 'package:pristine_flutter_assignment/utils/database_helper.dart';
import 'models/note.dart';

class FormScreen extends StatefulWidget {
  final Note note;

  FormScreen(this.note);

  @override
  State<StatefulWidget> createState() {
    return FormScreenState(this.note);
  }
}

class FormScreenState extends State<FormScreen> {
  String _fname;
  String _lname;
  String _email;
  String _address;
  String _city;
  String _state;
  String _zipCode;
  String _phoneNumber;
  String _mobileNumber;
  String _birthday;
  DateTime pickedDate;

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final phoneController = TextEditingController();
  final mobileController = TextEditingController();
  final birthdayController = TextEditingController();

  DatabaseHelper helper = DatabaseHelper();
  Note note;

  FormScreenState(this.note);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildfname() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'First Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'First name if Required';
        }
        return null;
      },
      onSaved: (String value) {
        note.fname = value;
        _fname = value;
      },
      controller: fnameController,
    );
  }

  Widget _buildlname() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Last Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Last name if Required';
        }
        return null;
      },
      onSaved: (String value) {
        note.lname = value;
        _lname = value;
      },
      controller: lnameController,
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String value) {
        note.email = value;
        _email = value;
      },
      controller: emailController,
    );
  }

  Widget _buildAddress() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is Required';
        }

        return null;
      },
      onSaved: (String value) {
        note.address = value;
        _address = value;
      },
      controller: addressController,
    );
  }

  Widget _buildCity() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'City'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'City is Required';
        }

        return null;
      },
      onSaved: (String value) {
        note.city = value;
        _city = value;
      },
      controller: cityController,
    );
  }

  Widget _buildState() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'State'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'State is Required';
        }

        return null;
      },
      onSaved: (String value) {
        note.state = value;
        _state = value;
      },
      controller: stateController,
    );
  }

  Widget _buildzip() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Zip Code'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Zip Code is Required';
        }

        return null;
      },
      onSaved: (String value) {
        note.zipCode = value;
        _zipCode = value;
      },
      controller: zipController,
    );
  }

  Widget _buildphone() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone Number'),
      maxLength: 10,
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        note.phoneNumber = value;
        _phoneNumber = value;
      },
      controller: phoneController,
    );
  }

  Widget _buildmobile() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Mobile Number'),
      maxLength: 10,
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mobile Number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        note.mobileNumber = value;
        _mobileNumber = value;
      },
      controller: mobileController,
    );
  }

  Widget _buildbirthday() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Birthday'),
      readOnly: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Birthday is Required';
        }

        return null;
      },
      onTap: _showDatePicker,
      onSaved: (String value) {
        note.birthday = value;
        _birthday = value;
      },
//      initialValue: this.pickedDate.year.toString(),
      controller: birthdayController,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    fnameController.text = note.fname;
    lnameController.text = note.lname;
    emailController.text = note.email;
    addressController.text = note.address;
    cityController.text = note.city;
    stateController.text = note.state;
    zipController.text = note.zipCode;
    phoneController.text = note.phoneNumber;
    mobileController.text = note.mobileNumber;
    birthdayController.text = note.birthday;
    pickedDate = DateTime.now();
    String buttontext="";
    if (note.id != null) {
      buttontext="Update";

    }else{
      buttontext="Submit";
      birthdayController.text=pickedDate.year.toString()+":"+pickedDate.month.toString()+":"+pickedDate.day.toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Form Demo"),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
//           mainAxisAlignment: MainAxisAlignment.center,
            child: Column(
              children: <Widget>[
                _buildfname(),
                _buildlname(),
                _buildEmail(),
                _buildAddress(),
                _buildCity(),
                _buildState(),
                _buildzip(),
                _buildphone(),
                _buildmobile(),
                _buildbirthday(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    buttontext,
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    _save();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _save() async {
    moveToLastScreen();

    //note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  _showDatePicker() async {
    DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: pickedDate

    );
    pickedDate = date;
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
    birthdayController.text=pickedDate.year.toString()+":"+pickedDate.month.toString()+":"+pickedDate.day.toString();

  }
}
