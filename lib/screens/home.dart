import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i_service/model/question_model.dart';
import 'package:i_service/providers/data_provider.dart';
import 'package:i_service/widgets/input_box.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference questions =
        FirebaseFirestore.instance.collection('questions');
    final List<String> titleList = <String>["Name", "Sex", "Age"];

    DataProvider dataProvider = Provider.of<DataProvider>(context);
    return FutureBuilder(
      future: dataProvider.getCollection("questions"),
      builder:
          (BuildContext context, AsyncSnapshot<List<QuestionModel>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final List<Widget> inputBoxList =
              List.generate(snapshot.data!.length, (index) {
            return InputBox(snapshot.data![index].title);
          });
          return Stack(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return inputBoxList[index];
                },
                itemCount: inputBoxList.length,
              ),
              Positioned(
                  child: Align(
                alignment: const Alignment(0.25, 0.9),
                child: SizedBox(
                  height: 70,
                  width: 320,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Fix Info")),
                ),
              ))
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
