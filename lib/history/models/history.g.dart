// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<dynamic, dynamic> json) {
  return History(
    start: DateTime.parse(json['start'] as String),
    end: DateTime.parse(json['end'] as String),
    humidity: (json['humidity'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    pressure: (json['pressure'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    temperature: (json['temperature'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    gyroscopeX: (json['gyroscopeX'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    gyroscopeY: (json['gyroscopeY'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    gyroscopeZ: (json['gyroscopeZ'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    accelerationX: (json['accelerationX'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    accelerationY: (json['accelerationY'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    accelerationZ: (json['accelerationZ'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    altitude: (json['altitude'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
  );
}
