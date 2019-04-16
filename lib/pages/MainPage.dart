// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:intl/intl.dart';

// import 'package:ujikom_efrizal/model/AirportData.dart';
// import 'package:ujikom_efrizal/model/TrainStationData.dart';
// import 'package:ujikom_efrizal/pages/FlightTab.dart';
// import 'package:ujikom_efrizal/utils/AirportUtils.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:ujikom_efrizal/utils/Navigator.dart';
// import 'package:ujikom_efrizal/utils/TrainUtils.dart';

// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   PageController pageController = new PageController();
//   List<AirportData> airportData = new List();
//   List<TrainStationData> trainData = new List();
//   int selectedTab = 0;
//   final _formKey = GlobalKey<FormState>();
//   final _formKeyTrain = GlobalKey<FormState>();
//   var txtDestination = new TextEditingController();
//   var txtEndTime = new TextEditingController();
//   bool isLoading = true;
//   bool isSubmitting = false;
//   bool valid = true;
//   String planeDepart = "",
//       planeArrival = "",
//       trainDepart = "",
//       trainArrival = "";
//   DateTime initStart = DateTime.now();
//   DateTime initEnd = DateTime.utc(
//       DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
//   DateTime initRemider = DateTime.now();
//   DateTime flightDate = DateTime.now(), trainDate, reminderDateTime;

//   @override
//   initState() {
//     if (mounted) {
//       AirportUtils().loadAirport().then((airport) {
//         setState(() {
//           airportData = airport;
//           planeDepart = airport[0].code;
//           planeArrival = airport[0].code;
//         });

