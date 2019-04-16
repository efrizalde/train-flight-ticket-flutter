import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ujikom_efrizal/model/AirportData.dart';
import 'package:ujikom_efrizal/model/RoutesData.dart';
import 'package:ujikom_efrizal/model/TrainStationData.dart';
import 'package:ujikom_efrizal/pages/FlightTab.dart';
import 'package:ujikom_efrizal/pages/TrainTab.dart';
import 'package:ujikom_efrizal/pages/components/DrawerComponent.dart';
import 'package:ujikom_efrizal/utils/AirportUtils.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ujikom_efrizal/utils/TrainUtils.dart';
import 'package:ujikom_efrizal/utils/services/RoutesServices.dart';

class MainPageNew extends StatefulWidget {
  @override
  _MainPageNewState createState() => _MainPageNewState();
}

class _MainPageNewState extends State<MainPageNew> {
  PageController pageController = new PageController();
  List<AirportData> airportData = new List();
  List<TrainStationData> trainData = new List();
  int selectedTab = 0;
  final _formKey = GlobalKey<FormState>();
  final _formKeyTrain = GlobalKey<FormState>();
  var txtDestination = new TextEditingController();
  var txtEndTime = new TextEditingController();
  bool isLoading = true;
  bool isSubmitting = false;
  bool valid = true;
  String planeDepart = "",
      planeArrival = "",
      trainDepart = "",
      trainArrival = "";
  DateTime initStart = DateTime.now();
  DateTime initEnd = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  DateTime initRemider = DateTime.now();
  DateTime flightDate = DateTime.now(), trainDate, reminderDateTime;
  List<RoutesData> listRdata = new List();

  @override
  initState() {
    if (mounted) {
      RoutesServices().getdata().then((rdata) {
        setState(() {
          isLoading = false;
          listRdata = rdata;
        });
      }).catchError((e) {
        print(e.toString());
      });
    }
    super.initState();
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

    _bottomTab() => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black45,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 1.0)
            ],
          ),
          height: 70.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTab = 0;
                    AirportUtils().loadAirport().then((airport) {
                      airportData = airport;
                    });
                    pageController.animateToPage(0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.airplanemode_active,
                      color: (selectedTab == 0)
                          ? Theme.of(context).primaryColor
                          : Colors.grey[400],
                    ),
                    Text(
                      "Pesawat",
                      style: TextStyle(
                        color: (selectedTab == 0)
                            ? Theme.of(context).primaryColor
                            : Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              )),
              Container(
                width: 1.0,
                height: 30.0,
                color: Colors.grey,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedTab = 1;
                      pageController.animateToPage(1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.train,
                        color: (selectedTab == 1)
                            ? Theme.of(context).primaryColor
                            : Colors.grey[400],
                      ),
                      Text(
                        "Kereta",
                        style: TextStyle(
                          color: (selectedTab == 1)
                              ? Theme.of(context).primaryColor
                              : Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );

    return Scaffold(
      drawer: DrawerComponent(),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Travelijal"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (p) {
                  setState(() {
                    selectedTab = p;
                  });
                },
                children: <Widget>[
                  (!isLoading)
                      ? SingleChildScrollView(
                          child: FlightTab(
                            rdata: listRdata,
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                  (!isLoading)
                      ? SingleChildScrollView(
                          child: TrainTab(
                            rdata: listRdata,
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
            _bottomTab()
          ],
        ),
      ),
    );
  }
}
