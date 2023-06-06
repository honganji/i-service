import 'package:flutter/material.dart';

// class of company data
class CompanyModel with ChangeNotifier {
  String name;
  String imgUrl;
  bool checked;
  String companyId;

  CompanyModel(this.name, this.imgUrl, this.checked, this.companyId);
}
