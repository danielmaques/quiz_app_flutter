class OpenAIResponse {
  final String id;
  final String model;
  final List<Choice> choices;

  OpenAIResponse(
      {required this.id, required this.model, required this.choices});

  factory OpenAIResponse.fromJson(Map<String, dynamic> json) {
    var list = json['choices'] as List;
    List<Choice> choicesList = list.map((i) => Choice.fromJson(i)).toList();

    return OpenAIResponse(
      id: json['id'],
      model: json['model'],
      choices: choicesList,
    );
  }
}

class Choice {
  final String text;
  final int index;
  final String logprobs;
  final String finishReason;

  Choice(
      {required this.text,
      required this.index,
      this.logprobs = '',
      this.finishReason = ''});

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      text: json['text'],
      index: json['index'],
      logprobs: json['logprobs'] ?? '',
      finishReason: json['finish_reason'] ?? '',
    );
  }
}
