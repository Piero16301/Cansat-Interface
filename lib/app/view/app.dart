import 'package:cansat_interface/home/home.dart';
import 'package:cansat_interface/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({
    required this.preferences,
    required this.collection,
    super.key,
  });

  final SharedPreferences preferences;
  final BoxCollection collection;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(
        preferences: preferences,
        collection: collection,
      ),
    );
  }
}
