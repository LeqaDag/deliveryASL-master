import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AsyadLogistic/classes/subLine.dart';
import 'package:AsyadLogistic/components/lineComponent/subLineComponent/updateSubLine.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:AsyadLogistic/services/subLineServices.dart';

class SubLineList extends StatefulWidget {
  final String name, mainLineID;

  SubLineList({this.name, this.mainLineID});

  @override
  _SubLineListState createState() => _SubLineListState();
}

class _SubLineListState extends State<SubLineList> {
  @override
  Widget build(BuildContext context) {
    final subLine = Provider.of<List<SubLine>>(context) ?? [];
    if (subLine == null) {
      return Visibility(
        child: Text("Gone"),
        visible: false,
      );
    } else {
      subLine.toList();
    }
    if (subLine == [] ) {
      return Visibility(
        child: Text("Gone"),
        visible: false,
      );
    } else {
      return ListView.builder(
          itemCount: subLine.length,
          itemBuilder: (context, index) {
            SubLine subLineItem = subLine[index];

            return Card(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.green[800],
                              size: 25.0,
                            ),
                          ),
                          // Container(
                          //   margin: const EdgeInsets.all(10.0),
                          //   padding: const EdgeInsets.all(3.0),
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey)),
                          //   child: Text(
                          //     '${subLineItem.indexLine}',
                          //     style: TextStyle(
                          //         fontFamily: 'Amiri', fontSize: 18.0),
                          //   ),
                          // ),
                          Expanded(
                            child: Text(
                              '${subLineItem.name}',
                              style: TextStyle(
                                  fontFamily: 'Amiri', fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateSubLine(
                                        subLineID: subLineItem.uid,
                                        name: widget.name)),
                              );
                            },
                            icon: Icon(
                              Icons.create,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                        title: "حذف خط فرعي",
                                        description: ' هل ترغب بحذف خط فرعي',
                                        name: subLineItem.name,
                                        buttonText: "تأكيد",
                                        onPressed: () {
                                          SubLineServices().deletesubLineData(
                                              subLineItem.uid);
                                          Navigator.of(context).pop();
                                        },
                                        cancelButton: "الغاء",
                                        cancelPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ));
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}
