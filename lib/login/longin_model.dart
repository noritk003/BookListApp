import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {

  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future signUp() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if (email == null || email == "") {
      throw 'タイトルが入力されていません';
    }
    if (password == null || password!.isEmpty) {
      throw '著者が入力されていません';
    }

    // ログイン
  }
}
