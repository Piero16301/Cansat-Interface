import 'package:bloc/bloc.dart';
import 'package:cansat_interface/history/history.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this._collection) : super(const HistoryState());

  final BoxCollection _collection;

  Future<void> getHistory() async {
    emit(state.copyWith(historyStatus: HistoryStatus.loading));
    try {
      final metricsBox =
          await _collection.openBox<Map<dynamic, dynamic>>('metrics');
      final metricsValues = await metricsBox.getAllValues();
      final historyList = metricsValues.values.map(History.fromJson).toList();
      emit(state.copyWith(historyStatus: HistoryStatus.success));
    } catch (e) {
      emit(state.copyWith(historyStatus: HistoryStatus.failure));
    }
  }
}
