import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/model/toggle_model.dart';
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
    final TextEditingController nameController = TextEditingController();
    final TextEditingController imgUrlController = TextEditingController();

    final authProvider = Provider.of<AuthProvider>(context);
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    UserModel? user = Provider.of<UserModel>(context);
    ToggleState toggleState = Provider.of<ToggleState>(context);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do you wanna sign up?"),
                Switch(
                    activeColor: Colors.amber,
                    activeTrackColor: HexColor("#1F9478"),
                    inactiveThumbColor: Colors.blueGrey.shade600,
                    inactiveTrackColor: Colors.grey.shade400,
                    splashRadius: 50.0,
                    value: toggleState.isSignUp,
                    onChanged: (bool? value) {
                      toggleState.reverseIsSignup();
                    }),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do you wanna use company account?"),
                Switch(
                    activeColor: Colors.amber,
                    activeTrackColor: HexColor("#1F9478"),
                    inactiveThumbColor: Colors.blueGrey.shade600,
                    inactiveTrackColor: Colors.grey.shade400,
                    splashRadius: 50.0,
                    value: toggleState.isCompany,
                    onChanged: (bool? value) {
                      toggleState.reverseIsCompany();
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                  ),
                  Visibility(
                    visible: toggleState.isSignUp,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                        ),
                        validator: (value) {
                          if ((value == null) & toggleState.isSignUp)
                            return "Please enter some text";
                          return null;
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: toggleState.isCompany & toggleState.isSignUp,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: TextFormField(
                        controller: imgUrlController,
                        decoration: const InputDecoration(
                          labelText: "Image Url",
                        ),
                        validator: (value) {
                          if ((value == null) &
                              toggleState.isCompany &
                              toggleState.isSignUp) {
                            return "Please enter some text";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !(toggleState.isSignUp),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                                if (toggleState.isCompany) {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.business);
                                }

                                if (toggleState.isCompany == false) {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.wrapper);
                                }
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
                            }
                          },
                          child: const Text("Login"),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: toggleState.isSignUp,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                              user.setUid(userId);
                              await dataProvider.createAccount(
                                  userId,
                                  nameController.text,
                                  imgUrlController.text,
                                  toggleState.isCompany);
                              authProvider.status = AuthStatus.authorized;
                              user.setUid(userId);
                              Fluttertoast.showToast(
                                  msg: "Sign up is done!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: e.toString(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: const Text("Sign up"),
                        ),
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
