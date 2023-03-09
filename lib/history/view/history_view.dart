import 'package:cansat_interface/history/history.dart';
import 'package:ditredi/ditredi.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HistoryCubit>().getHistory();

    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {
        if (state.savingIndex != -1) {
          displayInfoBar(
            context,
            builder: (context, close) => InfoBar(
              title: const Text('Datos exportados'),
              content:
                  Text('Box ${state.savingIndex + 1} guardado en Descargas'),
              action: IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: close,
              ),
              severity: InfoBarSeverity.success,
            ),
          );
          context.read<HistoryCubit>().resetSavingIndex();
        }
      },
      builder: (context, state) {
        if (state.historyStatus.isLoading) {
          return const Center(
            child: ProgressRing(),
          );
        } else if (state.historyStatus.isSuccess) {
          if (state.historyList.isEmpty) {
            return const Center(
              child: Text(
                'No hay datos en el historial',
                style: TextStyle(fontFamily: 'Roboto-Medium'),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: state.historyList
                    .mapIndexed(
                      (e, i) => HistoryItemCard(
                        historyItem: e,
                        index: i,
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Error al cargar el historial',
              style: TextStyle(fontFamily: 'Roboto-Medium'),
            ),
          );
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
              onPressed: () => context
                  .read<HistoryCubit>()
                  .exportHistoryItemToExcel(historyItem, index),
              child: const Text(
                'Guardar\ncomo Excel',
                style: TextStyle(fontFamily: 'Roboto-Medium'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
