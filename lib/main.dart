import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 作成したドキュメント一覧
  List<DocumentSnapshot> documentList = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference person = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      //Fetching data from the documentId specified of the person
      future: person.doc("7DfERcoaoKYhPl4h2K6V").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Text("Full Name: ${data['name']} ${data['age']}"),
              ElevatedButton(
                onPressed: () async {
                  person.add({"name": "yamada", "age": 26});
                },
                child: const Text("add user info"),
              ),
              ElevatedButton(
                onPressed: () async {
                  person
                      .doc("7DfERcoaoKYhPl4h2K6V")
                      .set({"name": "Kanna-chan", "age": 39});
                },
                child: const Text("fix user info"),
              ),
              ElevatedButton(
                onPressed: () async {
                  person.doc("xXQeti1cIzREhNCAKZ65").delete();
                },
                child: const Text("delete user info"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                child: const Text("move to login screen"),
              ),
            ],
          );
        }

        return const Text("loading");
      },
    );
  }
}
