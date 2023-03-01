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
    context.read<HomeCubit>().loadSelectedMode();

    return NavigationView(
      appBar: NavigationAppBar(
        title: DefaultTextStyle(
          style: FluentTheme.of(context).typography.subtitle!,
          child: const Text('Interfaz CANSAT'),
        ),
        automaticallyImplyLeading: false,
        actions: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropDownButton(
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(state.selectedIcon),
                      const SizedBox(width: 5),
                      Text(
                        state.selectedMode,
                        style: const TextStyle(
                          fontFamily: 'Roboto-Medium',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  items: [
                    MenuFlyoutItem(
                      text: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(FluentIcons.internet_sharing),
                          SizedBox(width: 5),
                          Text(
                            'MQTT',
                            style: TextStyle(
                              fontFamily: 'Roboto-Medium',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () =>
                          context.read<HomeCubit>().changeSelectedMode('MQTT'),
                    ),
                    MenuFlyoutItem(
                      text: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(FluentIcons.plug_connected),
                          SizedBox(width: 5),
                          Text(
                            'Serial',
                            style: TextStyle(
                              fontFamily: 'Roboto-Medium',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => context
                          .read<HomeCubit>()
                          .changeSelectedMode('Serial'),
                    ),
                  ],
                ),
              ],
            ),
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
