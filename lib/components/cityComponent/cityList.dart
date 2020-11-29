import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';
import 'package:sajeda_app/services/cityServices.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

class CityList extends StatefulWidget {
  final String name;
  CityList({this.name});
  @override
  _CityListState createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  @override
  Widget build(BuildContext context) {
    final city = Provider.of<List<City>>(context) ?? [];
    if (city != []) {
      return ListView.builder(
        itemCount: city.length,
        itemBuilder: (context, index) {
          return CustomCardCity(
            city: city[index],
            color: KAddLinesColor,
            name: widget.name,
          );
        },
      );
    } else {
      return Center(
        child: Image.asset("assets/EmptyOrder.png"),
      );
    }
  }
}

class CustomCardCity extends StatefulWidget {
  final Color color;
  final String name;
  final City city;

  CustomCardCity({
    @required this.color,
    @required this.city,
    this.name,
  });

  @override
  _CustomCardCityState createState() => _CustomCardCityState();
}

class _CustomCardCityState extends State<CustomCardCity> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _cityNameController = new TextEditingController();
    _cityNameController.text = widget.city.name;

    return Card(
      color: widget.color,
      child: ListTile(
        title: Text(widget.city.name),
        leading: Image.asset(
          "assets/city-50.png",
          width: 25,
        ),
        trailing: Wrap(
          spacing: -15,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Colors.green),
              onPressed: () {
                return showDialog<String>(
                  context: context,
                  child: new AlertDialog(
                    contentPadding: const EdgeInsets.all(16.0),
                    content: new Row(
                      children: <Widget>[
                        Expanded(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: _cityNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: widget.city.name,
                                labelStyle: TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 18.0,
                                  color: Color(0xff316686),
                                ),
                                contentPadding: EdgeInsets.only(right: 20.0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: Color(0xff636363),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 2.0,
                                    color: Color(0xff73a16a),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      new FlatButton(
                          child: Text(
                            'تم',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Amiri",
                            ),
                          ),
                          onPressed: () async {
                            widget.city.name = _cityNameController.text;
                            await CityService(uid: widget.city.uid)
                                .updateData(widget.city);
                            Toast.show("تم تعديل المدينة بنجاح", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                            Future.delayed(Duration(milliseconds: 1000));
                            Navigator.of(context).pop();
                          })
                    ],
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
                            title: "حذف مدينة",
                            description: ' هل ترغب بحذف مدينة',
                            name: widget.city.name,
                            buttonText: "تأكيد",
                            onPressed: () {
                              // final FirebaseAuth auth = FirebaseAuth.instance;
                              // final User user = auth.currentUser;
                              CityService().deletecityData(widget.city.uid);
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

class UpdateCustomDialog extends StatelessWidget {
  final String title, description, name, buttonText, cancelButton;
  final Function onPressed, cancelPressed;

  UpdateCustomDialog(
      {@required this.title,
      @required this.description,
      @required this.buttonText,
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
