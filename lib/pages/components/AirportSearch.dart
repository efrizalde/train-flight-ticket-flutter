import 'package:flutter/material.dart';
import 'package:ujikom_efrizal/model/AirportData.dart';

class AirportSearch extends StatefulWidget {
  AirportSearch({this.airportData});
  final List<AirportData> airportData;

  @override
  AirportSearchState createState() {
    return new AirportSearchState();
  }
}

class AirportSearchState extends State<AirportSearch> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  List<AirportData> _airportDatas = new List();
  AirportData returnData;

  @override
  void initState() {
    setState(() {
      _airportDatas = widget.airportData;
    });

    _textEditingController.addListener(() {
      String searchtxt = _textEditingController.text.toLowerCase();
      List<AirportData> searchResult = new List();

      widget.airportData.forEach((f) {
        if (f.name.toLowerCase().contains(searchtxt) ||
            f.city.toLowerCase().contains(searchtxt) ||
            f.code.toLowerCase().contains(searchtxt)) {
          print(searchtxt);
          searchResult.add(f);
        }
      });

      setState(() {
        _airportDatas = searchResult;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Form(
                key: _formKey,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.all(10.0),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                top: 10.0, right: 10.0, bottom: 10.0),
                            hintText: "Cari Bandara",
                            hintStyle: TextStyle(color: Colors.grey[400])),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _airportDatas.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, _airportDatas[i]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey[300], width: 0.5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "${_airportDatas[i].code} - ${_airportDatas[i].city}"),
                        Text(
                          "${_airportDatas[i].name}",
                          style: TextStyle(color: Colors.grey, fontSize: 11.0),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
