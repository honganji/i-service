import 'package:flutter/material.dart';
import 'package:i_service/routes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.setting);
              },
              child: const Text("move to setting screen"),
            )
          ],
        ),
      ),
    );
  }
}
