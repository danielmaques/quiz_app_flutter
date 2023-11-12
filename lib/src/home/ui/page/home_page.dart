import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quiz_anac/core/states/base_page_state.dart';
import 'package:quiz_anac/src/home/data/model/questions_model.dart';
import 'package:quiz_anac/src/home/ui/bloc/home_bloc.dart';
import 'package:quiz_anac/src/home/ui/components/home_app_bar.dart';
import 'package:quiz_anac/src/home/ui/components/list_card_simulated.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IHomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = Modular.get<IHomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Simulados',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder(
            bloc: homeBloc,
            builder: (context, state) {
              if (state is SuccessState<List<Questao>>) {
                var questions = state.data;
                return CardSimulated(
                  onTap: (topic) {
                    homeBloc.getResponse(topic);
                  },
                  questions: questions,
                );
              } else {
                return CardSimulated(
                  onTap: (topic) {
                    homeBloc.getResponse(topic);
                  },
                  questions: const [],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
