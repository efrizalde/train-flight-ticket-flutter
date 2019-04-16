import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ujikom_efrizal/model/UsersData.dart';
import 'package:ujikom_efrizal/utils/services/PenumpangServices.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isEditing = false;
  bool isSaving = false;
  bool isLoading = true;
  var iconVisibleOff = new Icon(Icons.visibility_off, color: Colors.black);
  var iconVisible = new Icon(Icons.visibility, color: Colors.black);
  int _radioValue = 0;

  UsersData _usersData = new UsersData();

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _usersData.sex = "l";
          break;
        case 1:
          _usersData.sex = "p";
          break;
      }
    });
  }

  void _doLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Log Out"),
            content: Text(
                "Apa anda serius ingin keluar dari akun ${_usersData.fullname}"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Tidak"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Iya"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.popUntil(context, ModalRoute.withName("/indexnew"));
                  Navigator.pushReplacementNamed(context, "/login");
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString("saved_uname", "");
                  PenumpangServices().logout(_usersData.username);
                },
              ),
            ],
          ),
    );
  }

  void getData() {
    setState(() {
      isLoading = true;
    });
    PenumpangServices().getUname().then((un) {
      PenumpangServices().getuser(un).then((onValue) {
        setState(() {
          _usersData = onValue;
          isLoading = false;
          if (onValue.sex.toString().toLowerCase() == "l") {
            _radioValue = 0;
          } else {
            _radioValue = 1;
          }
        });
      });
    });
  }

  @override
  void initState() {
    if (mounted) {
      getData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _profileBody() {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),
                TextFormField(
                  initialValue: _usersData.username,
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    icon: const Icon(
                      Icons.person,
                    ),
                    hintText: 'Masukkan Username',
                    hintStyle: TextStyle(color: Colors.black45),
                    labelText: 'Username *',
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                  maxLength: 10,
                  enabled: false,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Harap isi username anda";
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _usersData.fullname,
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    icon: const Icon(
                      Icons.person,
                    ),
                    hintText: 'Masukkan Nama anda',
                    hintStyle: TextStyle(color: Colors.black45),
                    labelText: 'Nama *',
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                  maxLength: 30,
                  enabled: isEditing,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    _usersData.fullname = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Harap isi nama anda";
                    return null;
                  },
                ),
                DateTimePickerFormField(
                  initialValue: DateTime.parse(_usersData.dateofbirth),
                  textAlign: TextAlign.left,
                  inputType: InputType.date,
                  format: DateFormat("dd MMMM yyyy"),
                  editable: false,
                  enabled: isEditing,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    icon: const Icon(
                      MdiIcons.calendar,
                    ),
                    hintText: 'Masukkan Tanggal Lahir anda',
                    hintStyle: TextStyle(color: Colors.black45),
                    labelText: 'Tanggal Lahir *',
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                  onChanged: (dt) {
                    if (dt != null) {
                      setState(() {
                        _usersData.fullname =
                            DateFormat("yyyy-MM-dd").format(dt).toString();
                      });
                    } else {
                      print("canceled");
                    }
                  },
                  validator: (value) {
                    if (value.toString() == null ||
                        value.toString().isEmpty ||
                        value.toString() == "null")
                      return "Harap isi tanggal lahir anda";
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _usersData.phone,
                  enabled: isEditing,
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    icon: const Icon(
                      Icons.phone,
                    ),
                    hintText: 'Masukkan Nomor Telefon anda',
                    hintStyle: TextStyle(color: Colors.black45),
                    labelText: 'Telefon *',
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                  maxLength: 13,
                  keyboardType: TextInputType.phone,
                  onSaved: (String value) {
                    _usersData.phone = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Harap isi nomor telefon anda";
                    return null;
                  },
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(width: 3.0),
                        Icon(
                          Icons.people,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          "Jenis Kelamin",
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 25.0),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: 0,
                              groupValue: _radioValue,
                              onChanged:
                                  (isEditing) ? _handleRadioValueChange : null,
                            ),
                            Text("Laki-laki")
                          ],
                        ),
                        SizedBox(width: 20.0),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: _radioValue,
                              onChanged:
                                  (isEditing) ? _handleRadioValueChange : null,
                            ),
                            Text("Perempuan")
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  initialValue: _usersData.address,
                  enabled: isEditing,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    icon: const Icon(MdiIcons.home),
                    hintText: 'Masukkan Alamat Anda',
                    hintStyle: TextStyle(color: Colors.black45),
                    labelText: 'Alamat *',
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Harap isi alamat anda";
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  onSaved: (String value) {
                    _usersData.address = value;
                  },
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ));
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          (isSaving)
              ? Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 20.0),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                  height: 20.0,
                  width: 25.0,
                )
              : FlatButton(
                  child: Text(
                    (isEditing) ? "SIMPAN" : "EDIT",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      if (isEditing) {
                        if (this._formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          setState(() {
                            isSaving = true;
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Menyimpan Data..."),
                            ));
                          });

                          //DO SAVE HERE
                          PenumpangServices().editUser(_usersData).then((x) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Data Tersimpan"),
                            ));
                            setState(() {
                              isSaving = false;
                            });
                          }).catchError((e) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Data Tidak Tersimpan"),
                            ));
                            setState(() {
                              isSaving = false;
                            });
                            print(e.toString());
                          });
                          isEditing = false;
                        }
                      } else {
                        isEditing = true;
                      }
                    });
                  },
                )
        ],
        title: Text("Profil Saya"),
      ),
      body: (!isLoading)
          ? SingleChildScrollView(
              child: _profileBody(),
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15.0),
        child: RaisedButton(
          color: Colors.red[800],
          padding: EdgeInsets.all(15.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () {
            _doLogout();
          },
          child: Container(
            height: 20.0,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text(
              "LOG OUT",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
