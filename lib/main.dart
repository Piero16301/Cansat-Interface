import 'package:cansat_interface/app/app.dart';
import 'package:cansat_interface/bootstrap.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  bootstrap(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final preferences = await SharedPreferences.getInstance();
    return App(preferences: preferences);
  });
}
