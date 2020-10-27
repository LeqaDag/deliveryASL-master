import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/busines.dart';
import 'package:sajeda_app/classes/mainLine.dart';
import 'package:sajeda_app/classes/order.dart';
import 'package:sajeda_app/components/orderComponent/organizeOrderInfo.dart';
import 'package:sajeda_app/services/businessServices.dart';
import 'package:sajeda_app/services/customerServices.dart';
import 'package:sajeda_app/services/orderServices.dart';
import 'package:intl/intl.dart';
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
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Card(
      color: color,
      child: ListTile(
        title: Text(mainLine.name), // String Variable Take Name From DataBase

        leading: Image.asset("assets/LineIcon.png"),
        trailing: Wrap(
          spacing: -15, // space between two icons

          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit, color: KEditIconColor), onPressed: null),
            IconButton(
                icon: Icon(Icons.delete, color: KTrashIconColor),
                onPressed: null),
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
          width: width * 0.28,

          //child: Image.asset("assets/OrdersBox.png"),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                style: BorderStyle.solid, width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: imagepath,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
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
        borderRadius: 50,
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
    print(businessID);
    return StreamBuilder<Business>(
        stream: BusinessService(uid: businessID).businessByID,
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
                        future: OrderService(businesID: businessID)
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
                    IconButton(
                        icon: Icon(Icons.edit, color: KEditIconColor),
                        onPressed: null),
                    IconButton(
                        icon: Icon(Icons.delete, color: KTrashIconColor),
                        onPressed: null),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
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
                                  future: CustomerService(uid: order.customerID)
                                      .customerName,
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Amiri",
                                      ),
                                    );
                                  }),
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
                                DateFormat('yyyy-MM-dd').format(order.date),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Amiri",
                                ),
                              ),
                            ],
                          ),
                        ]),
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
                              Text(
                                "الموقع",
                                style: TextStyle(
                                  fontSize: 16,
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
                        ]),
                  ),
                ]),
          )),
    );
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
