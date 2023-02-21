import 'package:ditredi/ditredi.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:vector_math/vector_math_64.dart';

class GyroscopeCard extends StatefulWidget {
  const GyroscopeCard({
    required this.x,
    required this.y,
    required this.z,
    required this.faces,
    super.key,
  });

  final double x;
  final double y;
  final double z;
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
