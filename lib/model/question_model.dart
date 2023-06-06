// class for question data

class QuestionModel {
  final String? _title;
  String? _answer;
  final String? _hint;
  QuestionModel(this._title, this._answer, this._hint);

  String get title => _title ?? "";
  String get answer => _answer ?? "";
  String get hint => _hint ?? "";

  set answer(String text) {
    _answer = text;
  }
}
