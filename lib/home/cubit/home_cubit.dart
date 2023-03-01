import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.preferences) : super(const HomeState());

  final SharedPreferences preferences;

  void loadSelectedMode() {
    emit(
      state.copyWith(
        selectedMode: preferences.getString('selectedMode') ?? 'MQTT',
        selectedIcon: preferences.getString('selectedMode') == 'MQTT'
            ? FluentIcons.internet_sharing
            : FluentIcons.plug_connected,
      ),
    );
  }

  void changePaneIndex(int index) => emit(state.copyWith(paneIndex: index));

  Future<void> changeSelectedMode(String mode) async {
    await preferences.setString('selectedMode', mode);
    emit(
      state.copyWith(
        selectedMode: mode,
        selectedIcon: mode == 'MQTT'
            ? FluentIcons.internet_sharing
            : FluentIcons.plug_connected,
      ),
    );
  }
}
