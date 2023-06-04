import 'package:flutter/material.dart';
import 'package:i_service/providers/data_provider.dart';
import 'package:provider/provider.dart';

class InputBox extends StatelessWidget {
  const InputBox(this.title, this.answer, this.hint, {super.key});

  final String title;
  final String answer;
  final String hint;

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.replaceFirst(title[0], title[0].toUpperCase()),
            style: const TextStyle(fontSize: 25),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            initialValue: answer,
          ),
        ],
      ),
    );
  }
}
