import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:simple_quiz_app/core/constants/firebase.dart';
import 'package:simple_quiz_app/models/question_model.dart';

class DBConnect {
  final url = Uri.parse(firebaseUrl);
  //to add question to db
  Future<void> addQuestion(QuestionModel question) async {
    http.post(url, body: question.toJson());
  }

  Future<List<QuestionModel>> getQuestions() async {
    final response = await http.get(url);
    List<QuestionModel> questionList = [];
    var data = json.decode(response.body);

    data.forEach((key, value) {
      questionList.add(QuestionModel.fromMap(value));
    });
    log(questionList.toString());
    return questionList;
  }
}
