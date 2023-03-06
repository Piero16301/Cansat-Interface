import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

/// {@template history}
/// Modelo de datos para una medida de historial
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class History extends Equatable {
  /// {@macro history}
  const History({
    required this.start,
    required this.end,
    required this.humidity,
    required this.pressure,
    required this.temperature,
    required this.gyroscopeX,
    required this.gyroscopeY,
    required this.gyroscopeZ,
    required this.accelerationX,
    required this.accelerationY,
    required this.accelerationZ,
    required this.altitude,
  });

  /// Crea una instancia de [History] a partir de un [Map] json
  factory History.fromJson(Map<dynamic, dynamic> json) =>
      _$HistoryFromJson(json);

  /// Fecha de inicio de la medida
  final DateTime start;

  /// Fecha de fin de la medida
  final DateTime end;

  /// Medidas de humedad
  final List<double> humidity;

  /// Medidas de presión
  final List<double> pressure;

  /// Medidas de temperatura
  final List<double> temperature;

  /// Medidas de giroscopio en el eje X
  final List<double> gyroscopeX;

  /// Medidas de giroscopio en el eje Y
  final List<double> gyroscopeY;

  /// Medidas de giroscopio en el eje Z
  final List<double> gyroscopeZ;

  /// Medidas de aceleración en el eje X
  final List<double> accelerationX;

  /// Medidas de aceleración en el eje Y
  final List<double> accelerationY;

  /// Medidas de aceleración en el eje Z
  final List<double> accelerationZ;

  /// Medidas de altitud
  final List<double> altitude;

  @override
  List<Object> get props => [
        start,
        end,
        humidity,
        pressure,
        temperature,
        gyroscopeX,
        gyroscopeY,
        gyroscopeZ,
        accelerationX,
        accelerationY,
        accelerationZ,
        altitude,
      ];
}
