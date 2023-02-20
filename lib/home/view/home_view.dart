import 'package:cansat_interface/home/home.dart';
import 'package:cansat_interface/metrics/metrics.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: DefaultTextStyle(
          style: FluentTheme.of(context).typography.subtitle!,
          child: const Text('Interfaz CANSAT'),
        ),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.minimal,
        selected: context.select<HomeCubit, int>(
          (cubit) => cubit.state.paneIndex,
        ),
        onChanged: context.read<HomeCubit>().changePaneIndex,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.stacked_line_chart),
            title: const Text('Métricas'),
            body: const MetricsPage(),
          ),
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Configuración'),
            body: const Text('Configuración'),
          ),
        ],
      ),
    );
  }
}