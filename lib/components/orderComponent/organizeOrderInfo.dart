import 'package:flutter/material.dart';

import 'orderInformationComponent/cancelInfo.dart';
import 'orderInformationComponent/deliveryInfo.dart';
import 'orderInformationComponent/doneInfo.dart';
import 'orderInformationComponent/loadingInfo.dart';
import 'orderInformationComponent/receivedInfo.dart';
import 'orderInformationComponent/returnInfo.dart';
import 'orderInformationComponent/urgentInfo.dart';

class OrganizeOrderInfo extends StatelessWidget {
  final String uid, name;
  final String orderState;
  OrganizeOrderInfo({this.uid, this.orderState, this.name});

  @override
  Widget build(BuildContext context) {
    switch (orderState) {
      case 'inStock':
        {
          return LoadingInfo(uid: uid, name: name);
        }
        break;

      case 'isLoading':
        {
          return LoadingInfo(uid: uid, name: name);
        }
        break;
      case 'isReceived':
        {
          return ReceivedInfo(uid: uid, name: name);
        }
        break;
      case 'isUrgent':
        {
          return UrgentInfo(uid: uid, name: name);
        }
        break;
      case 'isCancelld':
        {
          return CancelldInfo(uid: uid, name: name);
        }
        break;

      case 'isDelivery':
        {
          return DeliveryInfo(uid: uid, name: name);
        }
        break;
      case 'isDone':
        {
          return DoneInfo(uid: uid, name: name);
        }
        break;
      case 'isReturn':
        {
          return ReturnInfo(uid: uid, name: name);
        }
        break;
      default:
        {
          return null;
        }
        break;
    }
  }
}
