import 'package:fluent_ui/fluent_ui.dart';

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
              child: const Text('Acelerómetro'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'X: ${x.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto-Medium',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Y: ${y.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto-Medium',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Z: ${z.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto-Medium',
                    ),
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
