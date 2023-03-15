import 'package:book_list_app/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider<LoginModel>(
    // create: (_) => LoginModel(),
    // child: Scaffold(
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('BookListApp'),
      // ),
      body: Center(
        // child: Consumer<LoginModel>(builder: (context, model, child) {
        // child: Padding(
        // padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: Expanded(
                  child: Container(
                      width: 200,
                      height: 200,
                      child: Image.asset('images/book_mono.png'))),
            ),
            ElevatedButton(onPressed: () {}, child: Text('ログイン')),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(onPressed: () {}, child: Text('新規登録')),
          ],
        ),
        // )
        // }),
      ),
    );
    // );
  }
}
