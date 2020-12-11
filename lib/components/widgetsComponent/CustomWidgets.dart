import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/business.dart';
import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:AsyadLogistic/classes/order.dart';
import 'package:AsyadLogistic/components/lineComponent/mainLineComponent/updateMainLine.dart';
import 'package:AsyadLogistic/components/orderComponent/organizeOrderInfo.dart';
import 'package:AsyadLogistic/services/businessServices.dart';
import 'package:AsyadLogistic/services/cityServices.dart';
import 'package:AsyadLogistic/services/customerServices.dart';
import 'package:AsyadLogistic/services/driverServices.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:AsyadLogistic/services/mainLineServices.dart';
import 'package:AsyadLogistic/services/orderServices.dart';
import 'package:intl/intl.dart' as intl;
import '../../constants.dart';
import 'package:badges/badges.dart';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboardInputType;
  final bool obscuretext;
  final String hinttext;
  final Icon icon;

  CustomTextFormField(
      this.keyboardInputType, this.obscuretext, this.hinttext, this.icon);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(right: width * 0.08, left: width * 0.08),
      child: TextFormField(
        keyboardType: keyboardInputType,
        obscureText: obscuretext,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 10.0, left: 10.0),
          hintText: hinttext,
          hintStyle: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 18.0,
          ),
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

/*             start AddLines Custom Widget         */
class CustomCardAndListTileAddLine extends StatelessWidget {
  final Color color;
  final Function onTapBox;
  final String name;
  final MainLine mainLine;

  CustomCardAndListTileAddLine({
    @required this.color,
    this.onTapBox,
    @required this.mainLine,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    String locationName = "";
    FutureBuilder<String>(
        future: LocationServices(uid: mainLine.locationID)
            .cityName(mainLine.locationID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            locationName = snapshot.data;
            return Text("");
          } else {
            return Text("");
          }
        });

    return Card(
      color: color,
      child: ListTile(
        onTap: onTapBox,
        title: FutureBuilder<String>(
            future: LocationServices(uid: mainLine.locationID)
                .cityName(mainLine.locationID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                locationName = snapshot.data;
                return Text(" ${mainLine.name} - ${mainLine.cityName} ");
              } else {
                return Text("");
              }
            }),
        leading: Image.asset("assets/LineIcon.png"),
        trailing: Wrap(
          spacing: -15,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.green),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateMainLine(name: name, mainLineID: mainLine.uid),
                  ),
                );
              },
            ),
            IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) => CustomDialog(
                            title: "حذف خط سير",
                            description: ' هل ترغب بحذف خط السير',
                            name: mainLine.name,
                            buttonText: "تأكيد",
                            onPressed: () {
                              // final FirebaseAuth auth = FirebaseAuth.instance;
                              // final User user = auth.currentUser;
                              MainLineServices()
                                  .deleteMainLineData(mainLine.uid);
                              Navigator.of(context).pop();
                            },
                            cancelButton: "الغاء",
                            cancelPressed: () {
                              Navigator.of(context).pop();
                            },
                          ));
                }),
          ],
        ),
      ),
    );
  }
}
/*            end AddLines Custom Widget         */

class CustomBoxSize extends StatelessWidget {
  final double height;
  CustomBoxSize({@required this.height});

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * this.height,
    );
  }
}

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final AssetImage imagepath;
  final String text;
  final Function onTap;
  CustomContainer(
      {@required this.width,
      @required this.height,
      @required this.imagepath,
      @required this.text,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
          height: height * 0.15,
          width: width * 0.29,

          //child: Image.asset("assets/OrdersBox.png"),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                style: BorderStyle.solid, width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: imagepath, scale: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.bold,
                fontFamily: 'Amiri',
              ),
            ),
          )),
    );
  }
}

