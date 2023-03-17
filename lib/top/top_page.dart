import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login/login_page.dart';
import '../register/register_page.dart';

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
              padding: const EdgeInsets.only(top: 200, bottom: 30),
              child: Text(
                'BookListApp',
                style: TextStyle(fontSize: 36),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Expanded(
                  child: Container(
                      width: 300,
                      height: 300,
                      child: Image.asset('images/book_yellow_bg_clear.png'))),
            ),
            ElevatedButton(
                onPressed: () async {
                  // ログイン画面へ遷移
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green[700]),
                ),
                child: Text(
                  'ログイン',
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(
              height: 8,
            ),
            TextButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Text('新規登録の方はこちら')),
          ],
        ),
        // )
        // }),
      ),
    );
    // );
  }
}
