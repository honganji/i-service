import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/routes.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final double height = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        backgroundColor: HexColor("#1F9478"),
        elevation: 10,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.1,
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
          )
        ],
      ),
    );
  }
}
