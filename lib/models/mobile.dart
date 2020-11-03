class Mobile{
  int _id;
  int _userId;
  String _mobile;
  String _title;

  Mobile(
      this._userId,
      this._mobile,
      this._title);

  Mobile.withId(
      this._id,
      this._userId,
      this._mobile,
      this._title);


  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get mobile => _mobile;

  set mobile(String value) {
    _mobile = value;
  }

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
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
    map['userid'] = _userId;
    map['mobile'] = _mobile;
    map['title'] = _title;
    return map;
  }

  Mobile.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._userId=map['userid'];
    this._mobile = map['mobile'];
    this._title = map['title'];

  }
}