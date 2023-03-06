import 'package:bloc/bloc.dart';
import 'package:cansat_interface/history/history.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this._collection) : super(const HistoryState());

  final BoxCollection _collection;

  Future<void> getHistory() async {
    emit(state.copyWith(historyStatus: HistoryStatus.loading));
    try {
      final metricsBox = await _collection.openBox<Map<dynamic, dynamic>>(
        'metrics',
      );
      final metricsValues = await metricsBox.getAllValues();
      final historyList = metricsValues.values.map(History.fromJson).toList();
      emit(
        state.copyWith(
          historyStatus: HistoryStatus.success,
          historyList: historyList,
        ),
      );
    } catch (e) {
      // emit(state.copyWith(historyStatus: HistoryStatus.failure));
    }
  }

  Future<void> exportHistoryItemToCSV(History historyItem, int index) async {
    final headerRow = <String>[
      'Fecha',
      'Hora',
      'Humedad',
      'Presión',
      'Temperatura',
      'Giroscopio X',
      'Giroscopio Y',
      'Giroscopio Z',
      'Aceleración X',
      'Aceleración Y',
      'Aceleración Z',
      'Altitud',
    ];

    final listOfListOfStrings = <List<String>>[];
    for (var i = 0; i < historyItem.humidity.length; i++) {
      listOfListOfStrings.add([
        historyItem.start.toIso8601String().substring(0, 10),
        historyItem.start.toIso8601String().substring(11, 19),
        historyItem.humidity[i].toString(),
        historyItem.pressure[i].toString(),
        historyItem.temperature[i].toString(),
        historyItem.gyroscopeX[i].toString(),
        historyItem.gyroscopeY[i].toString(),
        historyItem.gyroscopeZ[i].toString(),
        historyItem.accelerationX[i].toString(),
        historyItem.accelerationY[i].toString(),
        historyItem.accelerationZ[i].toString(),
        historyItem.altitude[i].toString(),
      ]);
    }

    await exportCSV.myCSV(
      headerRow,
      listOfListOfStrings,
    );
  }
}
