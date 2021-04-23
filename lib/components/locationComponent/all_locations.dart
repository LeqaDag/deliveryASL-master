// import 'package:AsyadLogistic/classes/location.dart';
// import 'package:AsyadLogistic/classes/mainLine.dart';
// import 'package:AsyadLogistic/components/pages/drawer.dart';
// import 'package:AsyadLogistic/services/locationServices.dart';
// import 'package:AsyadLogistic/services/mainLineServices.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../constants.dart';
// import 'location_details.dart';

// class LocationList extends StatefulWidget {
//   final String name;
//   LocationList({this.name});
//   @override
//   _LocationListState createState() => _LocationListState();
// }

// class _LocationListState extends State<LocationList> {
//   @override
//   Widget build(BuildContext context) {
//     final location = Provider.of<List<Location>>(context) ?? [];
//     if (location != []) {
//       return ListView.builder(
//         itemCount: location.length,
//         itemBuilder: (context, index) {
//           return CustomCardAndListTileLocation(
//             location: location[index],
//             name: widget.name,
//           );
//         },
//       );
//     } else {
//       return Center(
//         child: Image.asset("assets/EmptyOrder.png"),
//       );
//     }
//   }
// }

// class CustomCardAndListTileLocation extends StatelessWidget {
//   final Function onTapBox;
//   final String name;
//   final Location location;

//   CustomCardAndListTileLocation({
//     this.onTapBox,
//     @required this.location,
//     this.name,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: () {
//           MainLineServices(locationID: location.uid).getNameByLocation();
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => LocationDetailsList(
//                   locationID: location.uid,
//                   name: name,
//                   locationName: location.name),
//             ),
//           );
//         },
//         child: Card(
//           child: ListTile(
//             onTap: onTapBox,
//             title: FutureBuilder<String>(
//                 future:
//                     LocationServices(uid: location.uid).cityName(location.uid),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Text(" ${location.name}");
//                   } else {
//                     return Text("");
//                   }
//                 }),
//             leading: Image.asset(
//               "assets/region50.png",
//               width: 30,
//             ),
//             trailing: Wrap(
//               spacing: -15,
//               children: <Widget>[],
//             ),
//           ),
//         ));
//   }
// }

// class LocationDetailsList extends StatelessWidget {
//   final String name, locationID, locationName;
//   LocationDetailsList({this.name, this.locationID, this.locationName});

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('$locationName',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontFamily: 'Amiri',
//               )),
//           backgroundColor: kAppBarColor,
//           centerTitle: true,
//         ),
//         // body: StreamProvider<List<MainLine>>.value(
//         //       value: MainLineServices(locationID: locationID).mainLineByLocationID,
//         //       child: LocationDetails(name: name, locationID: locationID),
//         //     ),
//         drawer: AdminDrawer(name: name),
//         body: LocationDetails1(name: name, locationID: locationID),
//       ),
//     );
//   }
// }

// class LocationDetails1 extends StatefulWidget {
//   final String name, locationID;
//   LocationDetails1({this.name, this.locationID});

//   @override
//   _LocationDetailsState createState() => _LocationDetailsState();
// }

// class _LocationDetailsState extends State<LocationDetails1> {
//   @override
//   Widget build(BuildContext context) {
//     List<String> mainlineList =
//         MainLineServices().mainLineNameByLocationID(widget.locationID);

//     print(mainlineList);

//     // return LocationDetails(mainlineList: mainlineList);

//     // return ReorderableListView(
//     //   scrollDirection: Axis.horizontal,
//     //   children: <Widget>[
//     //     for (final items in mainLines)
//     //       Card(
//     //         color: Colors.blueGrey,
//     //         key: ValueKey(items),
//     //         elevation: 2,
//     //         child: ListTile(
//     //           title: Text(items),
//     //           leading: Icon(
//     //             Icons.work,
//     //             color: Colors.black,
//     //           ),
//     //         ),
//     //       ),
//     //   ],
//     //   onReorder: reorderData,
//     // );

//     // if (mainLine != []) {
//     //   return ListView.builder(
//     //       itemCount: mainLine.length,
//     //       itemBuilder: (context, index) {
//     //         MainLine mainLineItem = mainLine[index];
//     //         if (mainLineItem.isArchived == true) {
//     //           return Visibility(
//     //             child: Text("Gone"),
//     //             visible: false,
//     //           );
//     //         } else {
//     //           return Card(
//     //             //key: ValueKey(subLineItem.index),
//     //             child: ListTile(
//     //               title: Text(mainLineItem.name),
//     //               leading: Image.asset(
//     //                 "assets/region50.png",
//     //                 width: 30,
//     //               ),
//     //               trailing: Wrap(
//     //                 spacing: -15,
//     //                 children: <Widget>[],
//     //               ),
//     //             ),
//     //           );
//     //         }
//     //       });
//     // } else {
//     //   return Center(child: Image.asset("assets/EmptyOrder.png"));
//     // }
//   }
// }

import 'package:AsyadLogistic/classes/location.dart';
import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/services/locationServices.dart';
import 'package:AsyadLogistic/services/mainLineServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'location_details.dart';

class LocationList extends StatefulWidget {
  final String name;
  LocationList({this.name});
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    final location = Provider.of<List<Location>>(context) ?? [];
    if (location != []) {
      return ListView.builder(
        itemCount: location.length,
        itemBuilder: (context, index) {
          return CustomCardAndListTileLocation(
            location: location[index],
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

class CustomCardAndListTileLocation extends StatelessWidget {
  final Function onTapBox;
  final String name;
  final Location location;

  CustomCardAndListTileLocation({
    this.onTapBox,
    @required this.location,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          MainLineServices(locationID: location.uid).getNameByLocation();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationDetailsList(
                  locationID: location.uid,
                  name: name,
                  locationName: location.name),
            ),
          );
        },
        child: Card(
          child: ListTile(
            onTap: onTapBox,
            title: FutureBuilder<String>(
                future:
                    LocationServices(uid: location.uid).cityName(location.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(" ${location.name}");
                  } else {
                    return Text("");
                  }
                }),
            leading: Image.asset(
              "assets/region50.png",
              width: 30,
            ),
            trailing: Wrap(
              spacing: -15,
              children: <Widget>[],
            ),
          ),
        ));
  }
}

class LocationDetailsList extends StatelessWidget {
  final String name, locationID, locationName;
  LocationDetailsList({this.name, this.locationID, this.locationName});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('$locationName',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          backgroundColor: kAppBarColor,
          centerTitle: true,
        ),
        // body: StreamProvider<List<MainLine>>.value(
        //       value: MainLineServices(locationID: locationID).mainLineByLocationID,
        //       child: LocationDetails(name: name, locationID: locationID),
        //     ),
        drawer: AdminDrawer(name: name),
        body: LocationDetails1(name: name, locationID: locationID),
      ),
    );
  }
}

