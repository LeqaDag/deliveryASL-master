import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'companyInvoice/add_invoice.dart';
import 'shared_data.dart';

class BusinessInvoice extends StatefulWidget {
  final Business business;
  final String name;

  BusinessInvoice({@required this.business, this.name});

  @override
  _BusinessInvoiceState createState() => _BusinessInvoiceState();
}

class _BusinessInvoiceState extends State<BusinessInvoice> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Order> orders;

    int total;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 31, vertical: 21),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [
            Color(0xfff1f1f1),
            Color(0xffffffff),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
            Icon(
                            Icons.bubble_chart_outlined,
                          ),
                  Text(
                                    "${widget.business.name} " ?? "",
                                    style: new TextStyle(
                                      fontSize: 13.0,
                                      //color: Color(0xFF457B9D),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )

                      ]),
                  subtitle:  InkWell(
                                    child: Text(
                                      " ${widget.business.phoneNumber.toString()} " ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Amiri",
                                      ),
                                    ),
                                    onTap: () {
                                      launch("tel:" +
                                          Uri.encodeComponent(
                                              '${widget.business.phoneNumber.toString()}'));
                                    },
                                  ),

                  trailing:
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                          AddInvoice(
                                                              businessId: widget.business.uid,
                                                              name: widget.name)),

                      );
                    },
                    child: Text("اضافة فاتورة الشركة",
                      style: new TextStyle(fontSize: 14.0,
                          fontWeight: FontWeight.bold,color: Color(0xff316686)),),
                  ),),

              ],
            ),
        //
        // ListTile(
        //   title:  Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: <Widget>[
        //         Icon(
        //             Icons.phone
        //         ),
        //         InkWell(
        //           child: Text(
        //             "${widget.business.phoneNumber} " ?? "",
        //             style: TextStyle(
        //               fontSize: 14,
        //               color: Colors.green,
        //               fontWeight: FontWeight.bold,
        //               fontFamily: "Amiri",
        //             ),
        //           ),
        //           onTap: () {
        //             launch("tel:" +
        //                 Uri.encodeComponent('0${widget.business.phoneNumber}'));
        //           },
        //         ),
        //       ]),
        // ),
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "سعر الطلبيات الجاهزة :- ",
                style: new TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StreamBuilder<List<Order>>(
                  stream: OrderServices()
                      .businessAllDoneOrders(widget.business.uid),
                  builder: (context, snapshot) {
                    int totalPrice = 0;
                    if (!snapshot.hasData) {
                      return Text('جاري التحميل ... ');
                    } else {
                      orders = snapshot.data;
                      orders.forEach((element) {
                        if (element.isPaid == false) {
                          totalPrice += element.price;
                          total = totalPrice;
                        }
                      });
                      return Text(
                        totalPrice.toString(),
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF457B9D),
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(
                    left: height * 0.025,
                    right: height * 0.025,
                    top: height * 0,
                    bottom: height * 0),
                child: Image.asset(
                  'assets/price.png',
                  scale: 1.3,
                ),
              ),
            ],
          ),
        ),

            OrderCountByBusiness(
              business: widget.business,
            ),
      ]),
    ));


  }

  // ignore: non_constant_identifier_names
  Widget VerticalDivider() {
    return Container(
      color: Colors.black45,
      height: 50,
      width: 1,
    );
  }

  // ignore: non_constant_identifier_names
  Widget HorizantalDivider(double width) {
    return Container(
      color: Colors.black45,
      height: 1,
      width: width,
    );
  }
}
