import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ujikom_efrizal/model/AirportData.dart';
import 'package:ujikom_efrizal/model/PassengerData.dart';
import 'package:ujikom_efrizal/model/PaymentData.dart';
import 'package:ujikom_efrizal/pages/PaymentConfirmation.dart';
import 'package:ujikom_efrizal/utils/Navigator.dart';
import 'package:ujikom_efrizal/utils/PaymentUtils.dart';

class FlightCheckout extends StatefulWidget {
  FlightCheckout(
      {@required this.dData,
      @required this.aData,
      @required this.flightDate,
      @required this.person});

  final AirportData dData;
  final AirportData aData;
  final DateTime flightDate;
  final int person;

  @override
  _FlightCheckoutState createState() => _FlightCheckoutState();
}

class _FlightCheckoutState extends State<FlightCheckout> {
  final _formKey = GlobalKey<FormState>();
  PageController pageCtrl = new PageController();
  PaymentData selectedPay = new PaymentData();
  List<PassengerData> pData = new List();
  List<PaymentData> payData = new List();
  int pIndex = 0;

  bool isPassengerValid = true;
  bool isPaymentSelected = false;

  @override
  void initState() {
    for (var i = 0; i < widget.person; i++) {
      setState(() {
        pData.add(PassengerData(name: "", nik: ""));
      });
    }

    PaymentUtils().loadPayment().then((onValue) {
      setState(() {
        payData = onValue;
      });
    });

    super.initState();
  }

  Future<bool> _onWillPop() {
    if (pIndex == 0) {
      return Future.value(true);
    } else {
      pageCtrl.animateToPage(
        pIndex - 1,
        curve: Curves.ease,
        duration: Duration(milliseconds: 500),
      );
      return Future.value(false);
    }
  }

  bool checkPassengerValid() {
    pData.forEach((f) {
      if (f.nik == "" || f.name == "") {
        setState(() {
          isPassengerValid = false;
        });
      } else {
        setState(() {
          isPassengerValid = true;
          pageCtrl.animateToPage(1,
              curve: Curves.ease, duration: Duration(milliseconds: 500));
        });
      }
    });
    return isPassengerValid;
  }

