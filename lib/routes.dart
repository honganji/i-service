import 'package:flutter/widgets.dart';
import 'package:i_service/screens/customer_individual.dart';
import 'package:i_service/screens/user_list.dart';
import 'package:i_service/wrapper.dart';
import 'package:i_service/screens/login.dart';
import 'package:i_service/screens/start.dart';

class Routes {
  static const String start = '/';
  static const String login = '/login';
  static const String wrapper = '/wrapper';
  static const String business = '/business';
  static const String individual = '/individual';

  static final routes = <String, WidgetBuilder>{
    start: (BuildContext context) => const Start(),
    login: (BuildContext context) => const Login(),
    wrapper: (BuildContext context) => Wrapper(),
    business: (BuildContext context) => const UserList(),
    individual: (BuildContext context) => const Individual(),
  };
}
