import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/model/bottom_nav_bar_model.dart';
import 'package:i_service/screens/home.dart';
import 'package:i_service/screens/setting.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  List<Widget> pageList = <Widget>[
    const Home(),
    const Setting(),
  ];

  List<String> pageNameList = <String>["Home", "Setting"];

  final tabItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavBarModel bottomNavBarModel =
        Provider.of<BottomNavBarModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(pageNameList[bottomNavBarModel.currentIndex]),
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
