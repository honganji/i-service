import 'package:flutter/material.dart';
import 'package:i_service/model/company_model.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/data_provider.dart';
import 'package:i_service/widgets/company_tile.dart';
import 'package:provider/provider.dart';

class Company extends StatelessWidget {
  const Company({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    UserModel? user = Provider.of<UserModel>(context);
    return FutureBuilder(
        future: dataProvider.getCompanyInfo(user.uid!),
        builder:
            (BuildContext context, AsyncSnapshot<List<CompanyModel>> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final List<Widget> companyTileList =
                List.generate(snapshot.data!.length, (index) {
              return CompanyTile(
                  snapshot.data![index].name,
                  snapshot.data![index].imgUrl,
                  snapshot.data![index].checked,
                  snapshot.data![index].companyId);
            });
            return Stack(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return companyTileList[index];
                  },
                  itemCount: companyTileList.length,
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
