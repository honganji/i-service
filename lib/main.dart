import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i_service/constants/theme.dart';
import 'package:i_service/model/bottom_nav_bar_model.dart';
import 'package:i_service/model/toggle_model.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/providers/data_provider.dart';
import 'package:i_service/routes.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<BottomNavBarModel>(
          create: (_) => BottomNavBarModel(),
        ),
        ChangeNotifierProvider<DataProvider>(
          create: (_) => DataProvider(),
        ),
        ChangeNotifierProvider<UserModel>(
          create: (_) => UserModel(),
        ),
        ChangeNotifierProvider<ToggleState>(
          create: (_) => ToggleState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        initialRoute: Routes.start,
        routes: Routes.routes,
      ),
    );
  }
}
