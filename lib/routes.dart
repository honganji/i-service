import 'package:flutter/widgets.dart';
import 'package:i_service/screens/home.dart';
import 'package:i_service/screens/login.dart';
import 'package:i_service/screens/start.dart';

class Routes {
  static const String start = '/ded';
  static const String login = '/login';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    start: (BuildContext context) => const Start(),
    login: (BuildContext context) => const Login(),
    home: (BuildContext context) => const Home(),
  };
}
