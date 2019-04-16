import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ujikom_efrizal/model/UserOrderData.dart';
import 'package:ujikom_efrizal/utils/services/OrderServices.dart';
import 'package:ujikom_efrizal/utils/services/PenumpangServices.dart';

class UserOrders extends StatefulWidget {
  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  List<UserOrderData> ordData = new List();
  bool isLoading = true;

  @override
  void initState() {
    PenumpangServices().getUname().then((uname) {
      PenumpangServices().getuser(uname).then((udata) {
        OrderServices().getOrerByUser(udata.id).then((odata) {
          setState(() {
            ordData = odata;
            isLoading = false;
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _orderCard(UserOrderData data) {
      return Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.airplanemode_active,
                        size: 18.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 8.0),
                      Text(DateFormat('EEE, dd MMMM yyyy')
                          .format(DateTime.parse(data.tanggalberangkat))),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: (data.idpetugas == 0)
                                ? Colors.amber[800]
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 3.0),
                        child: Text(
                          (data.idpetugas == 0) ? "Pending" : "Aktif",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        MdiIcons.skype,
                        size: 30.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "${data.ruteawal} - ${data.ruteakhir}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        NumberFormat.currency(name: "Rp ", decimalDigits: 0)
                            .format(data.harga),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: 5.0),
                      SizedBox(width: 15.0),
                      Icon(
                        Icons.person,
                        size: 16.0,
                      ),
                      Text(
                        "1",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0))),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        size: 16.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "Bisa Reschedule",
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        size: 16.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "Bisa Refund",
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    _userOrderBody() {
      return Container(
        child: ListView.builder(
          itemCount: ordData.length,
          itemBuilder: (context, i) {
            return _orderCard(ordData[i]);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Pesanan Saya"),
        elevation: 0.0,
      ),
      body: (isLoading)
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : _userOrderBody(),
    );
  }
}
