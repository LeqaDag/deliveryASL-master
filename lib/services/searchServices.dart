import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchServices extends GetxController {
  CollectionReference adminCollection =
      FirebaseFirestore.instance.collection('admin');
}
