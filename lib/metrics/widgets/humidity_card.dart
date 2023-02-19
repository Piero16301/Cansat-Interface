import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HumidityCard extends StatelessWidget {
  const HumidityCard({
    required this.humidity,
    required this.humidityData,
    super.key,
  });

  final double humidity;
  final List<double> humidityData;

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
              child: const Text(
                'Humedad',
                style: TextStyle(fontFamily: 'Roboto-Medium'),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: HumidityChart(humidityData: humidityData),
                    ),
                    Expanded(
                      flex: 2,
                      child: HumidityBarIndicator(humidity: humidity),
                    ),
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

class HumidityChart extends StatelessWidget {
  const HumidityChart({
    required this.humidityData,
    super.key,
  });

  final List<double> humidityData;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        // minorGridLines: const MinorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Roboto-Medium',
        ),
        // majorTickLines: const MajorTickLines(size: 0),
        // minorTickLines: const MinorTickLines(size: 0),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        minorGridLines: const MinorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Roboto-Medium',
        ),
        majorTickLines: const MajorTickLines(size: 0),
        minorTickLines: const MinorTickLines(size: 0),
        minimum: 0,
        maximum: 100,
      ),
      series: [
        SplineSeries<double, double>(
          dataSource: humidityData,
          markerSettings: const MarkerSettings(isVisible: true),
          xValueMapper: (double humidity, _) =>
              humidityData.indexOf(humidity).toDouble(),
          yValueMapper: (double humidity, _) => humidity,
          color: const Color(0xff0074E3),
          width: 2,
        ),
      ],
    );
  }
}

class HumidityBarIndicator extends StatelessWidget {
  const HumidityBarIndicator({
    required this.humidity,
    super.key,
  });

  final double humidity;

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      interval: 20,
      minorTicksPerInterval: 10,
      axisTrackExtent: 10,
      axisLabelStyle: const TextStyle(
        fontSize: 12,
        fontFamily: 'Roboto-Medium',
      ),
      majorTickStyle: const LinearTickStyle(
        length: 20,
        thickness: 2,
      ),
      minorTickStyle: const LinearTickStyle(
        length: 10,
      ),
      axisTrackStyle: const LinearAxisTrackStyle(
        thickness: 30,
        borderWidth: 2,
      ),
      tickPosition: LinearElementPosition.cross,
      labelPosition: LinearLabelPosition.outside,
      orientation: LinearGaugeOrientation.vertical,
      markerPointers: [
        const LinearWidgetPointer(
          markerAlignment: LinearMarkerAlignment.end,
          value: 100,
          animationDuration: 0,
          position: LinearElementPosition.inside,
          offset: 7,
          child: SizedBox(
            height: 20,
            child: Text(
              '%',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto-Medium',
              ),
            ),
          ),
        ),
        LinearWidgetPointer(
          value: humidity,
          animationDuration: 250,
          position: LinearElementPosition.inside,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 5),
              SizedBox.square(
                dimension: 14,
                child: Image.asset(
                  'assets/images/triangle_pointer.png',
                  color: const Color(0xff0074E3),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                humidity.toStringAsFixed(3),
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Roboto-Medium',
                ),
              ),
            ],
          ),
        ),
      ],
      barPointers: [
        LinearBarPointer(
          value: humidity,
          animationDuration: 250,
          thickness: 20,
          color: const Color(0xff0074E3).withOpacity(0.7),
        )
      ],
    );
  }
}
