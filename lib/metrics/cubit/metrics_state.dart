part of 'metrics_cubit.dart';

class MetricsState extends Equatable {
  const MetricsState({
    this.isReadingMQTT = false,
    this.humidity = 0,
    this.humidityData = const <double>[],
    this.pressure = 0,
    this.temperature = 0,
    this.gyroscopeX = 0,
    this.gyroscopeY = 0,
    this.gyroscopeZ = 0,
    this.accelerationX = 0,
    this.accelerationY = 0,
    this.accelerationZ = 0,
    this.broker = '',
    this.port = 0,
    this.clientID = '',
    this.topic = '',
  });

  final bool isReadingMQTT;

  // Sensor BME280
  final double humidity;
  final List<double> humidityData;
  final double pressure;
  final double temperature;

  // Sensor MPU6050
  final double gyroscopeX;
  final double gyroscopeY;
  final double gyroscopeZ;
  final double accelerationX;
  final double accelerationY;
  final double accelerationZ;

  // MQTT variables
  final String broker;
  final int port;
  final String clientID;
  final String topic;

  MetricsState copyWith({
    bool? isReadingMQTT,
    double? humidity,
    List<double>? humidityData,
    double? pressure,
    double? temperature,
    double? gyroscopeX,
    double? gyroscopeY,
    double? gyroscopeZ,
    double? accelerationX,
    double? accelerationY,
    double? accelerationZ,
    String? broker,
    int? port,
    String? clientID,
    String? topic,
  }) {
    return MetricsState(
      isReadingMQTT: isReadingMQTT ?? this.isReadingMQTT,
      humidity: humidity ?? this.humidity,
      humidityData: humidityData ?? this.humidityData,
      pressure: pressure ?? this.pressure,
      temperature: temperature ?? this.temperature,
      gyroscopeX: gyroscopeX ?? this.gyroscopeX,
      gyroscopeY: gyroscopeY ?? this.gyroscopeY,
      gyroscopeZ: gyroscopeZ ?? this.gyroscopeZ,
      accelerationX: accelerationX ?? this.accelerationX,
      accelerationY: accelerationY ?? this.accelerationY,
      accelerationZ: accelerationZ ?? this.accelerationZ,
      broker: broker ?? this.broker,
      port: port ?? this.port,
      clientID: clientID ?? this.clientID,
      topic: topic ?? this.topic,
    );
  }

  @override
  List<Object> get props => [
        isReadingMQTT,
        humidity,
        humidityData,
        pressure,
        temperature,
        gyroscopeX,
        gyroscopeY,
        gyroscopeZ,
        accelerationX,
        accelerationY,
        accelerationZ,
        broker,
        port,
        clientID,
        topic,
      ];
}
