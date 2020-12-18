import 'package:AsyadLogistic/classes/mainLine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationDetails extends StatefulWidget {
  final List<String> mainlineNameList;
  LocationDetails({this.mainlineNameList});


  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = widget.mainlineNameList.removeAt(oldindex);
      widget.mainlineNameList.insert(newindex, items);
    });
  }

  void sorting() {
    setState(() {
      widget.mainlineNameList.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (final items in widget.mainlineNameList)
            Card(
              color: Colors.blueGrey,
              key: ValueKey(items),
              elevation: 2,
              child: ListTile(
                title: Text(items),
                leading: Icon(
                  Icons.work,
                  color: Colors.black,
                ),
              ),
            ),
        ],
        onReorder: reorderData,
      );
    
  }
}

// class LocationDetails2 extends StatefulWidget {
//   final List<String> mainlineList;
//   LocationDetails2({this.mainlineList});

//   @override
//   _LocationDetails2State createState() => _LocationDetails2State();
// }

// class _LocationDetails2State extends State<LocationDetails2> {
//   void reorderData(int oldindex, int newindex) {
//     setState(() {
//       if (newindex > oldindex) {
//         newindex -= 1;
//       }
//       final items = widget.mainlineList.removeAt(oldindex);
//       widget.mainlineList.insert(newindex, items);
//     });
//   }

//   void sorting() {
//     setState(() {
//       widget.mainlineList.sort();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(widget.mainlineList);
//     if (widget.mainlineList == []) {
//       return Visibility(
//         child: Text("Gone"),
//         visible: false,
//       );
//     } else {
//       return
//        ReorderableListView(
//         scrollDirection: Axis.horizontal,
//         children: <Widget>[
//           for (final items in widget.mainlineList)
//             Card(
//               color: Colors.blueGrey,
//               key: ValueKey(items),
//               elevation: 2,
//               child: ListTile(
//                 title: Text(items),
//                 leading: Icon(
//                   Icons.work,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//         ],
//         onReorder: reorderData,
//       );
//     }

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
