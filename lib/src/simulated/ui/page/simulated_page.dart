import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quiz_anac/src/home/data/model/questions_model.dart';
import 'package:quiz_anac/src/simulated/ui/components/question_card.dart';
import 'package:quiz_anac/src/simulated/ui/components/simulated_app_bar.dart';
import 'package:quiz_anac/src/simulated/ui/components/simulated_completed.dart';

class SimulatedPage extends StatelessWidget {
  SimulatedPage({
    super.key,
    required this.questions,
  });

  final List<Questao> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimulatedAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: questions.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 80),
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            return QuestionCard(
              index: index + 1,
              questao: questions[index],
              onAlternativeSelected: (selectedIndex) {
                _handleAlternativeSelected(index, selectedIndex);
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Material(
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            int correctAnswers = _countCorrectAnswers();

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: SimulatedCompleted(
                      correctAnswers: correctAnswers,
                      answeredQuestions: _answeredQuestions,
                    ),
                  ),
                );
              },
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 180,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Finalizar Simulado',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(width: 8),
                Icon(
                  Iconsax.arrow_right,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<AnsweredQuestion> _answeredQuestions = [];

  void _handleAlternativeSelected(
      int questionIndex, int? selectedAlternativeIndex) {
    if (selectedAlternativeIndex != null) {
      var question = questions[questionIndex];
      bool isCorrect = question.respostaCorreta ==
          question.alternativas[selectedAlternativeIndex];
      _answeredQuestions.add(
        AnsweredQuestion(
          question: question,
          selectedAlternativeIndex: selectedAlternativeIndex,
          isCorrect: isCorrect,
        ),
      );
    }
  }

  int _countCorrectAnswers() {
    return _answeredQuestions.where((q) => q.isCorrect).length;
  }
}
