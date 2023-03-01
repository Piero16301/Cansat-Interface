import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._preferences) : super(const SettingsState()) {
    _loadSettings();
  }

  final SharedPreferences _preferences;

  void _loadSettings() {
    emit(
      state.copyWith(
        savingStatus: SavingStatus.initial,
        broker: _preferences.getString('broker') ?? '',
        port: _preferences.getInt('port') ?? 0,
        clientID: _preferences.getString('clientID') ?? '',
        topic: _preferences.getString('topic') ?? '',
        serialPort: _preferences.getString('serialPort') ?? '',
        serialBaudRate: _preferences.getInt('serialBaudRate') ?? 0,
        serialDataBits: _preferences.getInt('serialDataBits') ?? 0,
      ),
    );
  }

  void brokerChanged(String broker) {
    emit(
      state.copyWith(
        savingStatus: SavingStatus.initial,
        broker: broker,
      ),
    );
  }

  void portChanged(String port) {
    emit(
      state.copyWith(
        savingStatus: SavingStatus.initial,
        port: int.tryParse(port) ?? 0,
      ),
    );
  }

  void clientIDChanged(String clientID) {
    emit(
      state.copyWith(
        savingStatus: SavingStatus.initial,
        clientID: clientID,
      ),
    );
  }

  void topicChanged(String topic) {
    emit(
      state.copyWith(
        savingStatus: SavingStatus.initial,
        topic: topic,
      ),
    );
  }

  void serialPortChanged(String serialPort) {
    emit(
      state.copyWith(
        savingStatus: SavingStatus.initial,
        serialPort: serialPort,
      ),
    );
  }

  void serialBaudRateChanged(String serialBaudRate) {
    emit(
      state.copyWith(
        savingStatus: SavingStatus.initial,
        serialBaudRate: int.tryParse(serialBaudRate) ?? 0,
      ),
    );
  }

  void serialDataBitsChanged(String serialDataBits) {
    emit(
      state.copyWith(
        savingStatus: SavingStatus.initial,
        serialDataBits: int.tryParse(serialDataBits) ?? 0,
      ),
    );
  }

  Future<void> saveSettings() async {
    emit(state.copyWith(savingStatus: SavingStatus.saving));
    try {
      await _preferences.setString('broker', state.broker);
      await _preferences.setInt('port', state.port);
      await _preferences.setString('clientID', state.clientID);
      await _preferences.setString('topic', state.topic);
      await _preferences.setString('serialPort', state.serialPort);
      await _preferences.setInt('serialBaudRate', state.serialBaudRate);
      await _preferences.setInt('serialDataBits', state.serialDataBits);
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(savingStatus: SavingStatus.saved));
    } catch (e) {
      emit(state.copyWith(savingStatus: SavingStatus.initial));
    }
  }
}
