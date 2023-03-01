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
    this.isReading = false,
    this.humidity = 0,
    this.humidityData = const <double>[],
    this.pressure = 0,
    this.pressureData = const <double>[],
    this.temperature = 0,
    this.temperatureData = const <double>[],
    this.gyroscopeX = 0,
    this.gyroscopeDataX = const <double>[],
    this.gyroscopeY = 0,
    this.gyroscopeDataY = const <double>[],
    this.gyroscopeZ = 0,
    this.gyroscopeDataZ = const <double>[],
    this.accelerationX = 0,
    this.accelerationDataX = const <double>[],
    this.accelerationY = 0,
    this.accelerationDataY = const <double>[],
    this.accelerationZ = 0,
    this.accelerationDataZ = const <double>[],
    this.altitude = 0,
    this.altitudeData = const <double>[],
    this.broker = '',
    this.port = 0,
    this.clientID = '',
    this.topic = '',
  });

  final MetricsStatus status;
  final List<Face3D> faces;
  final bool isReading;

  // Sensor BME280
  final double humidity;
  final List<double> humidityData;
  final double pressure;
  final List<double> pressureData;
  final double temperature;
  final List<double> temperatureData;

  // Sensor MPU6050
  final double gyroscopeX;
  final List<double> gyroscopeDataX;
  final double gyroscopeY;
  final List<double> gyroscopeDataY;
  final double gyroscopeZ;
  final List<double> gyroscopeDataZ;
  final double accelerationX;
  final List<double> accelerationDataX;
  final double accelerationY;
  final List<double> accelerationDataY;
  final double accelerationZ;
  final List<double> accelerationDataZ;
  final double altitude;
  final List<double> altitudeData;

  // MQTT variables
  final String broker;
  final int port;
  final String clientID;
  final String topic;

  MetricsState copyWith({
    MetricsStatus? status,
    List<Face3D>? faces,
    bool? isReading,
    double? humidity,
    List<double>? humidityData,
    double? pressure,
    List<double>? pressureData,
    double? temperature,
    List<double>? temperatureData,
    double? gyroscopeX,
    List<double>? gyroscopeDataX,
    double? gyroscopeY,
    List<double>? gyroscopeDataY,
    double? gyroscopeZ,
    List<double>? gyroscopeDataZ,
    double? accelerationX,
    List<double>? accelerationDataX,
    double? accelerationY,
    List<double>? accelerationDataY,
    double? accelerationZ,
    List<double>? accelerationDataZ,
    double? altitude,
    List<double>? altitudeData,
    String? broker,
    int? port,
    String? clientID,
    String? topic,
  }) {
    return MetricsState(
      status: status ?? this.status,
      faces: faces ?? this.faces,
      isReading: isReading ?? this.isReading,
      humidity: humidity ?? this.humidity,
      humidityData: humidityData ?? this.humidityData,
      pressure: pressure ?? this.pressure,
      pressureData: pressureData ?? this.pressureData,
      temperature: temperature ?? this.temperature,
      temperatureData: temperatureData ?? this.temperatureData,
      gyroscopeX: gyroscopeX ?? this.gyroscopeX,
      gyroscopeDataX: gyroscopeDataX ?? this.gyroscopeDataX,
      gyroscopeY: gyroscopeY ?? this.gyroscopeY,
      gyroscopeDataY: gyroscopeDataY ?? this.gyroscopeDataY,
      gyroscopeZ: gyroscopeZ ?? this.gyroscopeZ,
      gyroscopeDataZ: gyroscopeDataZ ?? this.gyroscopeDataZ,
      accelerationX: accelerationX ?? this.accelerationX,
      accelerationDataX: accelerationDataX ?? this.accelerationDataX,
      accelerationY: accelerationY ?? this.accelerationY,
      accelerationDataY: accelerationDataY ?? this.accelerationDataY,
      accelerationZ: accelerationZ ?? this.accelerationZ,
      accelerationDataZ: accelerationDataZ ?? this.accelerationDataZ,
      altitude: altitude ?? this.altitude,
      altitudeData: altitudeData ?? this.altitudeData,
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
        isReading,
        humidity,
        humidityData,
        pressure,
        pressureData,
        temperature,
        temperatureData,
        gyroscopeX,
        gyroscopeDataX,
        gyroscopeY,
        gyroscopeDataY,
        gyroscopeZ,
        gyroscopeDataZ,
        accelerationX,
        accelerationDataX,
        accelerationY,
        accelerationDataY,
        accelerationZ,
        accelerationDataZ,
        altitude,
        altitudeData,
        broker,
        port,
        clientID,
        topic,
      ];
}
