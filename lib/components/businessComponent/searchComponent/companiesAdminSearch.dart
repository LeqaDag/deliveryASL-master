import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<CloudFirestoreSearch> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (val) => initiateSearch(val),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: name != "" && name != null
              ? FirebaseFirestore.instance
                  .collection('businesss')
                  .where("name", arrayContains: name)
                  .snapshots()
              : FirebaseFirestore.instance.collection("businesss").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new ListTile(
                      title: new Text(document['name']),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }

  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CloudFirestoreSearch extends StatefulWidget {
//   @override
//   _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
// }

// class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
//   String name = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Card(
//           child: TextField(
//             decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search), hintText: 'Search...'),
//             onChanged: (val) {
//               setState(() {
//                 name = val;
//               });
//             },
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: (name != "" && name != null)
//             ? FirebaseFirestore.instance
//                 .collection('businesss')
//                 .where("searchKeywords", arrayContains: name)
//                 .snapshots()
//             : FirebaseFirestore.instance.collection("businesss").snapshots(),
//         builder: (context, snapshot) {
//           return (snapshot.connectionState == ConnectionState.waiting)
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   itemCount: snapshot.data.docs.length,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot data = snapshot.data.docs[index];
//                     return Card(
//                       child: Row(
//                         children: <Widget>[
//                           Text(
//                             data['name'],
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 25,
//                           ),
//                           Text(
//                             data['phoneNumber'],
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//         },
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CloudFirestoreSearch extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _SearchPageState();
//   }
// }

// class _SearchPageState extends State<CloudFirestoreSearch> {
//   var queryResultSet = [];
//   var tempSearchStore = [];

//   initiateSearch(value) {
//     if (value.length == 0) {
//       setState(() {
//         tempSearchStore = []; //comment this if you want to always show.
//       });
//     }

//     var capitalizedValue =
//         value.substring(0, 1).toUpperCase() + value.substring(1);

//     tempSearchStore = [];
//     queryResultSet.forEach((element) {
//       if (element['name'].startsWith(capitalizedValue)) {
//         setState(() {
//           tempSearchStore.add(element);
//         });
//       }
//     });
//   }

//   _getSnapShots() {
//     SearchService().searchByName().map((snapshot) {
//       snapshot.then((QuerySnapshot docs) {
//         for (int i = 0; i < docs.docs.length; ++i) {
//           queryResultSet.add(docs.docs[i].data);
//         }
//       });
//     }).toList();
//   }

//   @override
//   void initState() {
//     _getSnapShots();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: AppBar(
//           title: TextField(
//             autofocus: true,
//             decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: "Search",
//                 hintStyle: TextStyle(
//                     color: Colors.black, fontWeight: FontWeight.bold)),
//             onChanged: (val) {
//               initiateSearch(val.toUpperCase());
//             },
//           ),
//         ),
//         body: ListView(children: <Widget>[
//           SizedBox(height: 10.0),
//           GridView.count(
//               padding: EdgeInsets.only(left: 10.0, right: 10.0),
//               crossAxisCount: 2,
//               crossAxisSpacing: 4.0,
//               mainAxisSpacing: 4.0,
//               primary: false,
//               shrinkWrap: true,
//               children: tempSearchStore.map((element) {
//                 return buildResultCard(element);
//               }).toList())
//         ]));
//   }
// }

// Widget buildResultCard(data) {
//   return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       elevation: 2.0,
//       child: Container(
//           child: Center(
//               child: Text(
//         data['name'],
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 20.0,
//         ),
//       ))));
// }

// class SearchService {
//   List<Future<QuerySnapshot>> searchByName() {
//     return [
//       FirebaseFirestore.instance.collection('businesss').where('name').get(),
//       FirebaseFirestore.instance.collection('customers').where('name').get(),
//     ];
//   }
// }