//         TrainUtils().loadTrainStation().then((trainstation) {
//           setState(() {
//             trainData = trainstation;
//             trainDepart = trainstation[0].code;
//             trainArrival = trainstation[0].code;
//             isLoading = false;
//           });
//         });
//       });
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget _loading({double size = 30.0}) {
//       return Container(
//         height: size,
//         width: size,
//         color: Colors.transparent,
//         child: CircularProgressIndicator(),
//       );
//     }

//     _bottomTab() => Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                   blurRadius: 10.0,
//                   color: Colors.black45,
//                   offset: Offset(0.0, 5.0),
//                   spreadRadius: 1.0)
//             ],
//           ),
//           height: 70.0,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Expanded(
//                   child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     selectedTab = 0;
//                     AirportUtils().loadAirport().then((airport) {
//                       airportData = airport;
//                     });
//                     pageController.animateToPage(0,
//                         duration: Duration(milliseconds: 500),
//                         curve: Curves.ease);
//                   });
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Icon(
//                       Icons.airplanemode_active,
//                       color: (selectedTab == 0)
//                           ? Theme.of(context).primaryColor
//                           : Colors.grey[400],
//                     ),
//                     Text(
//                       "Pesawat",
//                       style: TextStyle(
//                         color: (selectedTab == 0)
//                             ? Theme.of(context).primaryColor
//                             : Colors.grey[400],
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//               Container(
//                 width: 1.0,
//                 height: 30.0,
//                 color: Colors.grey,
//               ),
//               Expanded(
//                 child: InkWell(
//                   onTap: () {
//                     setState(() {
//                       selectedTab = 1;
//                       pageController.animateToPage(1,
//                           duration: Duration(milliseconds: 500),
//                           curve: Curves.ease);
//                     });
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Icon(
//                         Icons.train,
//                         color: (selectedTab == 1)
//                             ? Theme.of(context).primaryColor
//                             : Colors.grey[400],
//                       ),
//                       Text(
//                         "Kereta",
//                         style: TextStyle(
//                           color: (selectedTab == 1)
//                               ? Theme.of(context).primaryColor
//                               : Colors.grey[400],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );

//     _trainForm() {
//       return Container(
//         padding: EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKeyTrain,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Card(
//                   child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 15.0),
//                   Row(
//                     children: <Widget>[
//                       SizedBox(width: 15.0),
//                       Icon(
//                         MdiIcons.airplaneTakeoff,
//                         size: 16.0,
//                         color: Colors.grey,
//                       ),
//                       SizedBox(width: 5.0),
//                       Text(
//                         "Pemberangkatan",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   InputDecorator(
//                     baseStyle: TextStyle(fontSize: 10.0),
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(15.0),
//                         border: InputBorder.none),
//                     child: new DropdownButtonHideUnderline(
//                       child: new DropdownButton(
//                         value: trainDepart,
//                         isDense: true,
//                         onChanged: (String val) {
//                           setState(() {
//                             trainDepart = val;
//                           });
//                         },
//                         items: trainData.map((f) {
//                           return new DropdownMenuItem(
//                             value: f.code,
//                             child: new Text("${f.name}"),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   )
//                 ],
//               )),
//               SizedBox(height: 10.0),
//               Card(
//                   child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 15.0),
//                   Row(
//                     children: <Widget>[
//                       SizedBox(width: 15.0),
//                       Icon(
//                         MdiIcons.airplaneLanding,
//                         size: 16.0,
//                         color: Colors.grey,
//                       ),
//                       SizedBox(width: 5.0),
//                       Text(
//                         "Ke",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   InputDecorator(
//                     baseStyle: TextStyle(fontSize: 10.0),
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(15.0),
//                         border: InputBorder.none),
//                     child: new DropdownButtonHideUnderline(
//                       child: new DropdownButton(
//                         value: trainArrival,
//                         isDense: true,
//                         onChanged: (String val) {
//                           setState(() {
//                             trainArrival = val;
//                           });
//                         },
//                         items: trainData.map((f) {
//                           return new DropdownMenuItem(
//                             value: f.code,
//                             child: new Text("${f.name}"),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   )
//                 ],
//               )),
//               SizedBox(height: 10.0),
//               Card(
//                   child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 15.0),
//                   Row(
//                     children: <Widget>[
//                       SizedBox(width: 15.0),
//                       Icon(
//                         MdiIcons.calendar,
//                         size: 16.0,
//                         color: Colors.grey,
//                       ),
//                       SizedBox(width: 5.0),
//                       Text(
//                         "Tanggal",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                   DateTimePickerFormField(
//                     textAlign: TextAlign.left,
//                     inputType: InputType.date,
//                     format: DateFormat("EEEE, dd MMMM yyyy"),
//                     initialValue: DateTime.now(),
//                     editable: false,
//                     resetIcon: null,
//                     firstDate: DateTime.utc(DateTime.now().year,
//                         DateTime.now().month, DateTime.now().day - 1),
//                     initialDate: initStart,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(15.0),
//                       border: InputBorder.none,
//                     ),
//                     onChanged: (dt) {},
//                   ),
//                 ],
//               )),
//               SizedBox(height: 10.0),
//               (!valid)
//                   ? Container(
//                       width: MediaQuery.of(context).size.width,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                       decoration: BoxDecoration(
//                           color: Colors.red[300],
//                           borderRadius: BorderRadius.circular(10.0)),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(
//                             Icons.warning,
//                             size: 13.0,
//                             color: Colors.white,
//                           ),
//                           SizedBox(width: 5.0),
//                           Expanded(
//                             child: Text(
//                               "Please fill out the form correctly!",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           )
//                         ],
//                       ))
//                   : Container(),
//               SizedBox(height: 10.0),
//               Container(
//                 alignment: Alignment.centerRight,
//                 child: (!isSubmitting)
//                     ? RaisedButton(
//                         child: Container(
//                           width: 100.0,
//                           height: 50.0,
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Search Ticket",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         onPressed: () {},
//                         color: Theme.of(context).primaryColor,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(25.0),
//                                 bottomRight: Radius.circular(25.0))),
//                       )
//                     : RaisedButton(
//                         child: Container(
//                           width: 80.0,
//                           alignment: Alignment.center,
//                           child: _loading(size: 15.0),
//                         ),
//                         onPressed: null,
//                         color: Colors.grey[100],
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20.0)),
//                       ),
//               )
//             ],
//           ),
//         ),
//       );
//     }

//     _trainBody() => Container(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 height: 200.0,
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor,
//                     borderRadius:
//                         BorderRadius.only(bottomRight: Radius.circular(25.0))),
//               ),
//               _trainForm()
//             ],
//           ),
//         );

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         title: Text("Travelijal"),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: PageView(
//                 controller: pageController,
//                 onPageChanged: (p) {
//                   setState(() {
//                     selectedTab = p;
//                   });
//                 },
//                 children: <Widget>[
//                   (!isLoading)
//                       ? SingleChildScrollView(
//                           child: FlightTab(),
//                         )
//                       : Container(
//                           alignment: Alignment.center,
//                           child: CircularProgressIndicator(),
//                         ),
//                   (!isLoading)
//                       ? _trainBody()
//                       : Container(
//                           alignment: Alignment.center,
//                           child: CircularProgressIndicator(),
//                         ),
//                 ],
//               ),
//             ),
//             _bottomTab()
//           ],
//         ),
//       ),
//     );
//   }
// }
