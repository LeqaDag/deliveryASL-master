import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomCompanyOrdersStatus extends StatelessWidget {
  final int y;
  final Function click;

  CustomCompanyOrdersStatus(this.y, this.click);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String x = "1028";
    Color color;

    switch (y) {
      case 0:
        {
          color = KReadyOrdersListTileColor;
        }

        /// Ready Orders
        break;

      case 1:
        {
          color = KUrgentOrdersListTileColor;
        }

        /// Urgent Orders
        break;

      case 2:
        {
          color = KAllOrdersListTileColor;
        }

        /// All Orders
        break;

      case 3:
        {
          color = KReturnOrdersListTileColor;
        }

        /// Returned Orders
        break;

      case 4:
        {
          color = LCanceledOrderListTileColor;
        }

        /// Canceled Orders
        break;

      case 5:
        {
          color = KPendingListTileColor;
        }

        /// Pending Orders
        break;

      case 6:
        {
          color = KPickupListTileColor;
        }

        /// Pickup Orders
        break;
    }

    return InkWell(
      onTap: click,
      child: Container(
        width: double.infinity,
        height: 133,
        child: Card(
          color: KCustomCompanyOrdersStatus,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                child: Container(
                  width: 17,
                  height: 125,
                  child: Card(
                    color: color,

                    ///case color
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Row(
                  //1

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: height * 0.025,
                          right: height * 0.025,
                          top: height * 0.025,
                          bottom: height * 0.025),
                      child: Icon(
                        Icons.date_range,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      "تاريخ الطلبية: " + x,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Amiri",
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 53,
                left: height * 0.12,
                child: Row(
                  //2
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: height * 0.025,
                          right: height * 0.2,
                          top: height * 0,
                          bottom: height * 0),
                      child: Icon(
                        Icons.toys,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      "السعر الكلي: " + x,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Amiri",
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 8,
                child: Row(
                  //3

                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: height * 0.025,
                          right: height * 0.025,
                          top: height * 0,
                          bottom: height * 0),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text(
                      "الموقع: " + x,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Amiri",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
