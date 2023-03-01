import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureCard extends StatelessWidget {
  const TemperatureCard({
    required this.temperature,
    required this.temperatureData,
    required this.temperatureStartIndex,
    super.key,
  });

  final double temperature;
  final List<double> temperatureData;
  final int temperatureStartIndex;

  @override
  Widget build(BuildContext context) {
    const interval1 = 15.0;
    const interval2 = 30.0;

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
                'Temperatura',
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
                      child: TemperatureChart(
                        temperatureData: temperatureData,
                        temperatureStartIndex: temperatureStartIndex,
                      ),
                    ),
                    Expanded(
                      child: TemperatureRadialIndicator(
                        interval1: interval1,
                        interval2: interval2,
                        temperature: temperature,
                      ),
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

class TemperatureChart extends StatelessWidget {
  const TemperatureChart({
    required this.temperatureData,
    required this.temperatureStartIndex,
    super.key,
  });

  final List<double> temperatureData;
  final int temperatureStartIndex;

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
          text: 'Temperatura (°C)',
          textStyle: const TextStyle(fontSize: 12, fontFamily: 'Roboto-Medium'),
        ),
      ),
      series: [
        SplineSeries<double, double>(
          animationDuration: 0,
          dataSource: temperatureData,
          markerSettings: const MarkerSettings(isVisible: true),
          xValueMapper: (_, int index) =>
              temperatureStartIndex + index.toDouble(),
          yValueMapper: (double temperature, _) => temperature,
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

class TemperatureRadialIndicator extends StatelessWidget {
  const TemperatureRadialIndicator({
    required this.interval1,
    required this.interval2,
    required this.temperature,
    super.key,
  });

  final double interval1;
  final double interval2;
  final double temperature;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      animationDuration: 250,
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          interval: 10,
          minorTicksPerInterval: 4,
          showAxisLine: false,
          radiusFactor: 0.9,
          labelOffset: 8,
          maximum: 101,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: interval1,
              startWidth: 0.265,
              sizeUnit: GaugeSizeUnit.factor,
              endWidth: 0.265,
              color: Colors.blue.withOpacity(0.7),
            ),
            GaugeRange(
              startValue: interval1,
              endValue: interval2,
              startWidth: 0.265,
              sizeUnit: GaugeSizeUnit.factor,
              endWidth: 0.265,
              color: Colors.green.withOpacity(0.7),
            ),
            GaugeRange(
              startValue: interval2,
              endValue: 101,
              startWidth: 0.265,
              sizeUnit: GaugeSizeUnit.factor,
              endWidth: 0.265,
              color: Colors.red.withOpacity(0.7),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: temperature >= 30 ? 90 : 270,
              positionFactor: 0.3,
              widget: const Text(
                '°C',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto-Medium',
                ),
              ),
            ),
            GaugeAnnotation(
              angle: 90,
              positionFactor: 0.8,
              widget: Text(
                temperature.toStringAsFixed(3),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto-Medium',
                  fontSize: 20,
                ),
              ),
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: temperature,
              needleStartWidth: 0,
              needleEndWidth: 5,
              animationType: AnimationType.easeOutBack,
              enableAnimation: true,
              animationDuration: 250,
              knobStyle: KnobStyle(
                knobRadius: 0.06,
                borderColor: temperature <= interval1
                    ? Colors.blue
                    : temperature <= interval2
                        ? Colors.green
                        : Colors.red,
                color: Colors.white,
                borderWidth: 0.035,
              ),
              tailStyle: TailStyle(
                color: temperature <= interval1
                    ? Colors.blue
                    : temperature <= interval2
                        ? Colors.green
                        : Colors.red,
                width: 4,
                length: 0.15,
              ),
              needleColor: temperature <= interval1
                  ? Colors.blue
                  : temperature <= interval2
                      ? Colors.green
                      : Colors.red,
            )
          ],
          axisLabelStyle: const GaugeTextStyle(
            fontSize: 10,
            fontFamily: 'Roboto-Medium',
          ),
          majorTickStyle: const MajorTickStyle(
            length: 0.25,
            lengthUnit: GaugeSizeUnit.factor,
          ),
          minorTickStyle: const MinorTickStyle(
            length: 0.13,
            lengthUnit: GaugeSizeUnit.factor,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
