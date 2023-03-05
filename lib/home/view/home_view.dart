import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cansat_interface/home/home.dart';
import 'package:cansat_interface/metrics/metrics.dart';
import 'package:cansat_interface/settings/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    required this.preferences,
    super.key,
  });

  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    final buttonColors = WindowButtonColors(
      iconNormal: Colors.white,
      mouseOver: Colors.white.withOpacity(0.5),
      mouseDown: Colors.white.withOpacity(0.5),
      iconMouseOver: Colors.black,
      iconMouseDown: Colors.black,
    );

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
        actions: WindowTitleBarBox(
          child: Row(
            children: [
              Expanded(child: Container()),
              Row(
                children: [
                  MinimizeWindowButton(colors: buttonColors),
                  MaximizeWindowButton(colors: buttonColors),
                  CloseWindowButton(colors: buttonColors),
                ],
              ),
            ],
          ),
        ),
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
            body: MetricsPage(preferences: preferences),
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
