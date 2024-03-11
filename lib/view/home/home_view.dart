import 'package:flutter/material.dart';
import 'package:simple_quiz_app/core/constants/conatants.dart';
import 'package:simple_quiz_app/models/question_model.dart';
import 'package:simple_quiz_app/view/home/widgets/next_button_widget.dart';
import 'package:simple_quiz_app/view/home/widgets/option_card_widget.dart';
import 'package:simple_quiz_app/view/home/widgets/question_widget.dart';
import 'package:simple_quiz_app/view/home/widgets/result_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<QuestionModel> _questions = [
    QuestionModel(
        id: '1',
        title: 'What is 1+1',
        options: {'1': false, '2': true, '3': false, '4': false}),
    QuestionModel(
        id: '2',
        title: 'What is 2+2',
        options: {'1': false, '2': false, '3': false, '4': true}),
    QuestionModel(
        id: '3',
        title: 'What is 3+3',
        options: {'1': false, '6': true, '3': false, '4': false}),
    QuestionModel(
        id: '4',
        title: 'How many Provinces are there in Neapl?',
        options: {'1': false, '4': false, '7': true, '14': false}),
  ];

  int index = 0;
  int score = 0;
  bool isClicked = false;
  bool isAlreadyAnswered = false;

  void nextQuestion() {
    if (index < _questions.length - 1) {
      setState(() {
        index++;
        isClicked = false;
        isAlreadyAnswered = false;
      });
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (ctx) => ResultBox(
                reset: reset,
                score: score,
                totalQuestion: _questions.length,
              ));
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadyAnswered) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isClicked = true;
        isAlreadyAnswered = true;
      });
    }
  }

  void reset() {
    setState(() {
      index = 0;
      score = 0;
      isClicked = false;
      isAlreadyAnswered = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 20, color: neutral),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: background,
        shadowColor: Colors.transparent,
        title: const Text(
          'Simple Quiz App',
          style: TextStyle(fontSize: 24, color: neutral),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            QuestionWidget(
              question: _questions[index].title,
              indexAction: index,
              totalQuestion: _questions.length,
            ),
            const Divider(
              color: neutral,
            ),
            const SizedBox(
              height: 20,
            ),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () {
                  // bool isCorrect = _questions[index].options.values.toList()[i];
                  // setState(() {
                  //   isClicked = true;
                  // });
                  checkAnswerAndUpdate(
                      _questions[index].options.values.toList()[i]);
                },
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isClicked
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrrect
                      : neutral,
                ),
              )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
