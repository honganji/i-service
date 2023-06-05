import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i_service/model/question_model.dart';

class DataProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<QuestionModel> questionList = [];

  Future<List<QuestionModel>> getCollection(String collectionName) async {
    final questionCollection = await _db.collection(collectionName).get();
    // final userDoc =
    //     await _db.collection(collectionName).doc("7DfERcoaoKYhPl4h2K6V").get();
    List<QuestionModel> tempList = [];
    questionCollection.docs.map((doc) async {
      tempList.add(QuestionModel(
          doc["title"] ?? "", doc["7DfERcoaoKYhPl4h2K6V"] ?? "", doc["hint"]));
    }).toList();

    questionList = tempList;

    return questionList;
  }

  void setQuestionList(String text, int index) {
    questionList[index].answer = text;
  }

  Future<void> saveInfo() async {
    final questionCollection = await _db.collection("questions").get();
    print("started");
    questionCollection.docs.asMap().forEach((index, doc) async {
      print("started to saving");
      await _db.collection("questions").doc(doc.id).update({
        "7DfERcoaoKYhPl4h2K6V": questionList[index].answer,
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
}
