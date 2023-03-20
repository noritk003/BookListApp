import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;
  String? uid = FirebaseAuth.instance.currentUser!.uid;

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  // String? getUid() {
  //   return uid;
  // }

  Future login() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if (email == null || email == "") {
      throw 'タイトルが入力されていません';
    }
    if (password == null || password!.isEmpty) {
      throw '著者が入力されていません';
    }

    // ログイン
    if (email != null && password != null) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      // final currentUser = FirebaseAuth.instance.currentUser;
      // uid = currentUser!.uid;
      // return uid;
    }
  }
}
