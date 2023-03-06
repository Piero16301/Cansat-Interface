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
  });

  final HistoryStatus historyStatus;
  final List<History> historyList;

  HistoryState copyWith({
    HistoryStatus? historyStatus,
    List<History>? historyList,
  }) {
    return HistoryState(
      historyStatus: historyStatus ?? this.historyStatus,
      historyList: historyList ?? this.historyList,
    );
  }

  @override
  List<Object> get props => [
        historyStatus,
        historyList,
      ];
}
