// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sajeda_app/components/pages/drawer.dart';
// import 'package:sajeda_app/components/widgetsComponent/AddCompanyCustomWidget.dart';
// import 'package:sajeda_app/components/widgetsComponent/CustomWidgets.dart';

// import '../../constants.dart';

// class AddCompany extends StatefulWidget {
//   final String name;
//   AddCompany({this.name});

//   @override
//   _AddCompanyState createState() => _AddCompanyState();
// }

// class _AddCompanyState extends State<AddCompany> {
//   List<LineChoiceAndPrice> dynamicLineChoiceAndPrice = [];

//   addDynamicLineChoiceAndPrice() {
//     dynamicLineChoiceAndPrice.add(LineChoiceAndPrice());

//     setState(() {
//       // submitData(){
//       //   dynamicLineChoiceAndPrice.forEach((widget) => print(widget.linController.text ));
//       // }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Directionality(
//         textDirection: TextDirection.rtl,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text("اضافة شركة"),
//             centerTitle: true,
//             backgroundColor: kAppBarColor,
//           ),
//           drawer: AdminDrawer(),
//           body: ListView(
//             children: <Widget>[
//               Container(
//                   height: 120, child: Image.asset("assets/AddCompany.png")),
//               CustomBoxSize(height: 0.03),

//               CustomTextFormField(
//                   TextInputType.text, false, "الاسم", Icon(Icons.person)),

//               CustomBoxSize(height: 0.03),

//               CustomTextFormField(TextInputType.emailAddress, false,
//                   "البريد الالكتروني", Icon(Icons.email)),

//               CustomBoxSize(height: 0.03),

//               CustomTextFormField(
//                   TextInputType.phone, false, "رقم الجوال", Icon(Icons.phone)),

//               CustomBoxSize(height: 0.03),

//               CustomTextFormField(TextInputType.visiblePassword, true,
//                   "كلمة المرور", Icon(Icons.lock)),

//               /// Float Button Start

//               // Container(
//               //   // width: 40,
//               //   //   height: 40,
//               //   margin: EdgeInsets.all(5),

//               //   // child: Row(
//               //   //   mainAxisAlignment: MainAxisAlignment.center,
//               //   //   children: [
//               //   //     Expanded(
//               //   //       flex: 1,
//               //   //       child: Container(
//               //   //         margin: EdgeInsets.only(top: 10),
//               //   //         height: 45,
//               //   //         width: 45,
//               //   //         child: FloatingActionButton(
//               //   //           onPressed: () {
//               //   //             addDynamicLineChoiceAndPrice();
//               //   //           },
//               //   //           child: Icon(Icons.add),
//               //   //         ),
//               //   //       ),
//               //   //     ),
//               //   //     Expanded(
//               //   //         flex: 5,
//               //   //         child: _customTitle(" اضافة خط توصيل وسعر التوصيل")),
//               //   //   ],
//               //   // ),
//               // ),

//               // /// Float Button end
//               // LineChoiceAndPrice(),

//               // Flexible(
//               //   child: ListView.builder(
//               //       shrinkWrap: true,
//               //       itemCount: dynamicLineChoiceAndPrice.length,
//               //       itemBuilder: (_, index) =>
//               //           dynamicLineChoiceAndPrice[index]),
//               // ),

//               // CustomBoxSize(height: 0.03),

//               CustomBoxSize(height: 0.03),

//               Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 90),
//                   child: Container(
//                     margin: EdgeInsets.all(40.0),
//                     child: RaisedButton(
//                       padding: EdgeInsets.all(10.0),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(30.0)),
//                       onPressed: () {
//                         // _addDriver();
//                       },
//                       color: Color(0xff73a16a),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                             'إضافة',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Amiri',
//                                 fontSize: 24.0),
//                           ),
//                           SizedBox(
//                             width: 35.0,
//                           ),
//                           Icon(
//                             Icons.add_circle,
//                             color: Colors.white,
//                             size: 32.0,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )),

//               /// flat Add button

//               CustomBoxSize(height: 0.03),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _customTitle(String title) {
//   return Container(
//     margin: EdgeInsets.only(left: 10, top: 10),
//     width: double.infinity,
//     height: 40,
//     child: Center(
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 18,
//           fontFamily: "Amiri",
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ),
//   );
// }
