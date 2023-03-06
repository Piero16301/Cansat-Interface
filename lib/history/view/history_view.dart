import 'package:cansat_interface/history/history.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HistoryCubit>().getHistory();

    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state.historyStatus.isLoading) {
          return const Center(
            child: ProgressRing(),
          );
        } else if (state.historyStatus.isSuccess) {
          return const Center(
            child: Text('History loaded'),
          );
        } else if (state.historyStatus.isFailure) {
          return const Center(
            child: Text('Failed to load history'),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
