import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_anac/src/home/data/model/questions_model.dart';
import 'package:quiz_anac/src/simulated/ui/components/corrections.dart';

class SimulatedCompleted extends StatefulWidget {
  const SimulatedCompleted({
    super.key,
    required this.correctAnswers,
    required this.answeredQuestions,
  });

  final int correctAnswers;
  final List<AnsweredQuestion> answeredQuestions;

  @override
  State<SimulatedCompleted> createState() => _SimulatedCompletedState();
}

class _SimulatedCompletedState extends State<SimulatedCompleted>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final incorrectQuestions = widget.answeredQuestions
        .where((q) => q.givenAnswer != q.correctAnswer)
        .toList();
    final totalAnswered = widget.correctAnswers + incorrectQuestions.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.correctAnswers >= 14
              ? Lottie.asset(
                  'assets/animations/check.json',
                  controller: _animationController,
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                  onLoaded: (composition) {
                    _animationController
                      ..duration = composition.duration
                      ..forward();
                  },
                )
              : Lottie.asset(
                  'assets/animations/erro.json',
                  controller: _animationController,
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                  onLoaded: (composition) {
                    _animationController
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
          Text(
            widget.correctAnswers >= 14 ? 'Aprovado' : 'Reprovado',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Respostas corretas: ${widget.correctAnswers}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Respostas erradas: ${incorrectQuestions.length.toString()}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Questões respondidas: $totalAnswered/20',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              onTap: () {
                _showMyBottomSheet(
                  context: context,
                  questions: widget.answeredQuestions,
                );
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color:
                        widget.correctAnswers >= 14 ? Colors.green : Colors.red,
                    width: 1,
                  ),
                ),
                child: const Center(
                  child: Text('Visualizar correção'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(50),
            child: InkWell(
              onTap: () {
                Modular.to.pushReplacementNamed('/');
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Text('Finalizar Simulado'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMyBottomSheet({
    required BuildContext context,
    required List<AnsweredQuestion> questions,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Corrections(
          questions: questions,
        );
      },
    );
  }
}
