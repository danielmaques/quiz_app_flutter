import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quiz_anac/core/utils/theme/theme.dart';
import 'package:quiz_anac/src/home/home_module.dart';


class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module("/", module: HomeModule());
  
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Smart App',
      themeMode: ThemeMode.system,
      darkTheme: TAppTheme.darkTheme,
      theme: TAppTheme.lightTheme,
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}
