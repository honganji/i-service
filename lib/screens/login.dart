import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/constants/routes.dart';
import 'package:i_service/widgets/title.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: HexColor("#1F9478"),
          ),
          child: const HomeTitle(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Password"),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await authProvider.signInWithEmailAndPassword(
              emailController.text,
              passwordController.text,
            );
          },
          child: const Text("Login"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.register);
          },
          child: const Text("Sign up"),
        )
      ],
    );
  }
}
