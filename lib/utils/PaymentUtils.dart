import 'package:ujikom_efrizal/model/PaymentData.dart';

class PaymentUtils {
  Future<List<PaymentData>> loadPayment() async {
    List<PaymentData> listdata = new List();
    List<String> bankname = ["Mandiri", "BCA", "BRI"];
    List<String> norek = ["0000011234", "51323451", "1123889210"];
    List<String> bankcode = ["012", "013", "014"];
    List<String> logo = [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhJMBGCKoXUtRxpm7W3wfRHj06eAT6w6dD7b3i7ChjRoMN9x5c",
      "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/0018/7273/brand.gif?itok=ZKEaV7uB",
      "https://media.rumahdibekasi.com/files/2017/10/logobri-min.png"
    ];

    for (var i = 0; i < 3; i++) {
      listdata.add(PaymentData(
        bankCode: bankcode[i],
        bankName: bankname[i],
        norek: norek[i],
        bankLogo: logo[i],
        ownername: "Travelijal",
      ));
    }

    return listdata;
  }
}
