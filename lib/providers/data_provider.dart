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
    List<QuestionModel> questionList = [];
    questionCollection.docs.map((doc) async {
      questionList.add(QuestionModel(
          doc["title"] ?? "", doc["7DfERcoaoKYhPl4h2K6V"] ?? "", doc["hint"]));
    }).toList();
    questionList = questionList;

    return questionList;
  }
}
