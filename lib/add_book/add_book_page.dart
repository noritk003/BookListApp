import 'package:book_list_app/add_book/add_book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本を追加'),
          backgroundColor: Color(0xff009944),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: SizedBox(
                          width: 100,
                          height: 160,
                          child: model.imageFile != null
                              ? Image.file(model.imageFile!)
                              : Container(
                                  color: Colors.grey,
                                ),
                        ),
                        onTap: () async {
                          await model.pickImage();
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'タイトル',
                        ),
                        onChanged: (text) {
                          model.title = text;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '著者',
                        ),
                        onChanged: (text) {
                          model.author = text;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // DB追加の処理
                          try {
                            model.startLoading();
                            await model.addBook();
                            Navigator.of(context).pop(true);
                          } catch (e) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } finally {
                            model.endLoading();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[600]),
                        ),
                        child: Text('追加する'),
                      )
                    ],
                  ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
