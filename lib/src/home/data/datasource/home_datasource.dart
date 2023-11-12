import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_anac/core/errors/base_error.dart';
import 'package:quiz_anac/core/result_wrapper/result_wrapper.dart';
import 'package:quiz_anac/src/home/data/model/home_model.dart';
import 'package:quiz_anac/src/home/data/model/questions_model.dart';

abstract class IHomeDatasource {
  Future<Result<String>> call(String topic);
}

class HomeDatasource implements IHomeDatasource {
  final String apiKey = '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';
  final String engineId = 'davinci';

  @override
  Future<Result<String>> call(String topic) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": topic}
          ],
          "max_tokens": 500,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final openAIResponse = OpenAIResponse.fromJson(responseData);
        return ResultSuccess(openAIResponse.choices.first.text);
      } else {
        var jsonText = await rootBundle.loadString('assets/data/data.json');
        print("JSON Carregado: $jsonText");

        var jsonData = jsonDecode(jsonText);
        var questionsModel = QuestionsModel.fromJson(jsonData);

        print("Modelo Carregado: $questionsModel");

        var filteredQuestions = questionsModel.getQuestionsByTopic(topic);

        print("Questões Filtradas: $filteredQuestions");

        return ResultSuccess(filteredQuestions.toString());
      }
    } catch (e) {
      return ResultError(BaseError('Erro: $e'));
    }
  }
}
