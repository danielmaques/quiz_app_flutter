import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    homeBloc.getResponse('Navegação VFR');
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
          CardSimulated(),
        ],
      ),
    );
  }
}
