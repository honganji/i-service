import 'package:flutter/material.dart';
import 'package:i_service/model/bottom_nav_bar_model.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/routes.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final authProvider = Provider.of<AuthProvider>(context);
    BottomNavBarModel bottomNavBarModel =
        Provider.of<BottomNavBarModel>(context);
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
            ),
            SizedBox(
              height: 70,
              width: 320,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                onPressed: () async {
                  await authProvider.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, Routes.start);
                  }
                },
                child: const Text(
                  "Change Password",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        SizedBox(
          height: 70,
          width: 320,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
            ),
            onPressed: () async {
              await authProvider.signOut();
              if (context.mounted) {
                bottomNavBarModel.currentIndex = 0;
                Navigator.pushReplacementNamed(context, Routes.start);
              }
            },
            child: const Text(
              "Sign Out",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
        ),
        const Flexible(
          child: FractionallySizedBox(
            heightFactor: 10,
          ),
        ),
      ],
    );
  }
}
