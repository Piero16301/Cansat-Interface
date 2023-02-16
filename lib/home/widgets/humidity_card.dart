import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HumidityCard extends StatelessWidget {
  const HumidityCard({
    required this.humidity,
    super.key,
  });

  final double humidity;

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
                  interval: 20,
                  minorTicksPerInterval: 10,
                  axisTrackExtent: 10,
                  axisLabelStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  majorTickStyle: const LinearTickStyle(
                    length: 20,
                    thickness: 2,
                  ),
                  minorTickStyle: const LinearTickStyle(
                    length: 10,
                  ),
                  axisTrackStyle: const LinearAxisTrackStyle(
                    thickness: 50,
                    borderWidth: 4,
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
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
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
                            dimension: 16,
                            child: Image.asset(
                              'assets/images/triangle_pointer.png',
                              color: const Color(0xff0074E3),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            humidity.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
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
                      thickness: 40,
                      color: const Color(0xff0074E3).withOpacity(0.7),
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
