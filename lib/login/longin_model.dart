import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  bool isLoading = false;

  static String EmailNotRegistError =
      '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.';
  // static String DifferentEmailFormatError = '[firebase_auth/invalid-email] The email address is badly formatted.';
  static String DifferentEmailFormatError =
      'The email address is badly formatted.';
  static String DifferentPasswordError =
      '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.';

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

  Future login() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if (email == null || email == "") {
      throw 'メールアドレスが入力されていません';
    }
    if (password == null || password!.isEmpty) {
      throw 'パスワードが入力されていません';
    }

    // ログイン
    if (email != null && password != null) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
    }
  }
}
