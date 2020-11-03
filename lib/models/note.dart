class Note {
  int _id;
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

  Note(
      this._fname,
      this._lname,
      this._email,
      this._address,
      this._city,
      this._state,
      this._zipCode,
      this._phoneNumber,
      this._mobileNumber,
      this._birthday);

  Note.withId(
      this._id,
      this._fname,
      this._lname,
      this._email,
      this._address,
      this._city,
      this._state,
      this._zipCode,
      this._phoneNumber,
      this._mobileNumber,
      this._birthday);

  String get birthday => _birthday;

  set birthday(String value) {
    _birthday = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  String get zipCode => _zipCode;

  set zipCode(String value) {
    _zipCode = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get lname => _lname;

  set lname(String value) {
    _lname = value;
  }

  String get fname => _fname;

  set fname(String value) {
    _fname = value;
  }


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['email'] = _email;
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zipCode;
    map['phone'] = _phoneNumber;
    map['mobile'] = _mobileNumber;
    map['bdate'] = _birthday;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._fname=map['fname'];
    this._lname = map['lname'];
    this._email = map['email'];
    this._address = map['address'];
    this._city = map['city'];
    this._state = map['state'];
    this._zipCode = map['zip'];
    this._phoneNumber = map['phone'];
    this._mobileNumber = map['mobile'];
    this._birthday = map['bdate'];
  }
}
