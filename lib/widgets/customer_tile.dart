import 'package:flutter/material.dart';

// tile for customer information
class Customer extends StatelessWidget {
  const Customer(this.title, this.value, {super.key});
  final title;
  final value;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$title: $value",
      style: TextStyle(fontSize: 25),
    );
  }
}
