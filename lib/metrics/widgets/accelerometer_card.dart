import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AccelerometerCard extends StatelessWidget {
  const AccelerometerCard({
    required this.x,
    required this.y,
    required this.z,
    super.key,
  });

  final double x;
  final double y;
  final double z;

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
                'Acelerómetro',
                style: TextStyle(fontFamily: 'Roboto-Medium'),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AccelerometerRadialIndicator(
                      title: 'X',
                      value: x,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AccelerometerRadialIndicator(
                      title: 'Y',
                      value: y,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: AccelerometerRadialIndicator(
                      title: 'Z',
                      value: z,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  x.toStringAsFixed(3),
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto-Medium',
                  ),
                ),
                Text(
                  y.toStringAsFixed(3),
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto-Medium',
                  ),
                ),
                Text(
                  z.toStringAsFixed(3),
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto-Medium',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccelerometerRadialIndicator extends StatelessWidget {
  const AccelerometerRadialIndicator({
    required this.title,
    required this.value,
    required this.color,
    super.key,
  });

  final String title;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      animationDuration: 250,
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          interval: 60,
          minorTicksPerInterval: 4,
          showAxisLine: false,
          radiusFactor: 0.9,
          labelOffset: 8,
          maximum: 361,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 360,
              startWidth: 0.265,
              sizeUnit: GaugeSizeUnit.factor,
              endWidth: 0.265,
              color: color.withOpacity(0.7),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              positionFactor: 0.8,
              widget: Text(
                title,
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
              value: value,
              needleStartWidth: 0,
              needleEndWidth: 5,
              animationType: AnimationType.easeOutBack,
              enableAnimation: true,
              animationDuration: 250,
              knobStyle: KnobStyle(
                knobRadius: 0.06,
                borderColor: color,
                color: Colors.white,
                borderWidth: 0.035,
              ),
              tailStyle: TailStyle(
                color: color,
                width: 4,
                length: 0.15,
              ),
              needleColor: color,
            ),
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
