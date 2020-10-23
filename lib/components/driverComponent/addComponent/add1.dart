import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DropdownButtonFormFieldExample extends StatefulWidget {
  final String name;
  DropdownButtonFormFieldExample({this.name});
  @override
  _DropdownButtonFormFieldExampleState createState() =>
      _DropdownButtonFormFieldExampleState();
}

class _DropdownButtonFormFieldExampleState
    extends State<DropdownButtonFormFieldExample> {
  final updateFormKey = GlobalKey<FormState>();
  DocumentSnapshot currentCategory;
  TextEditingController categoryController = new TextEditingController();
  String categoryname = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Button'),
      ),
      body: Container(
        child: Form(
          key: updateFormKey,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('citys')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          } else {
                            if (!snapshot.hasData) {
                              return Text('Loading...');
                            }

                            //currentCategory = snapshot.data.docs[0];
                            return Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: new BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              child: DropdownMenuItem(
                                child: new DropdownButtonFormField<
                                    DocumentSnapshot>(
                                  value: currentCategory,

                                  // value: currentCategory,

                                  onChanged: (DocumentSnapshot newValue) {
                                    setState(() {
                                      currentCategory = newValue;
                                      categoryname =
                                          currentCategory.data()['name'];
                                    });
                                    print(currentCategory.data()['name']);
                                  },

                                  onSaved: (DocumentSnapshot newValue) {
                                    setState(() {
                                      currentCategory = newValue;
                                    });
                                    print(currentCategory.data);
                                  },
                                  hint: Text('Select Category'),
                                  items: snapshot.data.docs
                                      .map((DocumentSnapshot document) {
                                    return new DropdownMenuItem<
                                            DocumentSnapshot>(
                                        value: currentCategory,
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      5.0)),
                                          height: 100.0,
                                          padding: EdgeInsets.fromLTRB(
                                              2.0, 2.0, 2.0, 0.0),
                                          //color: primaryColor,
                                          child: new Text(
                                            document.data()['name'] ?? "",
                                          ),
                                        ));
                                  }).toList(),
                                ),
                              ),
                            );
                          }
                        }),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    TextFormField(
                      controller: categoryController,
                      decoration: InputDecoration(
                          labelText: 'Category Name', filled: true),
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Category name can not be empty';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (input) {
                        categoryname = input;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
