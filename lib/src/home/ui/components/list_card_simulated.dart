// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quiz_anac/src/home/data/model/questions_model.dart';

class CardSimulated extends StatelessWidget {
  CardSimulated({
    super.key,
    required this.onTap,
    required this.questions,
  });

  final void Function(String) onTap;
  final List<Questao> questions;

  final List matter = [
    'Navegação VFR',
    'Teoria de voo',
    'Meteorologia',
    'Regulamentos de\ntráfego aéreo',
    'Conhecimentos\ntécnicos'
  ];
  final List<Color> color = [
    const Color(0xFF877ABA),
    const Color(0xFF7A94BA),
    const Color(0xFF7ABAAE),
    const Color(0xFF7A64F1),
    const Color(0xFF6A9CF4),
  ];
  final List<IconData> icon = [
    Iconsax.map,
    Iconsax.airplane,
    Iconsax.cloud,
    Iconsax.book,
    Iconsax.filter,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 191,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: matter.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Material(
            color: color[index],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                onTap(matter[index]);
                if (questions.isNotEmpty) {
                  Modular.to.pushReplacementNamed('/simulated/', arguments: {
                    'questions': questions,
                  });
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 191,
                width: 152,
                child: Stack(
                  children: [
                    Positioned(
                      right: 3,
                      top: 5,
                      child: SvgPicture.asset('assets/image/back.svg'),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            icon[index],
                            size: 24,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            matter[index],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Piloto Avião',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Container(
                        height: 32,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
