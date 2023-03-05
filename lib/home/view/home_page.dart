import 'package:cansat_interface/home/home.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.preferences,
    required this.collection,
    super.key,
  });

  final SharedPreferences preferences;
  final BoxCollection collection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: HomeView(
        preferences: preferences,
        collection: collection,
      ),
    );
  }
}
