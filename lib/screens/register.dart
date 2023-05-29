import 'package:flutter/material.dart';

class Registar extends StatelessWidget {
  const Registar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(onPressed: () {}, child: const Text("Sign Up")),
          ],
        ));
  }
}
