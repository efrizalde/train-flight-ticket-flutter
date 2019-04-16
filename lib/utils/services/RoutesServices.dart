import 'package:ujikom_efrizal/model/RoutesData.dart';
import 'package:ujikom_efrizal/utils/BaseServices.dart';
import 'package:ujikom_efrizal/utils/RestApiUtil.dart';

class RoutesServices extends BaseServices {
  Future<List<RoutesData>> getdata() async {
    RestApiUtil networkUtil = new RestApiUtil();
    List<RoutesData> rdata = List();
    var url = "${baseUrl}api/rute/get";
    print(url);
    try {
      var response = await networkUtil.get(url);
      List resData = response['data'];

      resData.forEach((f) {
        rdata.add(RoutesData(
          id: f['id_rute'],
          harga: f['harga'],
          idTransportasi: f['id_transportasi'],
          jumlahKursi: f['jumlah_kursi'],
          keterangan: f['keterangan'],
          kode: f['kode'],
          namaTransportasi: f['nama_transportasi'],
          ruteAkhir: f['rute_akhir'],
          ruteAwal: f['rute_awal'],
          tujuan: f['tujuan'],
        ));
      });

      return rdata;
    } catch (e) {
      return throw e;
    }
  }
}
