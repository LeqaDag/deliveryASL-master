import 'package:flutter/material.dart';
import 'package:sajeda_app/classes/city.dart';

class CityItem extends StatelessWidget {
  final City city;
  CityItem({this.city});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        onTap: () {
          Navigator.pop(context, city);
        },
        title: Align(
          alignment: Alignment.center,
          child: Text(
            '${city.name}',
            style: TextStyle(fontFamily: 'Amiri', fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
