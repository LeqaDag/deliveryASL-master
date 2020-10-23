import 'package:flutter/material.dart';

import 'orderInformationComponent/cancelInfo.dart';
import 'orderInformationComponent/deliveryInfo.dart';
import 'orderInformationComponent/doneInfo.dart';
import 'orderInformationComponent/loadingInfo.dart';
import 'orderInformationComponent/receivedInfo.dart';
import 'orderInformationComponent/returnInfo.dart';
import 'orderInformationComponent/urgentInfo.dart';

class OrganizeOrderInfo extends StatelessWidget {
  final String uid;
  final String orderState;
  OrganizeOrderInfo({this.uid, this.orderState});
  @override
  Widget build(BuildContext context) {
    switch (orderState) {
      case 'isLoading':
        {
          return LoadingInfo(uid: uid);
        }
        break;
      case 'isReceived':
        {
          return ReceivedInfo(uid: uid);
        }
        break;
      case 'isUrgent':
        {
          return UrgentInfo(uid: uid);
        }
        break;
      case 'isCancelld':
        {
          return CancelldInfo(uid: uid);
        }
        break;

      case 'isDelivery':
        {
          return DeliveryInfo(uid: uid);
        }
        break;
      case 'isDone':
        {
          return DoneInfo(uid: uid);
        }
        break;
      case 'isReturn':
        {
          return ReturnInfo(uid: uid);
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
