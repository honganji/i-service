import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/routes.dart';

class NameTile extends StatelessWidget {
  const NameTile(this.name, this.id, {super.key});
  final String name;
  final String id;

  // name tile for custumer name screen
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.individual, arguments: id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: MediaQuery.of(context).size.height / 15,
        width: 200,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: HexColor("#1F9478"),
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 30),
            ),
            const Icon(Icons.arrow_circle_right_rounded),
          ],
        ),
      ),
    );
  }
}
