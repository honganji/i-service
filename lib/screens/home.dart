import 'package:flutter/material.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/routes.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await authProvider.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, Routes.start);
                }
              },
              child: const Text("Sign Out!"),
            )
          ],
        ),
      ),
    );
  }
}
