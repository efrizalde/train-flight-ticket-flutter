import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:ujikom_efrizal/model/PaymentData.dart';

class PayConfirm extends StatefulWidget {
  PayConfirm({@required this.data});
  final PaymentData data;
  @override
  _PayConfirmState createState() => _PayConfirmState();
}

class _PayConfirmState extends State<PayConfirm> {
  @override
  Widget build(BuildContext context) {
    Widget _paymentInstruction() {
      return Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context, widget.data);
          },
          color: Theme.of(context).primaryColor,
          child: Container(
            alignment: Alignment.center,
            height: 60.0,
            child: Text("PILIH PEMBAYARAN"),
          ),
          textColor: Colors.white,
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
                    imageUrl: widget.data.bankLogo,
                    fit: BoxFit.fitWidth,
                    height: 60.0,
                    width: 60.0,
                  ),
                  title: Text(
                    "${widget.data.bankName}",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.data.norek,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text("a.n ${widget.data.ownername}")
                    ],
                  ),
                  // trailing: Icon(Icons.navigate_next),
                  onTap: () {},
                  onLongPress: () {},
                  enabled: false,
                  trailing: IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.data.norek));
                      // Scaffold.of(pcontext).showSnackBar(SnackBar(
                      //   content: Text("Teks Telah Disalin"),
                      // ));
                    },
                  ),
                )
              ],
            )),
      );
    }

    List<Widget> _paymentManualBody(BuildContext pcontext) {
      Container container = Container(
        alignment: Alignment.center,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: Text(
                          "Please transfer the following amount of money to bank account below",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      _cardPayment(pcontext),
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      );
      var l = new List<Widget>();
      l.add(container);

      return l;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Manual Payments"),
        elevation: 0.0,
      ),
      body: Stack(
        children: _paymentManualBody(context),
      ),
      bottomNavigationBar: _paymentInstruction(),
    );
  }
}
