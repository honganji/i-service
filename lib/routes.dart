import 'package:flutter/widgets.dart';
import 'package:i_service/screens/home.dart';
import 'package:i_service/screens/login.dart';
import 'package:i_service/screens/register.dart';
import 'package:i_service/wrapper.dart';

class Routes {
  static const String start = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';

  static final routes = <String, WidgetBuilder>{
    start: (BuildContext context) => const Wrapper(),
    login: (BuildContext context) => const Login(),
    home: (BuildContext context) => const Home(),
    register: (BuildContext context) => const Registar(),
  };
}
