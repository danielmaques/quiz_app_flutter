import 'package:flutter/material.dart';
import 'package:quiz_anac/src/home/data/model/questions_model.dart';

class Corrections extends StatelessWidget {
  const Corrections({
    super.key,
    required this.questions,
  });

  final List<AnsweredQuestion> questions;

  @override
  Widget build(BuildContext context) {
    final incorrectQuestions =
        questions.where((q) => q.givenAnswer != q.correctAnswer).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        itemCount: incorrectQuestions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final question = incorrectQuestions[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}. ${question.question.enunciado}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red.withOpacity(0.1),
                ),
                child: Text(
                  'Resposta dada: ${question.givenAnswer}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green.withOpacity(0.1),
                ),
                child: Text(
                  'Resposta correta: ${question.correctAnswer}',
                  style: const TextStyle(color: Colors.green),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
