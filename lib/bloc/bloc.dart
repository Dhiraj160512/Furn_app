import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class GlobalBloc {
  Future<QuerySnapshot> loginUser(String mobile, String pass) async {
    EasyLoading.show(dismissOnTap: false);
    try {
      CollectionReference user = FirebaseFirestore.instance.collection('users');

      QuerySnapshot result = await user
          .where("phone", isEqualTo: mobile)
          .where("password", isEqualTo: pass)
          .get();

      if (result.docs.isNotEmpty) {
        EasyLoading.dismiss();
        return result;
      } else {
        EasyLoading.dismiss();
        return result;
      }
    } catch (e) {
      log('Something Went Wrong:$e');
      throw "Something went wrong :$e";
    }
  }
}

GlobalBloc globalBloc = GlobalBloc();
