import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_anac/core/errors/base_error.dart';
import 'package:quiz_anac/core/result_wrapper/result_wrapper.dart';
import 'package:quiz_anac/src/home/data/model/questions_model.dart';

abstract class IHomeDatasource {
  Future<Result<List<Questao>>> call(String topic);
}

class HomeDatasource implements IHomeDatasource {
  final String apiKey = 'oko';
  final String engineId = 'davinci';

  @override
  Future<Result<List<Questao>>> call(String topic) async {
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
        var questionsModel = QuestionsModel.fromJson(responseData);
        var filteredQuestions = questionsModel.getQuestionsByTopic(topic);
        return ResultSuccess<List<Questao>>(filteredQuestions);
      } else {
        var jsonText = await rootBundle.loadString('assets/data/data.json');
        var jsonData = jsonDecode(jsonText);
        var questionsModel = QuestionsModel.fromJson(jsonData);
        var filteredQuestions = questionsModel.getQuestionsByTopic(topic);
        return ResultSuccess<List<Questao>>(filteredQuestions);
      }
    } catch (e) {
      return ResultError(BaseError('Erro: $e'));
    }
  }
}
