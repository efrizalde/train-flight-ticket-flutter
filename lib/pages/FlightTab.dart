import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ujikom_efrizal/model/AirportData.dart';
import 'package:ujikom_efrizal/pages/components/AirportSearch.dart';
import 'package:ujikom_efrizal/utils/AirportUtils.dart';
import 'package:ujikom_efrizal/utils/Navigator.dart';
import 'package:numberpicker/numberpicker.dart';

class FlightTab extends StatefulWidget {
  @override
  _FlightTabState createState() => _FlightTabState();
}

class _FlightTabState extends State<FlightTab>
    with AutomaticKeepAliveClientMixin {
  List<AirportData> airportData = new List();
  int selectedTab = 0;
  int personTotal = 1;
  final _formKey = GlobalKey<FormState>();
  var txtDestination = new TextEditingController();
  var txtEndTime = new TextEditingController();
  bool isLoading = true;
  bool isSubmitting = false;
  bool valid = true;
  AirportData planeDepart = new AirportData(), planeArrival = new AirportData();
  DateTime initStart = DateTime.now();
  DateTime initEnd = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  DateTime flightDate = DateTime.now(), trainDate, reminderDateTime;

  @override
  initState() {
    if (mounted) {
      AirportUtils().loadAirport().then((airport) {
        setState(() {
          airportData = airport;
          planeDepart = airport[0];
          planeArrival = airport[0];
          isLoading = false;
        });
      });
    }
    super.initState();
  }

  void submit() {
    if (planeDepart.code != planeArrival.code && personTotal != 0) {
      setState(() {
        valid = true;
      });
      MyNavig().goToFlightResult(
          context, planeDepart, planeArrival, flightDate, personTotal);
    } else {
      setState(() {
        valid = false;
      });
    }
  }

  AirportData getAirpotData(String fcode) {
    AirportData data = new AirportData();
    airportData.forEach((f) {
      if (f.code == fcode) {
        data = f;
      }
    });
    return data;
  }

  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 7,
          initialIntegerValue: personTotal,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => personTotal = value);
      }
    });
  }

  void goToSearch(int x) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AirportSearch(
              airportData: airportData,
            ),
      ),
    ).then((val) {
      if (val != null) {
        setState(() {
          if (x == 0) {
            planeDepart = val;
          } else if (x == 1) {
            planeArrival = val;
          }
        });
      }
    });
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
                        MdiIcons.airplaneTakeoff,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "Dari",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      goToSearch(0);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${planeDepart.code} - ${planeDepart.city}"),
                          Text(
                            "${planeDepart.name}",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 11.0),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
              SizedBox(height: 10.0),
              Card(
                  child: Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 15.0),
                      Icon(
                        MdiIcons.airplaneLanding,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "Ke",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      goToSearch(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${planeArrival.code} - ${planeArrival.city}"),
                          Text(
                            "${planeArrival.name}",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 11.0),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
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
                          inputType: InputType.date,
                          format: DateFormat("EEEE, dd MMMM yyyy"),
                          initialValue: DateTime.now(),
                          editable: false,
                          resetIcon: null,
                          firstDate: DateTime.utc(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day - 1),
                          initialDate: initStart,
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
                    )),
                  ),
                ],
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
                child: (!isSubmitting)
                    ? RaisedButton(
                        child: Container(
                          width: 80.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text(
                            "Cari Tiket",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: this.submit,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      )
                    : RaisedButton(
                        child: Container(
                          width: 80.0,
                          alignment: Alignment.center,
                          child: _loading(size: 15.0),
                        ),
                        onPressed: null,
                        color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
              )
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

    return (isLoading)
        ? Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        : _airplaneBody();
  }

  @override
  bool get wantKeepAlive => true;
}
