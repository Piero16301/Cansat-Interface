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
        accelerationX: double.parse(data[3]), // Acceleration X
        accelerationY: double.parse(data[4]), // Acceleration Y
        accelerationZ: double.parse(data[5]), // Acceleration Z
        gyroscopeX: double.parse(data[6]), // Gyroscope X
        gyroscopeY: double.parse(data[7]), // Gyroscope Y
        gyroscopeZ: double.parse(data[8]), // Gyroscope Z
      ),
    );
  }
}
