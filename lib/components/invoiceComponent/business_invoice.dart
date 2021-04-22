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

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Card(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.bubble_chart_outlined,
                    ),
                    Expanded(
                        child: Text(
                      "${widget.business.name} " ?? "",
                      style: new TextStyle(
                        fontSize: 13.0,
                        //color: Color(0xFF457B9D),
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    VerticalDivider(),
                    Icon(
                      Icons.location_on,
                    ),
                    BusinessCityName(
                      business: widget.business,
                    ),
                  ]),
              HorizantalDivider(width),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "اضافة فاتورة ",
                            style: new TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddInvoice(
                                        businessId: widget.business.uid,
                                        name: widget.name)),
                              );
                            },
                            icon: Icon(
                              Icons.add,
                            ),
                          )
                        ]),
                  ]),
              HorizantalDivider(width),
              OrderCountByBusiness(
                business: widget.business,
              ),
              HorizantalDivider(width),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Expanded(
                          child: Text(
                        " ${widget.business.phoneNumber.toString()} " ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Amiri",
                        ),
                      )),
                      onTap: () {
                        launch("tel:" +
                            Uri.encodeComponent(
                                '${widget.business.phoneNumber.toString()}'));
                      },
                    ),
                  ]),
            ],
          )),
          SizedBox(
            height: 15,
          ),
        ]);
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
