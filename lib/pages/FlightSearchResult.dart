import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ujikom_efrizal/model/AirportData.dart';
import 'package:ujikom_efrizal/utils/Navigator.dart';

class FlightResult extends StatefulWidget {
  FlightResult(
      {@required this.dData,
      @required this.aData,
      @required this.flightDate,
      @required this.person});
  final AirportData dData;
  final AirportData aData;
  final DateTime flightDate;
  final int person;
  @override
  _FlightResultState createState() => _FlightResultState();
}

class _FlightResultState extends State<FlightResult> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              color: Theme.of(context).primaryColor,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.dData.city,
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        widget.aData.city,
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.dData.code,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: Container(
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Icon(
                        MdiIcons.airplaneLanding,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: Container(
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        widget.aData.code,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        DateFormat("dd MMMM yyyy").format(widget.flightDate),
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Penumpang: ${widget.person}",
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, i) {
                  return Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.airplanemode_active,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Lion Air",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "07:30",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Icon(
                                MdiIcons.arrowRightCircleOutline,
                                color: Colors.grey[400],
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Text(
                                "09:30",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "${widget.dData.name}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13.0),
                                ),
                              ),
                              SizedBox(width: 15.0),
                              Text(
                                "5h 30m",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  "${widget.aData.name}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13.0),
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.grey[200],
                            height: 1.0,
                            margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Rp 1.000.000",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              RaisedButton(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Pilih",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  MyNavig().goToCheckout(
                                      context,
                                      widget.dData,
                                      widget.aData,
                                      widget.flightDate,
                                      widget.person);
                                },
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
