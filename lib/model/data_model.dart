import 'package:flutter/material.dart';
import 'package:i_service/model/question_model.dart';
import 'package:i_service/providers/data_provider.dart';

class DataModel with ChangeNotifier {
  final DataProvider _dataProvider = DataProvider();

  List<QuestionModel?> questionList = [];
  bool isFetch = false;

  Future<void> getQuestions() async {
    isFetch = false;
    questionList = await _dataProvider.getCollection("questions");
    isFetch = true;
    notifyListeners();
    return;
  }
}
