import 'package:flutter/material.dart';
import 'package:simple_quiz_app/core/constants/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: const Text(
        'Next Question',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
