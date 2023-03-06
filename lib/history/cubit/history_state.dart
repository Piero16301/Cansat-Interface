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
  });

  final HistoryStatus historyStatus;

  HistoryState copyWith({
    HistoryStatus? historyStatus,
  }) {
    return HistoryState(
      historyStatus: historyStatus ?? this.historyStatus,
    );
  }

  @override
  List<Object> get props => [
        historyStatus,
      ];
}
