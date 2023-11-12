import 'dart:async';

import 'package:flutter/material.dart';

class SimulatedAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SimulatedAppBar({Key? key}) : super(key: key);

  @override
  State<SimulatedAppBar> createState() => _SimulatedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SimulatedAppBarState extends State<SimulatedAppBar> {
  late Timer _timer;
  Duration _duration = const Duration(minutes: 36);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _duration -= const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 22),
              children: <TextSpan>[
                TextSpan(
                  text: 'Anac',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'Simulado',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          Text(formatDuration(_duration)),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}
