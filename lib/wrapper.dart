import 'package:flutter/material.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/screens/home.dart';
import 'package:i_service/screens/login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return StreamBuilder<UserModel?>(
        stream: authProvider.user,
        builder: (_, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final UserModel? user = snapshot.data;
            return user == null ? const Login() : const Home();
          } else {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}
