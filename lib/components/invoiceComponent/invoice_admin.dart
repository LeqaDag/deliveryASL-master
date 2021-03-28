import 'package:AsyadLogistic/components/invoiceComponent/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';

import 'shared_data.dart';

class InvoiceAdmin extends StatefulWidget {
  final String name;
  InvoiceAdmin({this.name});

  @override
  _InvoiceAdminState createState() => _InvoiceAdminState();
}

class _InvoiceAdminState extends State<InvoiceAdmin> {
  int _cIndex = 0;

 

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
  final List<Widget> _children = [
    PlaceholderWidget(invoiceType: "order", name: widget.name),
    PlaceholderWidget(invoiceType: "driver", name: widget.name),
    PlaceholderWidget(invoiceType: "business", name: widget.name),
  ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: AdminDrawer(name: widget.name),
        appBar: AppBar(
          backgroundColor: Color(0xFF457B9D),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
          title: Text(widget.name ?? "",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
        ),
        bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Colors.black,
          selectedItemColor: Color(0xFF457B9D),
          unselectedItemColor: Colors.black,
          currentIndex: _cIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.work),
              label: 'الطرود',
            ),
            // BottomNavigationBarItem(
            //   icon: new Icon(Icons.content_paste_outlined),
            //   title: new Text('الفواتير'),
            // ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.airport_shuttle_outlined),
              label: 'وضع السائق',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'الزبائن',
            ),
          ],
          onTap: (_cIndex) {
            _incrementTab(_cIndex);
          },
        ),

        body: _children[_cIndex],

        // Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: <Widget>[
        //     ListTile(
        //       title: Image(
        //         image: AssetImage("assets/companyPrice.png"),
        //         width: 80,
        //         height: 80,
        //       ),
        //       subtitle: Text(
        //         " فاتورة الشركات ",
        //         textAlign: TextAlign.center,
        //       ),
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => CompanyInvoiceAdmin(
        //               name: widget.name,
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //     ListTile(
        //       title: Image(
        //         image: AssetImage("assets/driverPrice.png"),
        //         width: 80,
        //         height: 80,
        //       ),
        //       subtitle: Text(
        //         " فاتورة السائقون ",
        //         textAlign: TextAlign.center,
        //       ),
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => DriverInvoiceAdmin(
        //               name: widget.name,
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
