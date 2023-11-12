import 'package:quiz_anac/src/home/domain/usecase/home_usecase.dart';

abstract class IHomeBloc {
  Future<void> getResponse(String prompt);
}

class HomeBloc implements IHomeBloc {
  final IHomeUsecase _homeUsecase;

  HomeBloc(this._homeUsecase);

  @override
  Future<void> getResponse(String prompt) {
    return _homeUsecase(prompt);
  }
}
