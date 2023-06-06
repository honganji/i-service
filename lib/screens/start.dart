import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/model/toggle_model.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/screens/user_list.dart';
import 'package:i_service/wrapper.dart';
import 'package:i_service/screens/login.dart';
import 'package:i_service/widgets/title.dart';
import 'package:provider/provider.dart';

// screen to distinguish authentication state
class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    UserModel user = Provider.of<UserModel>(context);
    ToggleState toggleState = Provider.of<ToggleState>(context);
    return StreamBuilder<UserModel?>(
        stream: authProvider.user,
        builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print(authProvider.status);
            if ((snapshot.data != null) &
                (authProvider.status == AuthStatus.authorized)) {
              user.uid = snapshot.data!.uid.toString();
              if (toggleState.isCompany) return const UserList();
              return Wrapper();
            }
            return const Login();
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