class CustomContainerOrders extends StatelessWidget {
  final double height;
  final double width;
  final AssetImage imagepath;
  final String text;
  final Function onTap;
  final String count;
  final Color badgeColorAndContainerBorderColor;
  CustomContainerOrders(
      {@required this.width,
      @required this.height,
      @required this.imagepath,
      @required this.text,
      @required this.badgeColorAndContainerBorderColor,
      @required this.onTap,
      @required this.count});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Badge(
        elevation: 5,
        padding: EdgeInsets.all(9.0),
        animationType: BadgeAnimationType.scale,
        //borderRadius: 50,
        badgeContent: Text(
          this.count,
          style: TextStyle(color: Colors.white),
        ),
        badgeColor: badgeColorAndContainerBorderColor,
        position: BadgePosition.topStart(start: -5, top: -10.5),
        child: Container(
            height: height * this.height,
            width: width * this.width,
            //child: Image.asset("assets/OrdersBox.png"),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  style: BorderStyle.solid,
                  width: 3,
                  color: badgeColorAndContainerBorderColor),
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: imagepath,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri',
                ),
              ),
            )),
      ),
    );
  }
}

class CustomEditDriverProfile extends StatelessWidget {
  const CustomEditDriverProfile();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/DriverProfileBackground.png"),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 18,
          right: width * 0.33,
          child: Container(
            height: 130,
            width: 130,
            //  color: Colors.red,
            child: CircularProfileAvatar(
              'https://t3.ftcdn.net/jpg/03/75/83/82/240_F_375838211_smrwBAmQU34nbFiw6VHgSUiwPB10EzVx.jpg', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
              radius: 100, // sets radius, default 50.0
              backgroundColor: Colors
                  .transparent, // sets background color, default Colors.white
              borderWidth: 4, // sets border, default 0.0

              borderColor:
                  Colors.indigo, // sets border color, default Colors.white
              elevation:
                  5.0, // sets elevation (shadow of the profile picture), default value is 0.0
              foregroundColor: Colors.blue.withOpacity(
                  0.1), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
              cacheImage:
                  true, // allow widget to cache image against provided url
              onTap: () {}, // sets on tap
              showInitialTextAbovePicture:
                  true, // setting it true will show initials text above profile picture, default false
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: width * 0.50,
          child: Container(
              height: 50,
              width: 50,
              //color: Colors.red,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.photo_camera,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed:
                      null) //add code to browse image and get image line from DB in String Var
              // and put it in CircularProfileAvatar as url var
              ),
        ),
      ],
    );
  }
}

class CustomCardAndListTile extends StatelessWidget {
  final Color color;
  final Function onTapBox;
  final String businessID, name;
  final String orderState;

