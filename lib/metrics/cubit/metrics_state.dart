part of 'metrics_cubit.dart';

enum MetricsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == MetricsStatus.initial;
  bool get isLoading => this == MetricsStatus.loading;
  bool get isSuccess => this == MetricsStatus.success;
  bool get isFailure => this == MetricsStatus.failure;
}

class MetricsState extends Equatable {
  const MetricsState({
    this.status = MetricsStatus.initial,
    this.faces = const <Face3D>[],
    this.isReadingMQTT = false,
    this.humidity = 0,
    this.humidityData = const <double>[],
    this.pressure = 0,
    this.pressureData = const <double>[],
    this.temperature = 0,
    this.temperatureData = const <double>[],
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

  final MetricsStatus status;
  final List<Face3D> faces;
  final bool isReadingMQTT;

  // Sensor BME280
  final double humidity;
  final List<double> humidityData;
  final double pressure;
  final List<double> pressureData;
  final double temperature;
  final List<double> temperatureData;

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
    MetricsStatus? status,
    List<Face3D>? faces,
    bool? isReadingMQTT,
    double? humidity,
    List<double>? humidityData,
    double? pressure,
    List<double>? pressureData,
    double? temperature,
    List<double>? temperatureData,
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
      status: status ?? this.status,
      faces: faces ?? this.faces,
      isReadingMQTT: isReadingMQTT ?? this.isReadingMQTT,
      humidity: humidity ?? this.humidity,
      humidityData: humidityData ?? this.humidityData,
      pressure: pressure ?? this.pressure,
      pressureData: pressureData ?? this.pressureData,
      temperature: temperature ?? this.temperature,
      temperatureData: temperatureData ?? this.temperatureData,
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
        status,
        faces,
        isReadingMQTT,
        humidity,
        humidityData,
        pressure,
        pressureData,
        temperature,
        temperatureData,
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
