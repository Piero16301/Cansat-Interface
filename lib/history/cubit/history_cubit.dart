import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cansat_interface/history/history.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<void> exportHistoryItemToExcel(History historyItem, int index) async {
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

    final timeInterval = historyItem.end.difference(historyItem.start);

    final listOfListOfStrings = <List<dynamic>>[];
    for (var i = 0; i < historyItem.humidity.length; i++) {
      listOfListOfStrings.add([
        historyItem.start
            .add(
              Duration(
                milliseconds: (timeInterval.inMilliseconds /
                        historyItem.humidity.length *
                        i)
                    .round(),
              ),
            )
            .toIso8601String()
            .substring(0, 10),
        historyItem.start
            .add(
              Duration(
                milliseconds: (timeInterval.inMilliseconds /
                        historyItem.humidity.length *
                        i)
                    .round(),
              ),
            )
            .toIso8601String()
            .substring(11, 19),
        historyItem.humidity[i],
        historyItem.pressure[i],
        historyItem.temperature[i],
        historyItem.gyroscopeX[i],
        historyItem.gyroscopeY[i],
        historyItem.gyroscopeZ[i],
        historyItem.accelerationX[i],
        historyItem.accelerationY[i],
        historyItem.accelerationZ[i],
        historyItem.altitude[i],
      ]);
    }

    // Construir el archivo Excel
    final excel = Excel.createExcel()..rename('Sheet1', 'Set-$index');
    final sheetObject = excel['Set-$index']..insertRowIterables(headerRow, 0);
    final headerStyle = CellStyle(fontSize: 11, bold: true);
    final cellStyle = CellStyle(fontSize: 11);
    for (var i = 0; i < headerRow.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .cellStyle = headerStyle;
    }
    for (var i = 0; i < listOfListOfStrings.length; i++) {
      sheetObject.insertRowIterables(listOfListOfStrings[i], i + 1);
      for (var j = 0; j < listOfListOfStrings[i].length; j++) {
        sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1))
            .cellStyle = cellStyle;
      }
    }

    // Guardar el archivo Excel
    final excelBytes = excel.encode();
    final appDocDir = await getDownloadsDirectory();
    final appDocPath = appDocDir!.path;
    final file = File('$appDocPath/set-$index.xlsx');
    await file.writeAsBytes(excelBytes!);
  }
}
