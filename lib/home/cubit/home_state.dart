part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.paneIndex = 0,
    this.selectedMode = 'MQTT',
    this.selectedIcon = FluentIcons.internet_sharing,
  });

  final int paneIndex;
  final String selectedMode;
  final IconData selectedIcon;

  HomeState copyWith({
    int? paneIndex,
    String? selectedMode,
    IconData? selectedIcon,
  }) {
    return HomeState(
      paneIndex: paneIndex ?? this.paneIndex,
      selectedMode: selectedMode ?? this.selectedMode,
      selectedIcon: selectedIcon ?? this.selectedIcon,
    );
  }

  @override
  List<Object> get props => [
        paneIndex,
        selectedMode,
        selectedIcon,
      ];
}
