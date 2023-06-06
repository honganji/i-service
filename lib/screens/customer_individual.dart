import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/data_provider.dart';
import 'package:i_service/widgets/customer_tile.dart';
import 'package:provider/provider.dart';

// individual customer information screen
class Individual extends StatelessWidget {
  const Individual({super.key});

  @override
  Widget build(BuildContext context) {
    final String uid = ModalRoute.of(context)!.settings.arguments.toString();
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    UserModel? user = Provider.of<UserModel>(context);
    return FutureBuilder(
      future: dataProvider.getUserInfo(uid, user.uid!),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final keyList = [];
          final valueList = [];
          snapshot.data!.forEach(
            (key, value) {
              keyList.add(key);
              valueList.add(value);
            },
          );
          return Scaffold(
            appBar: AppBar(
              title: Text(
                valueList[keyList.indexOf("name")],
                style: const TextStyle(fontSize: 30),
              ),
              backgroundColor: HexColor("#1F9478"),
              elevation: 10,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Customer(keyList[index], valueList[index]);
                },
                itemCount: keyList.length,
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
