import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureCard extends StatelessWidget {
  const TemperatureCard({
    required this.temperature,
    super.key,
  });

  final double temperature;

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
              child: const Text('Temperatura'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: SfRadialGauge(
                  animationDuration: 250,
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(
                      interval: 5,
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
                          color: Colors.blue,
                        ),
                        GaugeRange(
                          startValue: interval1,
                          endValue: interval2,
                          startWidth: 0.265,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.265,
                          color: Colors.green,
                        ),
                        GaugeRange(
                          startValue: interval2,
                          endValue: 101,
                          startWidth: 0.265,
                          sizeUnit: GaugeSizeUnit.factor,
                          endWidth: 0.265,
                          color: Colors.red,
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
                            ),
                          ),
                        ),
                        GaugeAnnotation(
                          angle: 90,
                          positionFactor: 0.8,
                          widget: Text(
                            temperature.toStringAsFixed(2),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
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
                      axisLabelStyle: const GaugeTextStyle(fontSize: 10),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
