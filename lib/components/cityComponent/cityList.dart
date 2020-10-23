import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sajeda_app/classes/city.dart';
import 'package:sajeda_app/components/cityComponent/cityItem.dart';

class CityList extends StatefulWidget {
  @override
  _CityListState createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  @override
  Widget build(BuildContext context) {
    final citys = Provider.of<List<City>>(context);
    print(citys);
    return ListView.builder(
      itemCount: citys.length,
      itemBuilder: (context, index) {
        return CityItem(city: citys[index]);
      },
    );
  }
}
