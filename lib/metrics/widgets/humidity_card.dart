import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HumidityCard extends StatelessWidget {
  const HumidityCard({
    required this.humidity,
    required this.humidityData,
    required this.humidityStartIndex,
    super.key,
  });

  final double humidity;
  final List<double> humidityData;
  final int humidityStartIndex;

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
                      child: HumidityChart(
                        humidityData: humidityData,
                        humidityStartIndex: humidityStartIndex,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
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
    required this.humidityStartIndex,
    super.key,
  });

  final List<double> humidityData;
  final int humidityStartIndex;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        minorGridLines: const MinorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Roboto-Medium',
        ),
        minorTickLines: const MinorTickLines(size: 0),
        title: AxisTitle(
          text: 'Tiempo (s)',
          textStyle: const TextStyle(fontSize: 12, fontFamily: 'Roboto-Medium'),
        ),
      ),
      primaryYAxis: NumericAxis(
        minorGridLines: const MinorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Roboto-Medium',
        ),
        minorTickLines: const MinorTickLines(size: 0),
        minimum: 0,
        maximum: 100,
        title: AxisTitle(
          text: 'Humedad (%)',
          textStyle: const TextStyle(fontSize: 12, fontFamily: 'Roboto-Medium'),
        ),
      ),
      series: [
        SplineSeries<double, double>(
          animationDuration: 0,
          dataSource: humidityData,
          markerSettings: const MarkerSettings(isVisible: true),
          xValueMapper: (_, int index) => humidityStartIndex + index.toDouble(),
          yValueMapper: (double humidity, _) => humidity,
          color: const Color(0xff0074E3),
          width: 2,
          splineType: SplineType.cardinal,
        ),
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: '',
        canShowMarker: false,
        format: 'point.y',
        decimalPlaces: 1,
        animationDuration: 250,
        textStyle: const TextStyle(
          fontSize: 10,
          fontFamily: 'Roboto-Medium',
        ),
      ),
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
              RotatedBox(
                quarterTurns: 1,
                child: Text(
                  humidity.toStringAsFixed(3),
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto-Medium',
                  ),
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
