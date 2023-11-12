import 'package:flutter_modular/flutter_modular.dart';
import 'package:quiz_anac/src/simulated/ui/page/simulated_page.dart';

class SimulatedModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child("/",
        child: (c) => SimulatedPage(
              questions: r.args.data['questions'],
            ));
  }
}
