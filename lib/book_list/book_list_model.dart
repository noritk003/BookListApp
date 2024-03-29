import 'package:book_list_app/login/longin_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../domain/book.dart';

class BookListModel extends ChangeNotifier {
  List<Book>? books;

  String id = '';
  String title = '';
  String author = '';
  String? imgURL;
  String? uid;

  void fetchBookList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('books').get();
    String? uid = LoginModel().uid;

    List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String author = data['author'];
      final String? imgURL = data['imgURL'];
      this.uid = data['uid'];
      return Book(id, title, author, imgURL, this.uid!);
    }).toList();

    books.removeWhere((book) => book.uid != uid);
    this.books = books;
    notifyListeners();
  }

  // 本の削除
  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }

  // ログアウト
  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
