import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ujikom_efrizal/model/RoutesData.dart';

class RouteSearch extends StatefulWidget {
  RouteSearch({@required this.rdata});
  final List<RoutesData> rdata;
  @override
  _RouteSearchState createState() => _RouteSearchState();
}

class _RouteSearchState extends State<RouteSearch> {
  List<RoutesData> routeData = new List();
  int selectedTab = 0;

  @override
  void initState() {
    if (mounted) {
      setState(() {
        routeData = widget.rdata;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _airplaneBody() => Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 120.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(25.0))),
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: routeData.length,
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
                              // Icon(
                              //   Icons.airplanemode_active,
                              //   size: 24.0,
                              // ),
                              // SizedBox(
                              //   width: 5.0,
                              // ),
                              Text(
                                "${routeData[i].keterangan}",
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
                                "${routeData[i].ruteAwal}",
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
                                "${routeData[i].ruteAkhir}",
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
                              SizedBox(width: 15.0),
                              Text(
                                "Menuju",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10.0),
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
                                NumberFormat.currency(
                                        name: "Rp ", decimalDigits: 0)
                                    .format(routeData[i].harga),
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
                                  Navigator.pop(context, routeData[i]);
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
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Cari Rute Travel"),
      ),
      body: SingleChildScrollView(
        child: _airplaneBody(),
      ),
    );
  }
}
