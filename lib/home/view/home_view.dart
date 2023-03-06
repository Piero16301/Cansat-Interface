import 'package:cansat_interface/history/history.dart';
import 'package:cansat_interface/home/home.dart';
import 'package:cansat_interface/metrics/metrics.dart';
import 'package:cansat_interface/settings/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    required this.preferences,
    required this.collection,
    super.key,
  });

  final SharedPreferences preferences;
  final BoxCollection collection;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: DefaultTextStyle(
          style: FluentTheme.of(context).typography.subtitle!,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Image.asset(
                  'assets/cansat_logo.png',
                ),
                const SizedBox(width: 10),
                const Text('CANSAT Telemetry'),
              ],
            ),
          ),
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
            body: MetricsPage(
              preferences: preferences,
              collection: collection,
            ),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.history),
            title: const Text('Historial'),
            body: HistoryPage(
              collection: collection,
            ),
          ),
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Configuración'),
            body: SettingsPage(preferences: preferences),
          ),
        ],
      ),
    );
  }
}
