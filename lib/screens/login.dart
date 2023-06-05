import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/providers/data_provider.dart';
import 'package:i_service/routes.dart';
import 'package:i_service/widgets/title.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authProvider = Provider.of<AuthProvider>(context);
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    UserModel? user = Provider.of<UserModel>(context);

    return Material(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor("#1F9478"),
                ),
                child: const HomeTitle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: SizedBox(
                      height: 70,
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await authProvider.signInWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                            final userId = await authProvider.getUserId();
                            user.setUid(userId);
                            if (context.mounted) {
                              print(user.uid ?? "");
                              Navigator.pushReplacementNamed(
                                  context, Routes.wrapper);
                            }
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: e.toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            print(e);
                          }
                        },
                        child: const Text("Login"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: SizedBox(
                      height: 70,
                      width: 220,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await authProvider.createWiehEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                            final userId = await authProvider.getUserId();
                            print(userId);
                            user.setUid(userId);
                            await dataProvider.createAnswer(userId);
                            await dataProvider.createChecked(userId);
                            Future.delayed(const Duration(seconds: 7));
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(
                                  context, Routes.wrapper);
                            }
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: e.toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            print(e);
                          }
                        },
                        child: const Text("Sign up"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
