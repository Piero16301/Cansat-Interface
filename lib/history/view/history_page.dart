import 'package:cansat_interface/history/history.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    required this.collection,
    super.key,
  });

  final BoxCollection collection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HistoryCubit(collection),
      child: const HistoryView(),
    );
  }
}
