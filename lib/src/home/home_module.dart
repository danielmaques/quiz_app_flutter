import 'package:flutter_modular/flutter_modular.dart';
import 'package:quiz_anac/src/home/data/datasource/home_datasource.dart';
import 'package:quiz_anac/src/home/domain/usecase/home_usecase.dart';
import 'package:quiz_anac/src/home/ui/bloc/home_bloc.dart';

import 'ui/page/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<IHomeDatasource>(HomeDatasource.new);
    i.addSingleton<IHomeUsecase>(HomeUsecase.new);
    i.addSingleton<IHomeBloc>(HomeBloc.new);
  }

  @override
  void routes(r) {
    r.child("/", child: (c) => const HomePage());
  }
}
