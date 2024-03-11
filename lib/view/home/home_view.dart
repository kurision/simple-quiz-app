import 'package:flutter/material.dart';
import 'package:simple_quiz_app/core/constants/constants.dart';
import 'package:simple_quiz_app/core/database/db_connect.dart';
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
  var db = DBConnect();
  late Future questionList;
  // final List<QuestionModel> _questions = [
  //   QuestionModel(
  //       id: '1',
  //       title: 'What is 1+1',
  //       options: {'1': false, '2': true, '3': false, '4': false}),
  //   QuestionModel(
  //       id: '2',
  //       title: 'What is 2+2',
  //       options: {'1': false, '2': false, '3': false, '4': true}),
  //   QuestionModel(
  //       id: '3',
  //       title: 'What is 3+3',
  //       options: {'1': false, '6': true, '3': false, '4': false}),
  //   QuestionModel(
  //       id: '4',
  //       title: 'How many Provinces are there in Neapl?',
  //       options: {'1': false, '4': false, '7': true, '14': false}),
  // ];

  int index = 0;
  int score = 0;
  bool isClicked = false;
  bool isAlreadyAnswered = false;

  void nextQuestion(int length) {
    if (index < length - 1) {
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
                totalQuestion: length,
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

  Future<List<QuestionModel>> getQuestions() async {
    return await db.getQuestions();
  }

  @override
  void initState() {
    questionList = getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: questionList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else if (snapshot.hasData) {
              var extractedData = snapshot.data as List<QuestionModel>;
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
                        question: extractedData[index].title,
                        indexAction: index,
                        totalQuestion: extractedData.length,
                      ),
                      const Divider(
                        color: neutral,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      for (int i = 0;
                          i < extractedData[index].options.length;
                          i++)
                        GestureDetector(
                          onTap: () {
                            // bool isCorrect = extractedData[index].options.values.toList()[i];
                            // setState(() {
                            //   isClicked = true;
                            // });
                            checkAnswerAndUpdate(extractedData[index]
                                .options
                                .values
                                .toList()[i]);
                          },
                          child: OptionCard(
                            option:
                                extractedData[index].options.keys.toList()[i],
                            color: isClicked
                                ? extractedData[index]
                                            .options
                                            .values
                                            .toList()[i] ==
                                        true
                                    ? correct
                                    : incorrrect
                                : neutral,
                          ),
                        )
                    ],
                  ),
                ),
                floatingActionButton: GestureDetector(
                  onTap:()=>nextQuestion(extractedData.length),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: NextButton(
                      
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text('No data found'),
          );
        });
  }
}
