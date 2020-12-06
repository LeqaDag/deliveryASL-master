import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'orderInformationComponent/cancelInfo.dart';
import 'orderInformationComponent/deliveryInfo.dart';
import 'orderInformationComponent/doneInfo.dart';
import 'orderInformationComponent/loadingInfo.dart';
import 'orderInformationComponent/receivedInfo.dart';
import 'orderInformationComponent/returnInfo.dart';
import 'orderInformationComponent/urgentInfo.dart';

class OrganizeOrderInfo extends StatefulWidget {
  final String uid, name;
  final String orderState;
  OrganizeOrderInfo({this.uid, this.orderState, this.name});

  @override
  _OrganizeOrderInfoState createState() => _OrganizeOrderInfoState();
}

class _OrganizeOrderInfoState extends State<OrganizeOrderInfo> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      switch (widget.orderState) {
        case 'isLoading':
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoadingInfo(uid: widget.uid, name: widget.name)),
            );
          }
          break;
        case 'isReceived':
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceivedInfo(uid: widget.uid, name: widget.name)),
            );
          }
          break;
        case 'isUrgent':
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UrgentInfo(uid: widget.uid, name: widget.name)),
            );
          }
          break;
        case 'isCancelld':
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CancelldInfo(uid: widget.uid, name: widget.name)),
            );
          }
          break;

        case 'isDelivery':
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DeliveryInfo(uid: widget.uid, name: widget.name)),
            );
          }
          break;
        case 'isDone':
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DoneInfo(uid: widget.uid, name: widget.name)),
            );
          }
          break;
        case 'isReturn':
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReturnInfo(uid: widget.uid, name: widget.name)),
            );
          }
          break;
        default:
          {
            return Container();
          }
          break;
      }
    });

    return Scaffold(
      backgroundColor: Color(0xff316686),
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 70.0,
        ),
      ),
    );
  }
}
