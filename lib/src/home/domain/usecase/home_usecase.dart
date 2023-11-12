import 'package:quiz_anac/core/result_wrapper/result_wrapper.dart';
import 'package:quiz_anac/src/home/data/datasource/home_datasource.dart';

abstract class IHomeUsecase {
  Future<Result<String>> call(String prompt);
}

class HomeUsecase implements IHomeUsecase {
  HomeUsecase(this._homeDatasource);

  final IHomeDatasource _homeDatasource;

  @override
  Future<Result<String>> call(String prompt) {
    return _homeDatasource(prompt);
  }
}
