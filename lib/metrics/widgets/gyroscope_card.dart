import 'package:ditredi/ditredi.dart';
import 'package:fluent_ui/fluent_ui.dart';

class GyroscopeCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final controller = DiTreDiController(
      rotationX: x,
      rotationY: y,
      rotationZ: z,
      // light: Vector3(-0.5, -0.5, 0.5),
      ambientLightStrength: 0.4,
      userScale: 1.5,
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
              child: Column(
                children: [
                  Expanded(
                    child: faces.isEmpty
                        ? const SizedBox(
                            width: double.infinity,
                            child: Center(child: ProgressRing()),
                          )
                        : DiTreDi(
                            figures: [
                              Mesh3D(faces),
                            ],
                            controller: controller,
                          ),
                  ),
                  const SizedBox(width: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'X',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto-Medium',
                            ),
                          ),
                          Text(
                            x.toStringAsFixed(3),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto-Medium',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Y',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto-Medium',
                            ),
                          ),
                          Text(
                            y.toStringAsFixed(3),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto-Medium',
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Z',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto-Medium',
                            ),
                          ),
                          Text(
                            z.toStringAsFixed(3),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto-Medium',
                            ),
                          ),
                        ],
                      ),
                    ],
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
