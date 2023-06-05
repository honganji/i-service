import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i_service/model/company_model.dart';
import 'package:i_service/model/question_model.dart';
import 'package:i_service/screens/company.dart';

class DataProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<QuestionModel> questionList = [];
  List<CompanyModel> companyList = [];

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
      print("started to saving");
      await _db.collection("questions").doc(doc.id).update({uid: ""});
    });
  }

  Future<void> createChecked(String uid) async {
    final questionCollection = await _db.collection("companies").get();
    questionCollection.docs.asMap().forEach((index, doc) async {
      print("started to saving");
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
}
