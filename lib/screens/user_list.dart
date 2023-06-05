import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:i_service/model/bottom_nav_bar_model.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/auth_provider.dart';
import 'package:i_service/providers/data_provider.dart';
import 'package:i_service/routes.dart';
import 'package:i_service/widgets/name_tile.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    BottomNavBarModel bottomNavBarModel =
        Provider.of<BottomNavBarModel>(context);
    UserModel? user = Provider.of<UserModel>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    return FutureBuilder(
      future: dataProvider.getCustomerList(user.uid!),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final List<Widget> nameTileList =
              List.generate(snapshot.data!.length, (index) {
            return NameTile(
              snapshot.data![index].name!,
              snapshot.data![index].uid!,
            );
          });
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Customer List",
                style: TextStyle(fontSize: 30),
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
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return nameTileList[index];
                },
                itemCount: nameTileList.length,
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
