part of 'settings_cubit.dart';

enum SavingStatus {
  initial,
  saving,
  saved;

  bool get isInitial => this == SavingStatus.initial;
  bool get isSaving => this == SavingStatus.saving;
  bool get isSaved => this == SavingStatus.saved;
}

class SettingsState extends Equatable {
  const SettingsState({
    this.savingStatus = SavingStatus.initial,
    this.broker = '',
    this.port = 0,
    this.clientID = '',
    this.topic = '',
  });

  final SavingStatus savingStatus;
  final String broker;
  final int port;
  final String clientID;
  final String topic;

  SettingsState copyWith({
    SavingStatus? savingStatus,
    String? broker,
    int? port,
    String? clientID,
    String? topic,
  }) {
    return SettingsState(
      savingStatus: savingStatus ?? this.savingStatus,
      broker: broker ?? this.broker,
      port: port ?? this.port,
      clientID: clientID ?? this.clientID,
      topic: topic ?? this.topic,
    );
  }

  @override
  List<Object?> get props => [
        savingStatus,
        broker,
        port,
        clientID,
        topic,
      ];
}
