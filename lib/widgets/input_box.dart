import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.replaceFirst(title[0], title[0].toUpperCase()),
            style: const TextStyle(fontSize: 25),
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Taro Yamada',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                )),
          ),
        ],
      ),
    );
  }
}
