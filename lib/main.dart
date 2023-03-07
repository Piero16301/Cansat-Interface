import 'package:cansat_interface/app/app.dart';
import 'package:cansat_interface/bootstrap.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final preferences = await SharedPreferences.getInstance();
    final docsDir = await getApplicationDocumentsDirectory();
    final collection = await BoxCollection.open(
      'CANSATTelemetry',
      {'metrics'},
      path: '${docsDir.path}/cansat-telemetry/',
    );
    return App(
      preferences: preferences,
      collection: collection,
    );
  });
}
