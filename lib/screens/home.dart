import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:i_service/model/question_model.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/data_provider.dart';
import 'package:i_service/widgets/input_box.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    UserModel? user = Provider.of<UserModel>(context);
    return FutureBuilder(
      future: dataProvider.getCollection(user.uid!),
      builder:
          (BuildContext context, AsyncSnapshot<List<QuestionModel>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final List<Widget> inputBoxList =
              List.generate(snapshot.data!.length, (index) {
            return InputBox(
                snapshot.data![index].title,
                snapshot.data![index].answer,
                snapshot.data![index].hint,
                index);
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
                        onPressed: () async {
                          await dataProvider.saveInfo(user.uid!);
                          Fluttertoast.showToast(
                              msg: "Data was saved properly",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: const Text("Fix Info")),
                  ),
                ),
              ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
