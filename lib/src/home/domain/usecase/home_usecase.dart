import 'package:quiz_anac/core/result_wrapper/result_wrapper.dart';
import 'package:quiz_anac/src/home/data/datasource/home_datasource.dart';
import 'package:quiz_anac/src/home/data/model/questions_model.dart';

abstract class IHomeUsecase {
  Future<Result<List<Questao>>> call(String prompt);
}

class HomeUsecase implements IHomeUsecase {
  HomeUsecase(this._homeDatasource);

  final IHomeDatasource _homeDatasource;

  @override
  Future<Result<List<Questao>>> call(String prompt) {
    return _homeDatasource(prompt);
  }
}
