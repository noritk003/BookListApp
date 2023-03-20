import 'dart:io';

import 'package:book_list_app/domain/user.dart';
import 'package:book_list_app/login/longin_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  // AddBookModel(this.uid);

  String? title;
  String? author;
  File? imageFile;
  String? uid;

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  // 本を追加
  Future addBook() async {
    if (title == null || title == "") {
      throw 'タイトルが入力されていません';
    }

    if (author == null || author!.isEmpty) {
      throw '著者が入力されていません';
    }

    final doc = FirebaseFirestore.instance.collection('books').doc();
    String? imgURL;
    // storageに画像をアップロード
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('uploads/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    uid = 'a';

    // uid取得
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    final List<MyUser> users = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String uid = data['uid'];
      return MyUser(uid);
    }).toList();

    uid = FirebaseAuth.instance.currentUser!.uid;

    // firestoreに追加
    await doc.set({
      'title': title,
      'author': author,
      'imgURL': imgURL,
      'uid': uid,
    });
  }

  // 画像を追加
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    notifyListeners();
  }
}
