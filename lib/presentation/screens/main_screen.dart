import 'package:flutter/material.dart';
import 'package:ford_fulkerson_simulator/config/theme/app_theme.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_viewport.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/graph_toolbar.dart';
import 'package:ford_fulkerson_simulator/presentation/widgets/app_title_bar.dart';
import 'package:gap/gap.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final styleLarge = Theme.of(context).textTheme.bodyLarge;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTitleBar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Simula el flujo máximo', style: styleLarge),
                  Text(
                    'Genera una red dirigida, define los vértices de origen y destino, y observa paso a paso cómo viaja el flujo, evoluciona la red residual y se certifica el corte mínimo.',
                  ),
                  Gap(30),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.greyContainerColor,
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                    child: GraphToolbar(),
                  ),
                  GraphViewport(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