  CustomCardAndListTile(
      {@required this.color,
      @required this.onTapBox,
      @required this.businessID,
      @required this.orderState,
      this.name});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder<Business>(
      stream: BusinessServices(uid: businessID).businessByID,
      builder: (context, snapshot) {
        //print(snapshot.data);
        if (snapshot.hasData) {
          Business business = snapshot.data;
          return Card(
            color: color,
            child: ListTile(
              title: Text(
                  "${business.name}"), // String Variable Take Name From DataBase
              leading: CircleAvatar(
                  // Account Image Form DataBase
                  ),
              trailing: Wrap(
                spacing: -15, // space between two icons
                children: <Widget>[
                  FutureBuilder<int>(
                      future: OrderServices(businesID: businessID)
                          .countBusinessOrderByStateOrder(orderState),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Badge(
                            position: BadgePosition.topStart(
                                start: width * 0.04, top: height * -0.004),
                            elevation: 5,
                            animationType: BadgeAnimationType.slide,
                            badgeContent: Text(
                              snapshot.data.toString() ?? "-1",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            shape: BadgeShape.circle,
                            badgeColor: KEditIconColor,
                            child: IconButton(
                                icon: Image.asset("assets/BoxIcon.png"),
                                onPressed: onTapBox),
                          );
                        } else {
                          return Badge(
                            position: BadgePosition.topStart(
                                start: width * 0.04, top: height * -0.004),
                            elevation: 5,
                            animationType: BadgeAnimationType.slide,
                            badgeContent: Text(
                              "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            shape: BadgeShape.circle,
                            badgeColor: KEditIconColor,
                            child: IconButton(
                                icon: Image.asset("assets/BoxIcon.png"),
                                onPressed: onTapBox),
                          );
                        }
                      }),
                  // IconButton(
                  //     icon: Icon(Icons.edit, color: KEditIconColor),
                  //     onPressed: null),
                  // IconButton(
                  //     icon: Icon(Icons.delete, color: Colors.red),
                  //     onPressed: () {
                  //       return showDialog<void>(
                  //           context: context,
                  //           barrierDismissible: false, // user must tap button!
                  //           builder: (BuildContext context) => CustomDialog(
                  //                 title: "حذف شركة ",
                  //                 description:
                  //                     ' هل ترغب بحذف الشركة وجميع طرودها؟',
                  //                 name: business.name,
                  //                 buttonText: "تأكيد",
                  //                 onPressed: () {
                  //                   final FirebaseAuth auth =
                  //                       FirebaseAuth.instance;
                  //                   final User user = auth.currentUser;
                  //                   BusinessService().deleteBusinessData(
                  //                       business.uid, user.uid);
                  //                   Navigator.of(context).pop();
                  //                 },
                  //                 cancelButton: "الغاء",
                  //                 cancelPressed: () {
                  //                   Navigator.of(context).pop();
                  //                 },
                  //               ));
                  //     }),
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;
  CustomFlatButton({this.text, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 45,
        width: width * 0.33,
        child: FlatButton(
          onPressed: onPressed,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 20,
              color: kAdminLoginButtonColor,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCompanyOrdersStatus extends StatelessWidget {
  final Order order;
  final String orderState, name;
  CustomCompanyOrdersStatus({this.order, this.orderState, this.name});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    IconData icon;
    String stateOrder;
    Color color;
    TextEditingController driverPrice = new TextEditingController();
    print(orderState);
    if (order.inStock == true) {
      color = KBadgeColorAndContainerBorderColorWithDriverOrders;
      icon = Icons.archive_sharp;
      stateOrder = "في المخزن";
    }
    if (order.isCancelld == true) {
      color = KBadgeColorAndContainerBorderColorCancelledOrders;
      icon = Icons.cancel;
      stateOrder = "ملغي";
    } else if (order.isDelivery == true) {
      color = KAllOrdersListTileColor;
      icon = Icons.business_center_outlined;
      stateOrder = "جاهز للتوزيع";
    } else if (order.isDone == true) {
      color = KBadgeColorAndContainerBorderColorReadyOrders;
      icon = Icons.done;
      stateOrder = "جاهز";
    } else if (order.isLoading == true) {
      color = KBadgeColorAndContainerBorderColorLoadingOrder;
      icon = Icons.arrow_circle_up_rounded;
      stateOrder = "محمل";
    } else if (order.isUrgent == true) {
      color = KBadgeColorAndContainerBorderColorUrgentOrders;
      icon = Icons.info_outline;
      stateOrder = "مستعجل";
    } else if (order.isReturn == true) {
      color = KBadgeColorAndContainerBorderColorReturnOrders;
      icon = Icons.restore;
      stateOrder = "راجع";
    } else if (order.isReceived == true) {
      color = KBadgeColorAndContainerBorderColorRecipientOrder;
      icon = Icons.assignment_turned_in_outlined;
      stateOrder = "تم استلامه";
    }

    if (orderState == 'isDone' || orderState == 'isPiad') {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrganizeOrderInfo(
                    uid: order.uid, orderState: orderState, name: name)),
          );
        },
        child: Container(
          width: width - 50,
          height: 100,
          child: Card(
            elevation: 5,
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            //color: KCustomCompanyOrdersStatus,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.person,
                              color: Colors.blueGrey,
                            ),
                          ),

                          //  SizedBox(width: 33,),
                          FutureBuilder<String>(
                            future: CustomerServices(uid: order.customerID)
                                .customerName,
                            builder: (context, snapshot) {
                              // print(order.customerID);
                              return Text(
                                snapshot.data ?? "",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Amiri",
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.date_range,
                              color: Colors.blueGrey,
                            ),
                          ),

                          //  SizedBox(width: 33,),
                          Text(
                            intl.DateFormat('yyyy-MM-dd').format(order.date),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,
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

                          //  SizedBox(width: 33,),
                          FutureBuilder<String>(
                            future: CustomerServices(uid: order.customerID)
                                .customerCity,
                            builder: (context, snapshot) {
                              // print(order.customerID);
                              return Text(
                                snapshot.data ?? "",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Amiri",
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Image.asset('assets/price.png'),
                          ),

                          //  SizedBox(width: 33,),
                          Text(
                            order.price.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ],
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
    if (orderState == 'sheet') {
      return InkWell(
        child: Container(
          width: width - 50,
          child: Card(
            elevation: 5,
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            //color: KCustomCompanyOrdersStatus,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                  width: width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.person,
                              color: Colors.green[800],
                            ),
                          ),

                          //  SizedBox(width: 33,),
                          FutureBuilder<String>(
                            future: CustomerServices(uid: order.customerID)
                                .customerName,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data ?? "",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                );
                              } else {
                                return Text("");
                              }
                              // print(order.customerID);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.location_on,
                              color: Colors.blue[800],
                            ),
                          ),
                          FutureBuilder<String>(
                              future: CustomerServices(uid: order.customerID)
                                  .customerCity,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                          FutureBuilder<String>(
                              future: CustomerServices(uid: order.customerID)
                                  .customerSublineName,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    ' - ${snapshot.data}' ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                          FutureBuilder<String>(
                              future: CustomerServices(uid: order.customerID)
                                  .customerAdress,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    ' - ${snapshot.data}' ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.date_range,
                              color: Colors.blueGrey,
                              // size: 17,
                            ),
                          ),

                          //  SizedBox(width: 33,),
                          Text(
                            intl.DateFormat('yyyy-MM-dd').format(order.date) ??
                                "",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.location_city,
                              color: Colors.purple[800],
                            ),
                          ),

                          //  SizedBox(width: 33,),
                          FutureBuilder<String>(
                              future: BusinessServices(uid: order.businesID)
                                  .businessName,
                              builder: (context, snapshot) {
                                // print(snapshot.data);
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Amiri",
                                    ),
                                  );
                                } else {
                                  return Text("");
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                )),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset('assets/price.png'),
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.015,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Text(
                              order.price.toString() ?? "",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Amiri",
                              ),
                            ),
                          ),

                          //  SizedBox(width: 33,),
                        ],
                      ),
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            icon,
                            color: color,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Text(
                              stateOrder ?? "",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Amiri",
                              ),
                            ),
                          ),
                          //  SizedBox(width: 33,),

                          //  SizedBox(width: 33,),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrganizeOrderInfo(
                    uid: order.uid, orderState: orderState, name: name)),
          );
        },
        child: Container(
          width: width - 50,
          height: 100,
          child: Card(
            elevation: 5,
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            //color: KCustomCompanyOrdersStatus,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.person,
                              color: Colors.blueGrey,
                            ),
                          ),

