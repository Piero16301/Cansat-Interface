import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(const HistoryState());

  Future<void> getHistory() async {
    emit(state.copyWith(historyStatus: HistoryStatus.loading));
    try {
      await Future<void>.delayed(const Duration(seconds: 3));
      emit(state.copyWith(historyStatus: HistoryStatus.success));
    } catch (e) {
      emit(state.copyWith(historyStatus: HistoryStatus.failure));
    }
  }
}
