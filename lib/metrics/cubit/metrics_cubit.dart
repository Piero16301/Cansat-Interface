import 'package:bloc/bloc.dart';
import 'package:ditredi/ditredi.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'metrics_state.dart';

class MetricsCubit extends Cubit<MetricsState> {
  MetricsCubit(this._preferences) : super(const MetricsState());

  final SharedPreferences _preferences;

  void initializeMQTT() {
    emit(
      state.copyWith(
        broker: _preferences.getString('broker') ?? '',
        port: _preferences.getInt('port') ?? 0,
        clientID: _preferences.getString('clientID') ?? '',
        topic: _preferences.getString('topic') ?? '',
      ),
    );
  }

  Future<void> load3DModel() async {
    if (state.faces.isNotEmpty) return;
    emit(state.copyWith(status: MetricsStatus.loading));
    try {
      final faces = await ObjParser().loadFromResources(
        'assets/models/CANSAT-Rocket.obj',
      );
      emit(state.copyWith(status: MetricsStatus.success, faces: faces));
    } catch (e) {
      // emit(state.copyWith(status: MetricsStatus.failure));
    }
  }

  void toggleMQTTReading({required bool value}) {
    emit(
      state.copyWith(
        isReadingMQTT: value,
        humidity: value ? 0 : state.humidity,
        humidityData: value ? [] : state.humidityData,
        pressure: value ? 0 : state.pressure,
        pressureData: value ? [] : state.pressureData,
        temperature: value ? 0 : state.temperature,
        temperatureData: value ? [] : state.temperatureData,
        gyroscopeX: value ? 0 : state.gyroscopeX,
        gyroscopeY: value ? 0 : state.gyroscopeY,
        gyroscopeZ: value ? 0 : state.gyroscopeZ,
        accelerationX: value ? 0 : state.accelerationX,
        accelerationY: value ? 0 : state.accelerationY,
        accelerationZ: value ? 0 : state.accelerationZ,
        altitude: value ? 0 : state.altitude,
      ),
    );
  }

  void updateMQTTData(String message) {
    final data = message.split(',');
    emit(
      state.copyWith(
        humidity: double.parse(data[0]), // Humidity
        humidityData: [
          ...state.humidityData,
          double.parse(data[0]),
        ], // Humidity Data
        pressure: double.parse(data[1]), // Pressure
        pressureData: [
          ...state.pressureData,
          double.parse(data[1]),
        ], // Pressure Data
        temperature: double.parse(data[2]), // Temperature
        temperatureData: [
          ...state.temperatureData,
          double.parse(data[2]),
        ], // Temperature Data
        gyroscopeX: double.parse(data[3]), // Gyroscope X
        gyroscopeY: double.parse(data[4]), // Gyroscope Y
        gyroscopeZ: double.parse(data[5]), // Gyroscope Z
        accelerationX: double.parse(data[6]), // Acceleration X
        accelerationY: double.parse(data[7]), // Acceleration Y
        accelerationZ: double.parse(data[8]), // Acceleration Z
        altitude: double.parse(data[9]), // Altitude
      ),
    );
  }
}
