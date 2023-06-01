import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/screens/home.dart';
import 'package:i_service/screens/login.dart';
import 'package:i_service/widgets/title.dart';
import 'package:provider/provider.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return StreamBuilder<UserModel?>(
        stream: authProvider.user,
        builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final UserModel? user = snapshot.data;
            return user == null ? const Login() : const Home();
          } else {
            return Scaffold(
              backgroundColor: HexColor("#1F9478"),
              body: const FractionallySizedBox(
                widthFactor: 100,
                heightFactor: 100,
                child: Column(
                  children: [
                    HomeTitle(),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
        });
  }
}
