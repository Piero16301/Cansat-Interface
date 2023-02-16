import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
            HumidityCard(),
            SizedBox(width: 20),
            PressureCard(),
            SizedBox(width: 20),
            TemperatureCard(),
          ],
        ),
      ),
    );
  }
}

class TemperatureCard extends StatelessWidget {
  const TemperatureCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            DefaultTextStyle(
              style: FluentTheme.of(context).typography.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              child: const Text('Temperatura'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class PressureCard extends StatelessWidget {
  const PressureCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            DefaultTextStyle(
              style: FluentTheme.of(context).typography.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              child: const Text('Presión'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class HumidityCard extends StatelessWidget {
  const HumidityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            DefaultTextStyle(
              style: FluentTheme.of(context).typography.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              child: const Text('Humedad'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: SfLinearGauge(
                  interval: 10,
                  minorTicksPerInterval: 5,
                  axisTrackExtent: 30,
                  axisTrackStyle: const LinearAxisTrackStyle(
                    thickness: 30,
                    borderWidth: 1,
                    edgeStyle: LinearEdgeStyle.bothCurve,
                  ),
                  tickPosition: LinearElementPosition.cross,
                  labelPosition: LinearLabelPosition.outside,
                  orientation: LinearGaugeOrientation.vertical,
                  markerPointers: const [
                    LinearWidgetPointer(
                      markerAlignment: LinearMarkerAlignment.end,
                      value: 100,
                      position: LinearElementPosition.inside,
                      offset: 10,
                      child: SizedBox(
                        height: 30,
                        child: Text(
                          '%',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                  barPointers: const [
                    LinearBarPointer(
                      value: 45,
                      animationDuration: 500,
                      thickness: 25,
                      color: Color(0xff0074E3),
                    )
                  ],
                ),
              ),
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
