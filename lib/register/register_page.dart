import 'package:book_list_app/register/register_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
          backgroundColor: Color(0xff009944),
        ),
        body: Center(
          child: Consumer<RegisterModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: model.titleController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                        onChanged: (text) {
                          model.setEmail(text);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: model.authorController,
                        decoration: InputDecoration(
                          hintText: 'パスワード',
                        ),
                        onChanged: (text) {
                          model.setPassword(text);
                        },
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          model.startLoading();
                          // ユーザー追加の処理
                          try {
                            await model.signUp();
                            Navigator.of(context).pop();
                          } on FirebaseAuthException catch (e) {
                            String errorMessage = '';
                            if (e.code == 'weak-password') {
                              errorMessage = 'パスワードを６文字以上入力してください。';
                            } else if (e.code == 'invalid-email') {
                              errorMessage = 'メールアドレスを入力してください。';
                            } else if (e.code == 'email-already-in-use') {
                              errorMessage = 'そのメールアドレスは既に登録済みです。';
                            } else {
                              errorMessage = '入力にエラーが見つかりました。';
                            }
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(errorMessage),
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
                        child: Text('登録する'),
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
