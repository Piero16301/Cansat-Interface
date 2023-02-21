import 'package:cansat_interface/metrics/metrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MetricsPage extends StatelessWidget {
  const MetricsPage({
    required this.preferences,
    super.key,
  });

  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MetricsCubit(preferences),
      child: const MetricsView(),
    );
  }
}
