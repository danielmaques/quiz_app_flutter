import 'package:flutter_modular/flutter_modular.dart';
import 'package:quiz_anac/src/simulated/ui/components/simulated_completed.dart';

class SimulatedCompletedModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(
      "/",
      child: (c) => SimulatedCompleted(
        correctAnswers: r.args.data['correctAnswers'],
        answeredQuestions: r.args.data['answeredQuestions'],
      ),
    );
  }
}
