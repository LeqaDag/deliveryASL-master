import 'package:flutter/material.dart';
import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/classes/city.dart';
import 'package:AsyadLogistic/services/cityServices.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

// ignore: must_be_immutable
class CustomTitle extends StatelessWidget {
  String title;

  CustomTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      color: KCustomCompanyOrdersStatus,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Amiri",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LabelTextFieldPhone extends StatelessWidget {
  IconData icon;
  Color color;
  String text;

  LabelTextFieldPhone(this.icon, this.color, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      // margin: EdgeInsets.only(right:width*0.04 ,left:width*0.04 ),
      // color: KCustomCompanyOrdersStatus,

      child: TextField(
        onTap: () => launch("tel:0595114481"),
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Icon(
            icon,
            color: color,
            size: 20,
          ),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LabelTextFieldPrice extends StatelessWidget {
  String text;

  LabelTextFieldPrice(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      // margin: EdgeInsets.only(right:width*0.04 ,left:width*0.04 ),
      // color: KCustomCompanyOrdersStatus,

      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Image.asset('assets/price.png'),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LabelTextField extends StatelessWidget {
  IconData icon;
  Color color;
  String text;

  LabelTextField(this.icon, this.color, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      // margin: EdgeInsets.only(right:width*0.04 ,left:width*0.04 ),
      // color: KCustomCompanyOrdersStatus,

      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Icon(
            icon,
            color: color,
            size: 20,
          ),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LabelTextFieldCity extends StatelessWidget {
  IconData icon;
  Color color;
  String text;

  LabelTextFieldCity(this.icon, this.color, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      child: StreamBuilder<City>(
          stream: CityServices(uid: text).cityByID,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TextField(
                enabled: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
                  prefixIcon: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                  hintText: snapshot.data.name, //String Data form DB.
                ),
              );
            } else {
              return TextField(
                enabled: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
                  prefixIcon: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                  hintText: "", //String Data form DB.
                ),
              );
            }
          }),
    );
  }
}

// ignore: must_be_immutable
class LabelTextFieldMainLine extends StatelessWidget {
  IconData icon;
  Color color;
  String text;

  LabelTextFieldMainLine(this.icon, this.color, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      child: StreamBuilder<Location>(
        stream: LocationServices(uid: text).locationByID,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Location location = snapshot.data;
            return TextField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
                prefixIcon: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
                hintText: location.name ?? "", //String Data form DB.
              ),
            );
          } else {
            return TextField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
                prefixIcon: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
                hintText: "loading ...", //String Data form DB.
              ),
            );
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class LabelTextFieldCityName extends StatelessWidget {
  IconData icon;
  Color color;
  String text;
  LabelTextFieldCityName(this.icon, this.color, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 7, bottom: 7, right: 8),
          prefixIcon: Icon(
            icon,
            color: color,
            size: 20,
          ),
          hintText: text, //String Data form DB.
        ),
      ),
    );
  }
}
