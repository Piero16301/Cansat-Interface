import 'package:cansat_interface/history/history.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.historyList.length,
              itemBuilder: (context, index) {
                return HistoryItemCard(
                  historyItem: state.historyList[index],
                  index: index,
                );
              },
            ),
          );
        } else if (state.historyStatus.isFailure) {
          return const Center(
            child: Text(
              'Error al cargar el historial',
              style: TextStyle(fontFamily: 'Roboto-Medium'),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({
    required this.historyItem,
    required this.index,
    super.key,
  });

  final History historyItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        borderRadius: BorderRadius.circular(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Column(
              children: [
                const Text(
                  'Set',
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontFamily: 'Roboto-Medium',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Inicio',
                          style: TextStyle(
                            fontFamily: 'Roboto-Medium',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('dd-MM-yyyy HH:mm:ss')
                              .format(historyItem.start),
                          style: const TextStyle(
                            fontFamily: 'Roboto-Medium',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Fin',
                          style: TextStyle(
                            fontFamily: 'Roboto-Medium',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('dd-MM-yyyy HH:mm:ss')
                              .format(historyItem.end),
                          style: const TextStyle(
                            fontFamily: 'Roboto-Medium',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Registros',
                          style: TextStyle(
                            fontFamily: 'Roboto-Medium',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${historyItem.humidity.length}',
                          style: const TextStyle(
                            fontFamily: 'Roboto-Medium',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FilledButton(
              child: const Text(
                'Guardar\ncomo Excel',
                style: TextStyle(fontFamily: 'Roboto-Medium'),
              ),
              onPressed: () => context
                  .read<HistoryCubit>()
                  .exportHistoryItemToExcel(historyItem, index + 1),
            ),
          ],
        ),
      ),
    );
  }
}
