part of 'history_cubit.dart';

enum HistoryStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == HistoryStatus.initial;
  bool get isLoading => this == HistoryStatus.loading;
  bool get isSuccess => this == HistoryStatus.success;
  bool get isFailure => this == HistoryStatus.failure;
}

class HistoryState extends Equatable {
  const HistoryState({
    this.historyStatus = HistoryStatus.initial,
    this.historyList = const <History>[],
    this.savingIndex = -1,
  });

  final HistoryStatus historyStatus;
  final List<History> historyList;
  final int savingIndex;

  HistoryState copyWith({
    HistoryStatus? historyStatus,
    List<History>? historyList,
    int? savingIndex,
  }) {
    return HistoryState(
      historyStatus: historyStatus ?? this.historyStatus,
      historyList: historyList ?? this.historyList,
      savingIndex: savingIndex ?? this.savingIndex,
    );
  }

  @override
  List<Object> get props => [
        historyStatus,
        historyList,
        savingIndex,
      ];
}
