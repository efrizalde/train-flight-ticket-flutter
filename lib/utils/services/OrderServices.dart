import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ujikom_efrizal/model/RoutesData.dart';
import 'package:ujikom_efrizal/model/UserOrderData.dart';
import 'package:ujikom_efrizal/utils/BaseServices.dart';
import 'package:ujikom_efrizal/utils/RestApiUtil.dart';

class OrderServices extends BaseServices {
  Future<dynamic> makeOrder(
      {RoutesData data, DateTime date, String outlet, int userId}) async {
    RestApiUtil networkUtil = new RestApiUtil();
    String formateddate = DateFormat("yyyy-MM-dd HH.mm.s").format(date),
        formatedcekin = DateFormat("yyyy-MM-dd HH.mm.s")
            .format(date.add(Duration(hours: -1)));

    var url = "${baseUrl}api/pemesanan/order";
    print(url);
    var body = {
      "tanggal_pemesanan":
          DateFormat("yyyy-MM-dd HH.mm.s").format(DateTime.now()),
      "tempat_pemesanan": outlet,
      "id_penumpang": userId,
      "id_rute": data.id,
      "tujuan": data.tujuan,
      "tanggal_berangkat": formateddate,
      "jam_cekin": formatedcekin,
      "jam_berangkat": formateddate,
      "total_bayar": data.harga
    };
    print(body.toString());

    Clipboard.setData(ClipboardData(text: body.toString()));
    try {
      var response = await networkUtil.post(url, body: body);

      return response;
    } catch (e) {
      return throw e;
    }
  }

  Future<List<UserOrderData>> getOrerByUser(int userId) async {
    RestApiUtil networkUtil = new RestApiUtil();
    List<UserOrderData> listData = new List();
    var url = "${baseUrl}api/pemesanan/getbyuser";
    print(url);

    try {
      var response = await networkUtil.post(url, body: {
        "id_penumpang": userId,
      });
      print(response);
      List resData = response['data'];

      resData.forEach((f) {
        listData.add(UserOrderData(
          idpesanan: f['id_pesanan'],
          kodepemesanan: f['kode_pemesanan'],
          tanggalpemesanan: f['tanggal_pemesanan'],
          tempatpemesanan: f['tempat_pemesanan'],
          idpenumpang: f['id_penumpang'],
          kodekursi: f['kode_kursi'],
          idrute: f['id_rute'],
          tujuan: f['tujuan'],
          tanggalberangkat: f['tanggal_berangkat'],
          jamcekin: f['jam_cekin'],
          jamberangkat: f['jam_berangkat'],
          totalbayar: f['total_bayar'],
          idpetugas: f['id_petugas'],
          namapenumpang: f['nama_penumpang'],
          keterangan: f['keterangan'],
          kodetp: f['kode_tp'],
          name: (f['name'] == null) ? "" : f['name'],
          kode: f['kode'],
          ruteawal: f['rute_awal'],
          ruteakhir: f['rute_akhir'],
          harga: f['harga'],
          idtransportasi: f['id_transportasi'],
        ));
        // print(f['rute_awal']);
        // print(f['rute_akhir']);
        // print(f['harga']);
      });

      listData.forEach((f) {
        print(f.idpesanan);
        print(f.kodepemesanan);
        print(f.tanggalpemesanan);
        print(f.tempatpemesanan);
        print(f.idpenumpang);
        print(f.kodekursi);
        print(f.idrute);
        print(f.tujuan);
        print(f.tanggalberangkat);
        print(f.jamcekin);
        print(f.jamberangkat);
        print(f.totalbayar);
        print(f.idpetugas);
        print(f.namapenumpang);
        print(f.keterangan);
        print(f.kodetp);
        print(f.name);
        print(f.kode);
        print(f.ruteawal);
        print(f.ruteakhir);
        print(f.harga);
        print(f.idtransportasi);
      });

      return listData;
    } catch (e) {
      return throw e;
    }
  }
}
