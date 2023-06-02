import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:i_service/model/question_model.dart';

class DataProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<QuestionModel> questionList = [];

  Future<List<QuestionModel>> getCollection(String collectionName) async {
    final data = await _db.collection(collectionName).get();
    List<QuestionModel> _questionList = [];
    data.docs.map((doc) {
      _questionList.add(QuestionModel(doc["title"] ?? ""));
      // print(doc["title"]);
    }).toList();
    questionList = _questionList;

    print(questionList[0].title);

    return questionList;
  }
}
