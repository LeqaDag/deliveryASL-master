import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:AsyadLogistic/components/adminComponent/admin_secretary_home.dart';
import 'package:AsyadLogistic/components/businessComponent/businesssComponent/business_admin.dart';
import 'package:AsyadLogistic/components/cityComponent/city_admin.dart';
import 'package:AsyadLogistic/components/driverComponent/driversComponent/driveradmin.dart';
import 'package:AsyadLogistic/components/invoiceComponent/invoice_admin.dart';
import 'package:AsyadLogistic/components/pages/drawer.dart';
import 'package:AsyadLogistic/components/widgetsComponent/CustomWidgets.dart';
import 'package:AsyadLogistic/components/lineComponent/all_lines.dart';
import '../../constants.dart';
import 'admin_orders.dart';

class AdminHome extends StatelessWidget {
  final String name;
  final bool type;
  AdminHome({this.name, this.type});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    print(user.uid);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: AdminDrawer(name: name),
        appBar: AppBar(
          title: Text(name,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Amiri',
              )),
          centerTitle: true,
          backgroundColor: kAppBarColor,
        ),
        body: Stack(
          children: <Widget>[
            Container(
                width: width,
                height: height * 0.16859,
                //color: Color(0xff9DB9CB),

                child: Center(
                    child: Image.asset(
                  "assets/delivery_master_blue.png",
                  width: width,
                  fit: BoxFit.fill,
                ))),
            Center(
              child: Container(
                  width: width * 0.8,
                  height: height * 0.7,
                  margin: EdgeInsets.only(top: height * 0.07),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(style: BorderStyle.solid, width: 1),
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: [
                      BoxShadow(color: Colors.black54, spreadRadius: 1.5),
                    ],
                  ),
                  child: ListView(
                    children: <Widget>[
                      CustomBoxSize(height: 0.05),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CustomContainer(
                                  width: 0.28,
                                  height: 0.15,
                                  imagepath: AssetImage(
                                      "assets/CompanysAndStores.png"),
                                  text: "الشركات",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BusinessAdmin(name: name)),
                                    );
                                  }),
                              CustomContainer(
                                  width: 0.28,
                                  height: 0.15,
                                  imagepath: AssetImage("assets/OrdersBox.png"),
                                  text: "الطرود",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminOrders(name: name)),
                                    );
                                  }),
                            ],
                          ),
                          CustomBoxSize(height: 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CustomContainer(
                                  width: 0.28,
                                  height: 0.15,
                                  imagepath: AssetImage("assets/Driver.png"),
                                  text: "السائقون",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DriverAdmin(name: name)),
                                    );
                                  }),
                              CustomContainer(
                                  width: 0.28,
                                  height: 0.15,
                                  imagepath:
                                      AssetImage("assets/DeliveryLine.png"),
                                  text: "خطوط التوصيل",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AllLines(name: name)),
                                    );
                                  }),
                            ],
                          ),
                          CustomBoxSize(height: 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CustomContainer(
                                  width: 0.28,
                                  height: 0.15,
                                  imagepath:
                                      AssetImage("assets/Accounting.png"),
                                  text: "الحسابات المالية",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InvoiceAdmin(name: name)),
                                    );
                                  }),
                              CustomContainer(
                                  width: 0.28,
                                  height: 0.15,
                                  imagepath: AssetImage("assets/admin.png"),
                                  text: " العاملين",
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminSecretaryHome(name: name)),
                                    );
                                  }),
                            ],
                          ),
                          CustomBoxSize(height: 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 21, bottom: 20),
                                child: CustomContainer(
                                    width: 0.28,
                                    height: 0.15,
                                    imagepath:
                                        AssetImage("assets/city-100.png"),
                                    text: "المدن",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminCitiesHome(name: name)),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

/*class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //var x = width*0.4;

    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text("name ",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Amiri',
            )),
        centerTitle: true,
        backgroundColor: kAppBarColor,
      ),
      body: Stack(
        children: <Widget>[
          Container(
              width: width,
              height: height * 0.2,
              //color: Color(0xff9DB9CB),

              child: Center(
                  child: Image.asset(
                    "assets/delivery_master_blue.png",
                    width: width,
                    fit: BoxFit.fill,
                  ))),
          Center(
            child: Container(
                width: width * 0.8,
                height: height * 0.7,
                margin: EdgeInsets.only(top: height * 0.07),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(style: BorderStyle.solid, width: 1),
                  borderRadius: BorderRadius.circular(23),
                  boxShadow: [
                    BoxShadow(color: Colors.black54, spreadRadius: 1.5),
                  ],
                ),
                child: ListView(
                  children: <Widget>[
                    CustomBoxSize(height: 0.05),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CustomContainer(
                                width: 0.28,
                                height: 0.15,
                                imagepath:
                                AssetImage("assets/CompanysAndStores.png"),
                                text: "الشركات",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            StoreAndBusiness()),
                                  );
                                }),
                            CustomContainer(
                                width: 0.28,
                                height: 0.15,
                                imagepath: AssetImage("assets/OrdersBox.png"),
                                text: "الطرود",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminOrders()),
                                  );
                                }),
                          ],
                        ),
                        CustomBoxSize(height: 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CustomContainer(
                                width: 0.28,
                                height: 0.15,
                                imagepath: AssetImage("assets/Driver.png"),
                                text: "السائقون",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DriverAdmin()),
                                  );
                                }),
                            CustomContainer(
                                width: 0.28,
                                height: 0.15,
                                imagepath:
                                AssetImage("assets/DeliveryLine.png"),
                                text: "خطوط التوصيل",
                                onTap: () {
                                  //type your code here 4
                                }),
                          ],
                        ),
                        CustomBoxSize(height: 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: CustomContainer(
                                  width: 0.28,
                                  height: 0.15,
                                  imagepath:
                                  AssetImage("assets/Accounting.png"),
                                  text: "الحسابات المالية",
                                  onTap: () {
                                    //type your code here 5
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}*/
