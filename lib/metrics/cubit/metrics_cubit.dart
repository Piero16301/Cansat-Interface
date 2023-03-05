import 'package:bloc/bloc.dart';
import 'package:ditredi/ditredi.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'metrics_state.dart';

class MetricsCubit extends Cubit<MetricsState> {
  MetricsCubit(this._preferences, this._collection)
      : super(const MetricsState());

  final SharedPreferences _preferences;
  final BoxCollection _collection;

  void initializeConnection() {
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
        'assets/models/Cansat.obj',
      );
      emit(state.copyWith(status: MetricsStatus.success, faces: faces));
    } catch (e) {
      // emit(state.copyWith(status: MetricsStatus.failure));
    }
  }

  Future<void> toggleReading({required bool value}) async {
    // Cuando se detiene, guardar mediciones de sensores en Hive
    if (!value) {
      final metricsBox = await _collection.openBox<Map<dynamic, dynamic>>(
        'metrics',
      );
      final metricsKeys = await metricsBox.getAllKeys();
      final lastKey = metricsKeys.isNotEmpty ? int.parse(metricsKeys.last) : 0;

      await metricsBox.put(
        (lastKey + 1).toString(),
        {
          'start': state.timeMarker!.toIso8601String(),
          'end': DateTime.now().toIso8601String(),
          'humidity': state.humidityData,
          'pressure': state.pressureData,
          'temperature': state.temperatureData,
          'gyroscopeX': state.gyroscopeDataX,
          'gyroscopeY': state.gyroscopeDataY,
          'gyroscopeZ': state.gyroscopeDataZ,
          'accelerationX': state.accelerationDataX,
          'accelerationY': state.accelerationDataY,
          'accelerationZ': state.accelerationDataZ,
          'altitude': state.altitudeData,
        },
      );
    }

    // Limpiar datos de sensores
    emit(
      state.copyWith(
        isReading: value,
        timeMarker: value ? DateTime.now() : state.timeMarker,
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

  void updateData(String message) {
    if (!state.isReading) return;
    final data = message.split(',');
    emit(
      state.copyWith(
        humidity: double.tryParse(data[0]) ?? 0, // Humidity
        humidityData: [
          ...state.humidityData,
          double.tryParse(data[0]) ?? 0,
        ], // Humidity Data
        pressure: double.tryParse(data[1]) ?? 0, // Pressure
        pressureData: [
          ...state.pressureData,
          double.tryParse(data[1]) ?? 0,
        ], // Pressure Data
        temperature: double.tryParse(data[2]) ?? 0, // Temperature
        temperatureData: [
          ...state.temperatureData,
          double.tryParse(data[2]) ?? 0,
        ], // Temperature Data
        gyroscopeX: double.tryParse(data[3]) ?? 0, // Gyroscope X
        gyroscopeDataX: [
          ...state.gyroscopeDataX,
          double.tryParse(data[3]) ?? 0,
        ], // Gyroscope X Data
        gyroscopeY: double.tryParse(data[4]) ?? 0, // Gyroscope Y
        gyroscopeDataY: [
          ...state.gyroscopeDataY,
          double.tryParse(data[4]) ?? 0,
        ], // Gyroscope Y Data
        gyroscopeZ: double.tryParse(data[5]) ?? 0, // Gyroscope Z
        gyroscopeDataZ: [
          ...state.gyroscopeDataZ,
          double.tryParse(data[5]) ?? 0,
        ], // Gyroscope Z Data
        accelerationX: double.tryParse(data[6]) ?? 0, // Acceleration X
        accelerationDataX: [
          ...state.accelerationDataX,
          double.tryParse(data[6]) ?? 0,
        ], // Acceleration X Data
        accelerationY: double.tryParse(data[7]) ?? 0, // Acceleration Y
        accelerationDataY: [
          ...state.accelerationDataY,
          double.tryParse(data[7]) ?? 0,
        ], // Acceleration Y Data
        accelerationZ: double.tryParse(data[8]) ?? 0, // Acceleration Z
        accelerationDataZ: [
          ...state.accelerationDataZ,
          double.tryParse(data[8]) ?? 0,
        ], // Acceleration Z Data
        altitude: double.tryParse(data[9]) ?? 0, // Altitude
        altitudeData: [
          ...state.altitudeData,
          double.tryParse(data[9]) ?? 0,
        ], // Altitude Data
      ),
    );
  }
}
