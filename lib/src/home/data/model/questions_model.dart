class QuestionsModel {
  List<Simulado> simulado;

  QuestionsModel({required this.simulado});

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    var simuladoList = json['simulado'] as List;
    List<Simulado> simuladoMapped =
        simuladoList.map((e) => Simulado.fromJson(e)).toList();
    return QuestionsModel(simulado: simuladoMapped);
  }

  List<Questao> getQuestionsByTopic(String topic) {
    for (var materia in simulado) {
      if (materia.materia == topic) {
        return materia.questoes;
      }
    }
    return [];
  }
}

class Simulado {
  String materia;
  List<Questao> questoes;

  Simulado({required this.materia, required this.questoes});

  factory Simulado.fromJson(Map<String, dynamic> json) {
    var questoesList = json['questoes'] as List;
    List<Questao> questoesMapped =
        questoesList.map((e) => Questao.fromJson(e)).toList();
    return Simulado(
      materia: json['materia'],
      questoes: questoesMapped,
    );
  }
}

class Questao {
  String enunciado;
  List<String> alternativas;
  String respostaCorreta;
  int? selectedAlternativeIndex;
  bool? isCorrect;

  Questao({
    required this.enunciado,
    required this.alternativas,
    required this.respostaCorreta,
    this.selectedAlternativeIndex,
    this.isCorrect,
  });

  factory Questao.fromJson(Map<String, dynamic> json) {
    return Questao(
      enunciado: json['enunciado'],
      alternativas: List<String>.from(json['alternativas']),
      respostaCorreta: json['respostaCorreta'],
    );
  }
}

class AnsweredQuestion {
  final Questao question;
  final int?
      selectedAlternativeIndex; // Pode ser nulo se o usuário não respondeu
  final bool isCorrect;

  AnsweredQuestion({
    required this.question,
    this.selectedAlternativeIndex, // Removido 'required' para permitir nulo
    required this.isCorrect,
  });

  String get givenAnswer => selectedAlternativeIndex != null
      ? question.alternativas[selectedAlternativeIndex!]
      : 'Sem resposta';

  String get correctAnswer => question.respostaCorreta;
}
