import 'package:ditredi/ditredi.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:vector_math/vector_math_64.dart';

class GyroscopeCard extends StatefulWidget {
  const GyroscopeCard({
    required this.x,
    required this.y,
    required this.z,
    super.key,
  });

  final double x;
  final double y;
  final double z;

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
      light: Vector3(-0.5, -0.5, 0.5),
      ambientLightStrength: 0.3,
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
              child: DiTreDi(
                figures: [
                  Cube3D(
                    1,
                    Vector3(0, 0, 0),
                    color: const Color(0xff0074E3),
                  ),
                ],
                controller: controller,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'X: ${widget.x.toStringAsFixed(3)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto-Medium',
                  ),
                ),
                Text(
                  'Y: ${widget.y.toStringAsFixed(3)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto-Medium',
                  ),
                ),
                Text(
                  'Z: ${widget.z.toStringAsFixed(3)}',
                  style: const TextStyle(
                    fontSize: 16,
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
