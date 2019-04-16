import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ujikom_efrizal/utils/BaseServices.dart';
import 'package:ujikom_efrizal/utils/RestApiUtil.dart';

import 'package:ujikom_efrizal/model/UsersData.dart';

class PenumpangServices extends BaseServices {
  Future<String> getUname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uname = prefs.getString("saved_uname");
    print(uname);

    return uname;
  }

  Future<bool> check(String uname) async {
    RestApiUtil networkUtil = new RestApiUtil();
    var url = "${baseUrl}api/penumpang/get";
    print(url);
    try {
      var response = await networkUtil.post(url, body: {"username": uname});
      if ((response['data']['islogin'] as int) == 0) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return throw e;
    }
  }

  Future<UsersData> getuser(String uname) async {
    RestApiUtil networkUtil = new RestApiUtil();
    UsersData udata = new UsersData();
    var url = "${baseUrl}api/penumpang/get";
    print(url);
    try {
      var response = await networkUtil.post(url, body: {"username": uname});
      var resData = response['data'];

      udata = UsersData(
        id: resData['id_penumpang'],
        address: resData['alamat_penumpang'],
        dateofbirth: resData['tanggal_lahir'],
        fullname: resData['nama_penumpang'],
        phone: resData['telp'],
        username: resData['username'],
        sex: resData['jenis_kelamin']
      );

      return udata;
    } catch (e) {
      return throw e;
    }
  }

  Future<dynamic> editUser(UsersData data) async {
    RestApiUtil networkUtil = new RestApiUtil();
    var url = "${baseUrl}api/penumpang/edit";
    print(url);
    try {
      var response = await networkUtil.post(url, body: {
        "username": data.username,
        "nama_penumpang": data.fullname,
        "alamat_penumpang": data.address,
        "tanggal_lahir": data.dateofbirth,
        "jenis_kelamin": data.sex,
        "telp": data.phone
      });

      print(response);

      return response;
    } catch (e) {
      return throw e;
    }
  }

  Future<dynamic> login({String uname, String pass}) async {
    RestApiUtil networkUtil = new RestApiUtil();
    var url = "${baseUrl}api/penumpang/login";
    print(url);
    try {
      var response = await networkUtil
          .post(url, body: {"username": uname, "password": pass});
      print(response.toString());

      return response;
    } catch (e) {
      return throw e;
    }
  }

  Future<dynamic> logout(String uname) async {
    RestApiUtil networkUtil = new RestApiUtil();
    var url = "${baseUrl}api/penumpang/logout";
    print(url);
    try {
      var response = await networkUtil.post(url, body: {"username": uname});
      print(response.toString());

      return response;
    } catch (e) {
      return throw e;
    }
  }

  Future<dynamic> register(UsersData udata) async {
    RestApiUtil networkUtil = new RestApiUtil();
    var url = "${baseUrl}api/penumpang/tambah";
    print(url);
    try {
      var body = {
        "username": udata.username,
        "password": udata.pass,
        "nama_penumpang": udata.fullname,
        "alamat_penumpang": udata.address,
        "tanggal_lahir": udata.dateofbirth,
        "jenis_kelamin": udata.sex,
        "telp": udata.phone,
        "islogin": true
      };
      print(body.toString());
      var response = await networkUtil.post(url, body: body);

      return response;
    } catch (e) {
      return throw e;
    }
  }
}
