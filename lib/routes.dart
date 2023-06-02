import 'package:flutter/widgets.dart';
import 'package:i_service/wrapper.dart';
import 'package:i_service/screens/login.dart';
import 'package:i_service/screens/start.dart';

class Routes {
  static const String start = '/';
  static const String login = '/login';
  static const String wrapper = '/wrapper';

  static final routes = <String, WidgetBuilder>{
    start: (BuildContext context) => const Start(),
    login: (BuildContext context) => const Login(),
    wrapper: (BuildContext context) => Wrapper(),
  };
}
