import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_anac/core/states/base_page_state.dart';
import 'package:quiz_anac/src/home/domain/usecase/home_usecase.dart';

abstract class IHomeBloc extends Cubit<BaseState> {
  IHomeBloc() : super(const EmptyState());

  Future<void> getResponse(String prompt);
}

class HomeBloc extends IHomeBloc {
  final IHomeUsecase _homeUsecase;

  HomeBloc(this._homeUsecase);

  @override
  Future<void> getResponse(String prompt) async {
    emit(const LoadingState());
    try{
      final result = await _homeUsecase(prompt);

      emit(SuccessState(result.getSuccessData));
    }catch(e){
      emit(ErrorState(e.toString()));
    }
  }
}
