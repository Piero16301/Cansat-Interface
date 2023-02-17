import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void initializeMQTT() {
    const broker = '192.168.0.11';
    const port = 1883;
    const clientID = 'cansat-interface';
    const topic = 'cansat/telemetry';

    emit(
      state.copyWith(
        broker: broker,
        port: port,
        clientID: clientID,
        topic: topic,
      ),
    );
  }

  void toggleMQTTReading({required bool value}) {
    emit(
      state.copyWith(
        isReadingMQTT: value,
        humidity: !value ? 0 : state.humidity,
        pressure: !value ? 0 : state.pressure,
        temperature: !value ? 0 : state.temperature,
        gyroscopeX: !value ? 0 : state.gyroscopeX,
        gyroscopeY: !value ? 0 : state.gyroscopeY,
        gyroscopeZ: !value ? 0 : state.gyroscopeZ,
        accelerationX: !value ? 0 : state.accelerationX,
        accelerationY: !value ? 0 : state.accelerationY,
        accelerationZ: !value ? 0 : state.accelerationZ,
      ),
    );
  }

  void updateMQTTData(String message) {
    final data = message.split(',');
    emit(
      state.copyWith(
        humidity: double.parse(data[0]), // Humidity
        pressure: double.parse(data[1]), // Pressure
        temperature: double.parse(data[2]), // Temperature
        gyroscopeX: double.parse(data[3]), // Gyroscope X
        gyroscopeY: double.parse(data[4]), // Gyroscope Y
        gyroscopeZ: double.parse(data[5]), // Gyroscope Z
        accelerationX: double.parse(data[6]), // Acceleration X
        accelerationY: double.parse(data[7]), // Acceleration Y
        accelerationZ: double.parse(data[8]), // Acceleration Z
      ),
    );
  }
}
