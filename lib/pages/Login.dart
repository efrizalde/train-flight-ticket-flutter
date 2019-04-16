import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ujikom_efrizal/utils/Navigator.dart';
import 'package:ujikom_efrizal/utils/services/PenumpangServices.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _obscureText = true;
  var iconVisibleOff = new Icon(Icons.visibility_off, color: Colors.black);
  var iconVisible = new Icon(Icons.visibility, color: Colors.black);
  String uname, pass;

  MyNavig nav = MyNavig();

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

  _setPrefs(String newuname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("saved_uname", newuname);
    print(prefs.getString("saved_uname"));

    return uname;
  }

  _goToRegister() {
    Navigator.of(context).pushNamed('/register');
  }

  _loadingDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Harap Tunggu", textAlign: TextAlign.center),
          content: Container(
            height: 100.0,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
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
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 30.0),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/app-logo.png'),
                  height: 150.0,
                  padding: EdgeInsets.all(10.0),
                  width: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  "Selamat Datang di Aplikasi Ticketing\nKereta dan Pesawat",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text("Masuk untuk melanjutkan"),
                SizedBox(height: 30.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: const UnderlineInputBorder(),
                    icon: const Icon(
                      Icons.person,
                    ),
                    hintText: 'Masukkan Username anda',
                    hintStyle: TextStyle(color: Colors.black45),
                    labelText: 'Username *',
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Harap isi username anda";
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  onSaved: (String value) {
                    uname = value;
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
                  maxLength: 20,
                  obscureText: _obscureText,
                  validator: _validatePassword,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () {
                    if (this._formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      _loadingDialog(context);

                      //DO LOGIN HERE
                      PenumpangServices()
                          .login(uname: uname, pass: pass)
                          .then((value) {
                        _setPrefs(uname);
                        Navigator.of(context).pop(true);
                        Navigator.pushReplacementNamed(context, '/indexnew');
                      }).catchError((onError) {
                        print(onError.toString());
                        Navigator.of(context).pop(true);
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                              "Login Gagal! Harap periksa username dan password anda."),
                        ));
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Masuk"),
                    height: 50.0,
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                SizedBox(height: 15.0),
                Wrap(
                  children: <Widget>[
                    Text("Belum punya akun? daftar dengan"),
                    GestureDetector(
                      child: Text(
                        " klik disini!",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        _goToRegister();
                      },
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10.0),
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Atau Login Menggunakan",
                      style: TextStyle(color: Colors.grey, fontSize: 11.0),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                "Mohon maaf, saat ini register menggunakan akun Google belum tersedia"),
                          ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Icon(MdiIcons.google),
                              SizedBox(width: 10.0),
                              Text("Google")
                            ],
                          ),
                          height: 50.0,
                        ),
                        color: Colors.red[900],
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          // _goToRegisterPhone();
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                "Mohon maaf, saat ini register menggunakan nomor telepon belum tersedia"),
                          ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Icon(Icons.call),
                              SizedBox(width: 10.0),
                              Text("No. Telepon")
                            ],
                          ),
                          height: 50.0,
                        ),
                        color: Colors.grey[700],
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: _loginBody(),
      ),
    );
  }
}
