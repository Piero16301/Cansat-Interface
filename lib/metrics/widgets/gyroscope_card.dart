import 'package:ditredi/ditredi.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GyroscopeCard extends StatefulWidget {
  const GyroscopeCard({
    required this.x,
    required this.y,
    required this.z,
    required this.altitude,
    required this.faces,
    super.key,
  });

  final double x;
  final double y;
  final double z;
  final double altitude;
  final List<Face3D> faces;

  @override
  State<GyroscopeCard> createState() => _GyroscopeCardState();
}

class _GyroscopeCardState extends State<GyroscopeCard> {
  @override
  Widget build(BuildContext context) {
    final controller = DiTreDiController(
      rotationX: widget.x,
      rotationY: widget.y,
      rotationZ: widget.z,
      // light: Vector3(-0.5, -0.5, 0.5),
      ambientLightStrength: 0.4,
      userScale: 2,
    );

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
                'Giroscopio',
                style: TextStyle(fontFamily: 'Roboto-Medium'),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'X\n${widget.x.toStringAsFixed(3)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto-Medium',
                        ),
                      ),
                      Text(
                        'Y\n${widget.y.toStringAsFixed(3)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto-Medium',
                        ),
                      ),
                      Text(
                        'Z\n${widget.z.toStringAsFixed(3)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto-Medium',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: widget.faces.isEmpty
                        ? const SizedBox(
                            width: double.infinity,
                            child: Center(child: ProgressRing()),
                          )
                        : DiTreDi(
                            figures: [
                              Mesh3D(widget.faces),
                            ],
                            controller: controller,
                          ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: double.infinity,
                    child: AltitudeGauge(altitude: widget.altitude),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AltitudeGauge extends StatelessWidget {
  const AltitudeGauge({
    required this.altitude,
    super.key,
  });

  final double altitude;

  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
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
    );
  }
}
