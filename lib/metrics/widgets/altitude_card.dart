import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AltitudeCard extends StatelessWidget {
  const AltitudeCard({
    required this.altitude,
    super.key,
  });

  final double altitude;

  @override
  Widget build(BuildContext context) {
    return Card(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          DefaultTextStyle(
            style: FluentTheme.of(context).typography.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            child: const Text(
              'Altitud',
              style: TextStyle(fontFamily: 'Roboto-Medium'),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SfLinearGauge(
              interval: 100,
              maximum: 700,
              orientation: LinearGaugeOrientation.vertical,
              tickPosition: LinearElementPosition.cross,
              axisTrackStyle: const LinearAxisTrackStyle(thickness: 10),
              axisLabelStyle: const TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto-Medium',
              ),
              markerPointers: [
                LinearShapePointer(
                  value: altitude,
                  width: 10,
                  color: Colors.blue,
                  position: LinearElementPosition.cross,
                  animationDuration: 250,
                ),
                const LinearWidgetPointer(
                  markerAlignment: LinearMarkerAlignment.end,
                  value: 700,
                  animationDuration: 0,
                  position: LinearElementPosition.outside,
                  offset: 7,
                  child: SizedBox(
                    height: 20,
                    child: Text(
                      'm',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto-Medium',
                      ),
                    ),
                  ),
                ),
                LinearWidgetPointer(
                  value: altitude,
                  position: LinearElementPosition.outside,
                  animationDuration: 250,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      altitude.toStringAsFixed(3),
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto-Medium',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
