import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i_service/model/company_model.dart';
import 'package:i_service/model/question_model.dart';
import 'package:i_service/model/use_model.dart';
import 'package:i_service/screens/company.dart';

class DataProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<QuestionModel> questionList = [];
  List<CompanyModel> companyList = [];
  List<UserModel> customerList = [];

  Future<List<QuestionModel>> getCollection(String uid) async {
    final questionCollection = await _db.collection("questions").get();
    List<QuestionModel> tempList = [];
    questionCollection.docs.map((doc) async {
      tempList.add(
          QuestionModel(doc["title"] ?? "", doc[uid] ?? "", doc["hint"] ?? ""));
    }).toList();

    print(tempList.length);

    questionList = tempList;

    return questionList;
  }

  void setQuestionList(String text, int index) {
    questionList[index].answer = text;
  }

  Future<void> saveInfo(String uid) async {
    final questionCollection = await _db.collection("questions").get();
    print("started");
    questionCollection.docs.asMap().forEach((index, doc) async {
      print("started to saving");
      await _db.collection("questions").doc(doc.id).update({
        uid: questionList[index].answer,
      });
    });
  }

  Future<void> updateValue() async {
    print("started");
    await _db
        .collection("questions")
        .doc("Qd6azUj1wtjEZWCObRvU")
        .update({"7DfERcoaoKYhPl4h2K6V": "Canada"});
    print("end");
  }

  Future<void> createAnswer(String uid) async {
    final questionCollection = await _db.collection("questions").get();
    questionCollection.docs.asMap().forEach((index, doc) async {
      print("answer");
      await _db.collection("questions").doc(doc.id).update({uid: ""});
    });
  }

  Future<void> createChecked(String uid) async {
    final questionCollection = await _db.collection("companies").get();
    questionCollection.docs.asMap().forEach((index, doc) async {
      print("checked");
      await _db.collection("companies").doc(doc.id).update({uid: false});
    });
  }

  Future<List<CompanyModel>> getCompanyInfo(String uid) async {
    final companyCollection = await _db.collection("companies").get();
    List<CompanyModel> tempList = [];
    companyCollection.docs.asMap().forEach((index, doc) {
      tempList.add(CompanyModel(
          doc["name"] ?? "", doc["imgUrl"] ?? "", doc[uid] ?? true, doc.id));
    });

    companyList = tempList;

    return companyList;
  }

  Future<void> reverseChecked(bool? value, String companyId, String uid) async {
    print("started");
    await _db.collection("companies").doc(companyId).update({uid: value});
    print("end");
    notifyListeners();
  }

  Future<void> createUser(String uid, String name) async {
    print("user");
    await _db.collection("users").doc(uid).set({"name": name});
  }

  Future<void> createCompany(String uid, String name, String imgUrl) async {
    await _db
        .collection("companies")
        .doc(uid)
        .set({"name": name, "imgUrl": imgUrl});
  }

  Future<List<UserModel>> getCustomerList(String uid) async {
    final customerCollection = await _db.collection("users").get();
    final conpanyInfo = await _db.collection("companies").doc(uid).get();
    final bool isPermitted = conpanyInfo[uid];
    List<UserModel> tempList = [];
    customerCollection.docs.asMap().forEach((index, doc) {
      tempList.add(UserModel(uid: doc.id, email: null, name: doc["name"]));
      print(doc["name"]);
    });

    // print(tempList);
    customerList = tempList;

    return customerList;
  }

  Future<List<UserModel>> getCustomerListBeta() async {
    final questionCollection = await _db
        .collection("questions")
        .where("title", isEqualTo: "name")
        .get();
    List<UserModel> tempList = [];
    questionCollection.docs.asMap().forEach((index, doc) {
      tempList.add(UserModel(uid: doc.id, email: null, name: doc["name"]));
      print(doc["name"]);
    });

    // print(tempList);
    customerList = tempList;

    return customerList;
  }

  Future<Map<String, dynamic>> getUserInfo(String uid, String companyId) async {
    final questionCollection = await _db.collection("questions").get();
    final companyCollection =
        await _db.collection("companies").doc(companyId).get();
    final bool isAllowed = companyCollection[uid];
    Map<String, dynamic> map = {};
    questionCollection.docs.asMap().forEach((index, doc) {
      map[doc["title"]] = isAllowed ? doc[uid] : "";
    });

    return map;
  }
}
