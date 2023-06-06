import 'package:flutter/material.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/providers/data_provider.dart';
import 'package:provider/provider.dart';

class CompanyTile extends StatelessWidget {
  CompanyTile(this.name, this.imgUrl, this.checked, this.companyId,
      {super.key});
  String name;
  String imgUrl;
  bool checked;
  String companyId;

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of<DataProvider>(context);
    UserModel? user = Provider.of<UserModel>(context);
    return GestureDetector(
      onTap: () {
        print("pushed");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              ),
              Checkbox(
                  value: checked,
                  onChanged: (bool? value) {
                    print(checked);
                    dataProvider.reverseChecked(!checked, companyId, user.uid!);
                  })
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(
                      imgUrl,
                      errorBuilder: (context, error, stackTrace) => Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset("assets/images/hospital.png"),
                          const Text(
                            "No Image",
                            style: TextStyle(color: Colors.grey, fontSize: 40),
                          )
                        ],
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