class LocationDetails1 extends StatefulWidget {
  final String name, locationID;
  LocationDetails1({this.name, this.locationID});

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails1> {
  @override
  Widget build(BuildContext context) {
    List<MainLine> mainlineList;
    List<String> mainlineNameList= [];

 
    // return LocationDetails(mainlineList: mainlineList);

    return 
    
      StreamBuilder<List<MainLine>>(
        stream: MainLineServices().mainLineNameByLocationID(widget.locationID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            mainlineList = snapshot.data;
            int index = 0;
            print(mainlineList);
            for (MainLine s in mainlineList) {
              mainlineNameList.insert(index, s.name);
              index++;
            }
            return  LocationDetails(mainlineNameList: mainlineNameList);
            
            // ReorderableListView(
            //   scrollDirection: Axis.horizontal,
            //   children: <Widget>[
            //     for (final items in mainlineNameList)
            //       Card(
            //         color: Colors.blueGrey,
            //         key: ValueKey(items),
            //         elevation: 2,
            //         child: ListTile(
            //           title: Text(items),
            //           leading: Icon(
            //             Icons.work,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ),
            //   ],
            //   onReorder: reorderData,
            // );
          } else {
            return Container();
          }
        });

    // if (mainLine != []) {
    //   return ListView.builder(
    //       itemCount: mainLine.length,
    //       itemBuilder: (context, index) {
    //         MainLine mainLineItem = mainLine[index];
    //         if (mainLineItem.isArchived == true) {
    //           return Visibility(
    //             child: Text("Gone"),
    //             visible: false,
    //           );
    //         } else {
    //           return Card(
    //             //key: ValueKey(subLineItem.index),
    //             child: ListTile(
    //               title: Text(mainLineItem.name),
    //               leading: Image.asset(
    //                 "assets/region50.png",
    //                 width: 30,
    //               ),
    //               trailing: Wrap(
    //                 spacing: -15,
    //                 children: <Widget>[],
    //               ),
    //             ),
    //           );
    //         }
    //       });
    // } else {
    //   return Center(child: Image.asset("assets/EmptyOrder.png"));
    // }
  }
}