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
      appBar: AppBar(
        title: Text('BookListApp'),
      ),
      body: Center(
          // child: Consumer<LoginModel>(builder: (context, model, child) {
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: Text('ログインする')),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(onPressed: () {}, child: Text('ログインする')),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                // model.startLoading();
                // try {
                //   await model.login();
                //   Navigator.of(context).pop();
                // } catch (e) {
                //   final snackBar = SnackBar(
                //     backgroundColor: Colors.red,
                //     content: Text(e.toString()),
                //   );
                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                // } finally {
                //   model.endLoading();
                // }
              },
              child: Text('ログインする'),
            ),
          ],
        ),
      )
          // }),
          ),
    );
    // );
  }
}
