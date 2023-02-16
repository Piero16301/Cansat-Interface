import 'package:cansat_interface/home/home.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      // appBar: NavigationAppBar(
      //   leading: const Icon(FluentIcons.bar_chart_vertical_fill, size: 40),
      //   title: DefaultTextStyle(
      //     style: FluentTheme.of(context).typography.subtitle!,
      //     child: const Text('CANSAT Interface'),
      //   ),
      // ),
      content: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            FirstRowWidgets(),
            SizedBox(height: 20),
            SecondRowWidgets(),
          ],
        ),
      ),
    );
  }
}

class FirstRowWidgets extends StatelessWidget {
  const FirstRowWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Row(
          children: const [
            HumidityCard(
              humidity: 65,
            ),
            SizedBox(width: 20),
            PressureCard(
              pressure: 800,
            ),
            SizedBox(width: 20),
            TemperatureCard(
              temperature: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRowWidgets extends StatelessWidget {
  const SecondRowWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Row(
          children: const [
            GyroscopeCard(),
            SizedBox(width: 20),
            AccelerometerCard(),
          ],
        ),
      ),
    );
  }
}

class GyroscopeCard extends StatelessWidget {
  const GyroscopeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: const [
            Text('Giroscopio'),
            Text('0 °'),
          ],
        ),
      ),
    );
  }
}

class AccelerometerCard extends StatelessWidget {
  const AccelerometerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: const [
            Text('Acelerómetro'),
            Text('0 m/s²'),
          ],
        ),
      ),
    );
  }
}
