import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordVFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _obscureText = true;
  var iconVisibleOff = new Icon(Icons.visibility_off, color: Colors.black);
  var iconVisible = new Icon(Icons.visibility, color: Colors.black);
  String name, email, pass, vpass;

  String _validatePassword(String value) {
    // _formWasEdited = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Please enter a password.';
    return null;
  }

  String _validateEmail(String value) {
    // _formWasEdited = true;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'The E-mail Address must be a valid email address.';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Widget _loginBody() {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 15.0),
                TextFormField(
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
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Harap isi username anda";
                    return null;
                  },
                ),
                TextFormField(
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
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    name = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Harap isi nama anda";
                    return null;
                  },
                ),
                DateTimePickerFormField(
                  textAlign: TextAlign.left,
                  inputType: InputType.date,
                  format: DateFormat("dd MMMM yyyy"),
                  editable: false,
                  resetIcon: null,
                  firstDate: DateTime.utc(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day - 1),
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
                      setState(() {});
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
                    name = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Harap isi nomor telefon anda";
                    return null;
                  },
                ),
                TextFormField(
                  maxLines: 2,
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
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    email = value;
                  },
                ),
                TextFormField(
                  key: _passwordFieldKey,
                  style: new TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    icon: const Icon(
                      Icons.lock,
                    ),
                    border: const UnderlineInputBorder(),
                    labelText: 'Password *',
                    labelStyle: TextStyle(color: Colors.black45),
                    helperStyle: TextStyle(color: Colors.black45),
                    suffixIcon: new GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: _obscureText ? iconVisible : iconVisibleOff,
                    ),
                  ),
                  onSaved: (String value) {
                    pass = value;
                  },
                  maxLength: 16,
                  obscureText: _obscureText,
                  validator: _validatePassword,
                ),
                TextFormField(
                  key: _passwordVFieldKey,
                  style: new TextStyle(color: Colors.black),
                  decoration: new InputDecoration(
                    icon: const Icon(
                      Icons.lock,
                    ),
                    border: const UnderlineInputBorder(),
                    labelText: 'Ulangi Password',
                    labelStyle: TextStyle(color: Colors.black45),
                    helperStyle: TextStyle(color: Colors.black45),
                  ),
                  onSaved: (String value) {
                    vpass = value;
                  },
                  maxLength: 16,
                  obscureText: true,
                  validator: (String val) {
                    final FormFieldState<String> passwordField =
                        _passwordFieldKey.currentState;
                    if (passwordField.value != val)
                      return 'Password tidak cocok';
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () {
                    if (this._formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text("registering account"),
                      ));

                      //DO REGISTER AND LOGIN

                      Timer(
                          Duration(seconds: 2),
                          () => Navigator.pushReplacementNamed(
                              context, '/indexnew'));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Daftar"),
                    height: 50.0,
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Buat Akun"),
        elevation: 0.0,
      ),
      body: _loginBody(),
    );
  }
}
