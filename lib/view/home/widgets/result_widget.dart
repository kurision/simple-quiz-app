import 'package:flutter/material.dart';
import 'package:simple_quiz_app/core/constants/conatants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox(
      {super.key,
      required this.score,
      required this.totalQuestion,
      required this.reset});
  final int score;
  final int totalQuestion;
  final VoidCallback reset;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Result",
              style: TextStyle(fontSize: 24, color: neutral),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundColor: score == totalQuestion / 2
                  ? Colors.yellow
                  : score < totalQuestion / 2
                      ? incorrrect
                      : correct,
              radius: 50,
              child: Text(
                "$score/$totalQuestion",
                style: const TextStyle(fontSize: 24, color: background),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              score == totalQuestion / 2
                  ? 'Good Job!'
                  : score < totalQuestion / 2
                      ? 'You can do better!'
                      : 'Great Job!',
              style: const TextStyle(
                fontSize: 20,
                color: neutral,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: reset,
              child: const Text(
                'Play Again',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: neutral),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