  void goToSearch(PaymentData x) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PayConfirm(
              data: x,
            ),
      ),
    ).then((val) {
      if (val != null) {
        setState(() {
          selectedPay = val;
          isPaymentSelected = true;
          print(selectedPay.bankName);
        });
      }
    });
  }

  void openBottomSheet(int i) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Masukkan Data Diri Penumpang",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  Divider(),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "NIK", //TODO: LOCALIZE
                          style: TextStyle(color: Colors.grey),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: pData[i].nik,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.right,
                            onSaved: (input) {
                              setState(() {
                                pData[i].nik = input;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Nama Lengkap", //TODO: LOCALIZE
                          style: TextStyle(color: Colors.grey),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: pData[i].name,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.right,
                            onSaved: (input) {
                              setState(() {
                                pData[i].name = input;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {
                      _formKey.currentState.save();

                      pData.forEach((f) {
                        print("${f.nik} - ${f.name}");

                        if (f.nik == "" || f.name == "") {
                          setState(() {
                            isPassengerValid = false;
                          });
                        } else {
                          setState(() {
                            isPassengerValid = true;
                          });
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(
                        "SIMPAN DATA",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget _cardComplete(BuildContext context) {
      return Card(
        margin: EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CachedNetworkImage(
                  imageUrl: selectedPay.bankLogo,
                  fit: BoxFit.fitWidth,
                  height: 60.0,
                  width: 60.0,
                ),
                onTap: () {},
                onLongPress: () {},
                enabled: false,
                trailing: Text(
                  "Bank ${selectedPay.bankName.toUpperCase()}",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).accentColor),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text(selectedPay.norek,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold)),
                ),
                onLongPress: () {
                  // _toClipboard(context);
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.check_circle, size: 18.0),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Text(
                          "Periksa kembali data pembayaran Anda sebelum melanjutkan transaksi."),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.check_circle, size: 18.0),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Text(
                          "Bayar jumlah uang yang sesuai dengan yang tertulis diatas ke alamat virtual account yang telah terlampir."),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _confirmBody(BuildContext context) => Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                size: 100.0,
                color: Theme.of(context).primaryColor,
              ),
              Text("Order Complete",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              _cardComplete(context),
              Expanded(
                child: Container(),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName("/index"));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    "KEMBALI",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        );

    _confirmationInfo() {
      return Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 30.0,
              height: 20.0,
              child: Container(
                width: 1.0,
                color: Colors.grey[400],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "3",
                      style: TextStyle(color: Colors.grey),
                    ),
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0, color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Konfirmasi",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 30.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 20.0),
                        alignment: Alignment.topCenter,
                        child: (isPaymentSelected)
                            ? _confirmBody(context)
                            : Container(
                                alignment: Alignment.center,
                                child: Text("Select Payment First"),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _cardPayment(BuildContext pcontext) {
      return Card(
        // margin: EdgeInsets.all(10.0),
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Grand Total",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                            NumberFormat.currency(name: "Rp ", decimalDigits: 0)
                                .format(1000000),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                Divider(),
                ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: selectedPay.bankLogo,
                    fit: BoxFit.fitWidth,
                    height: 60.0,
                    width: 60.0,
                  ),
                  title: Text(
                    "${selectedPay.bankName}",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(selectedPay.norek,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text("a.n ${selectedPay.ownername}")
                    ],
                  ),
                  // trailing: Icon(Icons.navigate_next),
                  onTap: () {},
                  onLongPress: () {},
                  enabled: false,
                  trailing: IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: selectedPay.norek));
                      // Scaffold.of(pcontext).showSnackBar(SnackBar(
                      //   content: Text("Teks Telah Disalin"),
                      // ));
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.check_circle, size: 18.0),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                            "Please check again your payment data before doing this transaction."),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.check_circle, size: 18.0),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                            "You will get a ${selectedPay.bankName} payment code that will be used for many transaction in various payment channels ${selectedPay.bankName}."),
                      )
                    ],
                  ),
                )
              ],
            )),
      );
    }

    _paymentList() {
      if (isPaymentSelected) {
        return Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text("Metode Pembayaran telah dipilih, harap lakukan pembayaran"),
            SizedBox(height: 20.0),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: selectedPay.bankLogo,
                          width: 50.0,
                          height: 50.0,
                          errorWidget: CircularProgressIndicator(),
                          placeholder: CircularProgressIndicator(),
                        ),
                        title: Text("${selectedPay.bankName}"),
                        trailing: InkWell(
                          child: Text(
                            "Change",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            setState(() {
                              isPaymentSelected = false;
                            });
                          },
                        )),
                  );
                },
              ),
            ),
            Divider(),
            _cardPayment(context),
            Expanded(
              child: Container(),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () {
                pageCtrl.animateToPage(2,
                    curve: Curves.ease, duration: Duration(milliseconds: 500));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  "KONFIRMASI",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
                "Silahkan Pilih metode pembayaran, setelah memilih metode pembayaran silahkan lakukan transaksi dan klik konfirmasi"),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                primary: false,
                itemCount: payData.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        goToSearch(payData[i]);
                      },
                      leading: CachedNetworkImage(
                        imageUrl: payData[i].bankLogo,
                        width: 50.0,
                        height: 50.0,
                        errorWidget: CircularProgressIndicator(),
                        placeholder: CircularProgressIndicator(),
                      ),
                      title: Text("${payData[i].bankName}"),
                      trailing: Icon(
                        Icons.navigate_next,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
            RaisedButton(
              color: Colors.grey,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              onPressed: () => null,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  "KONFIRMASI",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        );
      }
    }

    _paymentInfo() {
      return Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 30.0,
              height: 20.0,
              child: Container(
                width: 1.0,
                color: Colors.grey[400],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "2",
                      style: TextStyle(color: Colors.grey),
                    ),
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0, color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Pembayaran",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 30.0,
                      child: Container(
                        width: 1.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(right: 20.0),
                          alignment: Alignment.center,
                          child: _paymentList()),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    _personInfo() {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0, top: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.grey),
                    ),
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.0, color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Data Penumpang",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 30.0,
                      child: Container(
                        width: 1.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            Card(
                              elevation: 0.0,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(DateFormat('EEE, dd MMMM yyyy')
                                                .format(DateTime.now()))
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
                                              "CGK - SUB",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5.0),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "16:00 - 18:20",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(
                                              "Bisa Reschedule",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.0),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5.0),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_circle,
                                              size: 16.0,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(
                                              "Bisa Refund",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.0),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              "Data Traveler",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: (isPassengerValid)
                                          ? Colors.transparent
                                          : Colors.red,
                                      width: 1.0)),
                              child: ListView.builder(
                                itemCount: pData.length,
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                    dense: true,
                                    onTap: () {
                                      openBottomSheet(i);
                                    },
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    title: (pData[i].name != "")
                                        ? Text("${pData[i].name}")
                                        : Text("Orang ${i + 1}"),
                                    leading: Icon(Icons.person_outline),
                                    trailing: Icon(
                                      Icons.navigate_next,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              padding: EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: () {
                                checkPassengerValid();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Text(
                                  "PEMBAYARAN",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    _checkoutBody() {
      return Container(
        child: PageView(
          controller: pageCtrl,
          onPageChanged: (i) {
            setState(() {
              pIndex = i;
            });
            pData.forEach((f) {
              if (f.nik == "" || f.name == "") {
                setState(() {
                  isPassengerValid = false;
                  pageCtrl.animateToPage(0,
                      curve: Curves.ease,
                      duration: Duration(milliseconds: 500));
                });
              } else {
                setState(() {
                  isPassengerValid = true;
                });
              }
            });
            if (i == 2) {
              if (isPaymentSelected) {
                pageCtrl.animateToPage(2,
                    curve: Curves.ease, duration: Duration(milliseconds: 500));
              } else {
                pageCtrl.animateToPage(1,
                    curve: Curves.ease, duration: Duration(milliseconds: 500));
              }
            }
          },
          scrollDirection: Axis.vertical,
          children: <Widget>[
            _personInfo(),
            _paymentInfo(),
            _confirmationInfo()
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Checkout"),
        ),
        body: _checkoutBody(),
      ),
    );
  }
}
