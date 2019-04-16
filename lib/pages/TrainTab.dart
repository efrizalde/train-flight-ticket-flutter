import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ujikom_efrizal/model/RoutesData.dart';
import 'package:ujikom_efrizal/pages/RouteSearch.dart';
import 'package:ujikom_efrizal/utils/Navigator.dart';

class TrainTab extends StatefulWidget {
  TrainTab({@required this.rdata});
  final List<RoutesData> rdata;
  @override
  _TrainTabState createState() => _TrainTabState();
}

class _TrainTabState extends State<TrainTab> {
  final _formKey = GlobalKey<FormState>();
  bool valid = true;
  DateTime flightDate = DateTime.now();
  RoutesData selectedRdata = new RoutesData();
  String tempatPemesanan;
  List<RoutesData> rdata = new List();

  @override
  initState() {
    if (mounted) {
      setState(() {
        widget.rdata.forEach((f) {
          if (f.namaTransportasi == "Kereta") {
            rdata.add(f);
          }
        });
        if (rdata.isNotEmpty) {
          selectedRdata = rdata[0];
        }
      });
    }
    super.initState();
  }

  void submit() {
    _formKey.currentState.save();

    if (tempatPemesanan == null || tempatPemesanan == "") {
      setState(() {
        valid = false;
      });
    } else {
      setState(() {
        valid = true;
        MyNavig()
            .goToCheckout(context, selectedRdata, tempatPemesanan, flightDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _loading({double size = 30.0}) {
      return Container(
        height: size,
        width: size,
        color: Colors.transparent,
        child: CircularProgressIndicator(),
      );
    }

    _airplaneForm() {
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15.0),
                        Icon(
                          MdiIcons.routes,
                          size: 16.0,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Rute Travel",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RouteSearch(
                                  rdata: rdata,
                                ),
                          ),
                        ).then((val) {
                          if (val != null) {
                            setState(() {
                              selectedRdata = val;
                            });
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "${selectedRdata.ruteAwal} - ${selectedRdata.ruteAkhir}"),
                            Text(
                              "Rp ${selectedRdata.harga}",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11.0),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15.0),
                        Icon(
                          MdiIcons.calendar,
                          size: 16.0,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Tanggal",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    DateTimePickerFormField(
                      textAlign: TextAlign.left,
                      inputType: InputType.both,
                      format: DateFormat("EEEE, dd MMMM yyyy, 'Jam' HH:mm"),
                      initialValue: DateTime.now(),
                      editable: false,
                      resetIcon: null,
                      firstDate: DateTime.utc(DateTime.now().year,
                          DateTime.now().month, DateTime.now().day - 1),
                      initialDate: DateTime.now(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        border: InputBorder.none,
                      ),
                      onChanged: (dt) {
                        setState(() {
                          flightDate = dt;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Card(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15.0),
                        Icon(
                          MdiIcons.city,
                          size: 16.0,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Tempat Pemesanan",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Tempat Pemesanan Anda",
                          hintStyle: TextStyle(color: Colors.black38),
                        ),
                        onSaved: (val) {
                          tempatPemesanan = val;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              (!valid)
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.warning,
                            size: 13.0,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5.0),
                          Expanded(
                            child: Text(
                              "Harap isi data dengan benar!",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ))
                  : Container(),
              SizedBox(height: 10.0),
              Container(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    child: Container(
                      width: 80.0,
                      height: 50.0,
                      alignment: Alignment.center,
                      child: Text(
                        "Beli Tiket",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: this.submit,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ))
            ],
          ),
        ),
      );
    }

    _airplaneBody() => Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(25.0))),
              ),
              _airplaneForm()
            ],
          ),
        );

    return (rdata.isEmpty)
        ? Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  MdiIcons.train,
                  color: Colors.grey[300],
                  size: 100.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Tidak Ada Travel Kereta Api",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 34.0),
                )
              ],
            ),
          )
        : _airplaneBody();
  }
}
