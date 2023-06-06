import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/model/bottom_nav_bar_model.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/routes.dart';
import 'package:i_service/screens/company.dart';
import 'package:i_service/screens/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  // list of pages
  final List<Widget> pageList = <Widget>[
    const Home(),
    const Company(),
  ];

  // list of page names
  final List<String> pageNameList = <String>["Home", "Permission"];

  // list of icon
  final tabItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.check),
      label: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavBarModel bottomNavBarModel =
        Provider.of<BottomNavBarModel>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pageNameList[bottomNavBarModel.currentIndex],
          style: const TextStyle(fontSize: 30),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
            ),
            onPressed: () async {
              await authProvider.signOut();
              if (context.mounted) {
                bottomNavBarModel.currentIndex = 0;
                Navigator.pushReplacementNamed(context, Routes.start);
              }
            },
            child: const Text(
              "Sign Out",
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          ),
        ],
        backgroundColor: HexColor("#1F9478"),
        elevation: 10,
      ),
      body: pageList[bottomNavBarModel.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavBarModel.currentIndex,
        onTap: (index) {
          bottomNavBarModel.currentIndex = index;
          print(index);
        },
        items: tabItems,
      ),
    );
  }
}
