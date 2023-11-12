import 'package:flutter/material.dart';
import 'package:quiz_anac/src/home/data/model/questions_model.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    super.key,
    required this.index,
    required this.questao,
    required this.onAlternativeSelected,
  });

  final int index;
  final Questao questao;
  final Function(int?) onAlternativeSelected;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int? selectedAlternativeIndex;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: Theme.of(context).cardColor,
      shadowColor: Theme.of(context).shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${widget.index}. ${widget.questao.enunciado}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            ListView.separated(
              itemCount: widget.questao.alternativas.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 0),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: widget.questao.selectedAlternativeIndex == index,
                      onChanged: (value) {
                        setState(() {
                          widget.onAlternativeSelected(value! ? index : null);
                        });
                      },
                    ),
                    Flexible(
                      child: Text(
                        widget.questao.alternativas[index],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
