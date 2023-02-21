import 'package:book_list_app/add_book/add_book_page.dart';
import 'package:book_list_app/book_list/book_list_model.dart';
import 'package:book_list_app/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../edit_book/edit_book_page.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => Slidable(
                    child: ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                    // key: const ValueKey(0),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          // flex: 2,
                          backgroundColor: Colors.black45,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: '編集',
                          onPressed: (BuildContext) async {
                            // 編集画面に遷移

                            // 画面遷移
                            final String? title = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookPage(book),
                              ),
                            );

                            if (title != null) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('$titleを編集しました'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                            model.fetchBookList();
                          },
                        ),
                        SlidableAction(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: '削除',
                          onPressed: (BuildContext) {
                            // 削除しますか？ポップ表示
                          },
                        ),
                      ],
                    ),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              // 画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('本を追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchBookList();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