                          //  SizedBox(width: 33,),
                          FutureBuilder<String>(
                            future: CustomerServices(uid: order.customerID)
                                .customerName,
                            builder: (context, snapshot) {
                              // print(order.customerID);
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data ?? "",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,

                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Icon(
                              Icons.date_range,
                              color: Colors.blueGrey,
                            ),
                          ),

                          //  SizedBox(width: 33,),
                          Text(
                            intl.DateFormat('yyyy-MM-dd').format(order.date) ??
                                "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,
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

                          //  SizedBox(width: 33,),
                          FutureBuilder<String>(
                            future: CustomerServices(uid: order.customerID)
                                .customerCity,
                            builder: (context, snapshot) {
                              // print(order.customerID);
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data ?? "",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Amiri",
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        //3
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: height * 0.025,
                                right: height * 0.025,
                                top: height * 0,
                                bottom: height * 0),
                            child: Image.asset('assets/price.png'),
                          ),

                          //  SizedBox(width: 33,),
                          Text(
                            order.price.toString() ?? "",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                        ],
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
}

///start Driver Profile TextFormField
class CustomTextFormFieldDriverProfile extends StatelessWidget {
  final TextInputType keyboardInputType;
//final bool obscuretext;
  final String hinttext;
  final Icon icon;

  CustomTextFormFieldDriverProfile(
      this.keyboardInputType, this.hinttext, this.icon);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(right: width * 0.02, left: width * 0.02),
      child: TextFormField(
        keyboardType: keyboardInputType,
        //obscureText: obscuretext,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 10.0, left: 10.0),
          hintText: hinttext,
          hintStyle: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 18.0,
          ),
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class CityChoice extends StatefulWidget {
  @override
  _CityChoiceState createState() => _CityChoiceState();
}

class _CityChoiceState extends State<CityChoice> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: DropdownButtonFormField(
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(fontFamily: 'Amiri', fontSize: 16.0),
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 1.0,
              color: Color(0xff636363),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 2.0,
              color: Color(0xff73a16a),
            ),
            //Change color to Color(0xff73a16a)
          ),
          contentPadding: EdgeInsets.only(right: 20.0, left: 10.0),
          hintText: "المدينة",

          // labelStyle: TextStyle(
          //     fontFamily: 'Amiri', fontSize: 18.0, color: Color(0xff316686)),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, name, buttonText, cancelButton;
  final Image image;
  final Function onPressed, cancelPressed;

  CustomDialog(
      {@required this.title,
      @required this.description,
      @required this.buttonText,
      this.image,
      this.name,
      this.onPressed,
      @required this.cancelButton,
      this.cancelPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Positioned(
        //   left: Consts.padding,
        //   right: Consts.padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.white,
        //     radius: Consts.avatarRadius,
        //     child: Container(
        //       child: Icon(
        //         Icons.delete,
        //         color: Colors.red,
        //         size: 30,
        //       ),
        //     ),
        //   ),
        // ),
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          // margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.red,
                size: 70,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      onPressed: cancelPressed, // To close the dialog
                      child: Text(
                        cancelButton,
                        style: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18.0,
                          color: Color(0xff316686),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: onPressed,
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18.0,
                          color: Color(0xff316686),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDialogSelectAll extends StatelessWidget {
  final String title, description, name, buttonText, cancelButton;
  final Image image;
  final Function onPressed, cancelPressed;

  CustomDialogSelectAll(
      {@required this.title,
      @required this.description,
      @required this.buttonText,
      this.image,
      this.name,
      this.onPressed,
      @required this.cancelButton,
      this.cancelPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          // margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Icon(
                Icons.check,
                color: Colors.blue[900],
                size: 70,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      onPressed: cancelPressed, // To close the dialog
                      child: Text(
                        cancelButton,
                        style: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18.0,
                          color: Color(0xff316686),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: onPressed,
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18.0,
                          color: Color(0xff316686),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

/// Start Information Order From Driver TextField Status.

class CustomTextFieldOrderStatus extends StatelessWidget {
  final String imageBath;
  final String dbDriverStatus;
  CustomTextFieldOrderStatus(this.imageBath, this.dbDriverStatus);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        enabled: false,
        decoration: InputDecoration(
          icon: Image.asset(
            imageBath,
          ),
          contentPadding: EdgeInsets.all(10),
          labelText: dbDriverStatus, // from db
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
            ),
          ),

          //contentPadding: EdgeInsets.only(right: 10, left: 20),
        ),
      ),
    );
  }
}
