import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              height: 200.0,
              color: Theme.of(context).primaryColor,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 150.0),
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: 64.0,
                      color: Colors.grey,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0,
                        )),
                    width: 100.0,
                    height: 100.0,
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          onTap: () {},
                          title: Text("Akun Saya"),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          title: Text("Pesanan Saya"),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Dibuat oleh Efrizal Degriyanto\nUjikom 2019 - RPL SMKN 1 CIMAHI\nCopyright 2019",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 10.0),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
