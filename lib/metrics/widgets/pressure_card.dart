import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PressureCard extends StatelessWidget {
  const PressureCard({
    required this.pressure,
    required this.pressureData,
    super.key,
  });

  final double pressure;
  final List<double> pressureData;

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
                'Presión',
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
                      child: PressureChart(pressureData: pressureData),
                    ),
                    const SizedBox(width: 20),
                    PressureBarIndicator(pressure: pressure),
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

class PressureChart extends StatelessWidget {
  const PressureChart({
    required this.pressureData,
    super.key,
  });

  final List<double> pressureData;

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
        maximum: 1000,
        title: AxisTitle(
          text: 'Presión (mmHg)',
          textStyle: const TextStyle(fontSize: 12, fontFamily: 'Roboto-Medium'),
        ),
      ),
      series: [
        SplineSeries<double, double>(
          dataSource: pressureData,
          markerSettings: const MarkerSettings(isVisible: true),
          xValueMapper: (_, int index) => index.toDouble(),
          yValueMapper: (double pressure, _) => pressure,
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

class PressureBarIndicator extends StatelessWidget {
  const PressureBarIndicator({
    required this.pressure,
    super.key,
  });

  final double pressure;

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      maximum: 1000,
      interval: 200,
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
          value: 1000,
          animationDuration: 0,
          position: LinearElementPosition.inside,
          offset: 7,
          child: SizedBox(
            height: 25,
            child: Text(
              'mmHg',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto-Medium',
              ),
            ),
          ),
        ),
        LinearWidgetPointer(
          value: pressure,
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
                  pressure.toStringAsFixed(3),
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
          value: pressure,
          animationDuration: 250,
          thickness: 20,
          color: const Color(0xff0074E3).withOpacity(0.7),
        )
      ],
    );
  }
}
