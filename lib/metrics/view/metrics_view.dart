// ignore_for_file: strict_raw_type

import 'dart:async';

import 'package:cansat_interface/metrics/metrics.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_server_client.dart';

class MetricsView extends StatefulWidget {
  const MetricsView({super.key});

  @override
  State<MetricsView> createState() => _MetricsViewState();
}

class _MetricsViewState extends State<MetricsView> {
  MqttServerClient? client;
  mqtt.MqttConnectionState? connectionState;
  StreamSubscription? subscription;

  @override
  Widget build(BuildContext context) {
    context.read<MetricsCubit>().initializeMQTT();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<MetricsCubit, MetricsState>(
            builder: (context, state) => Column(
              children: [
                FirstRowWidgets(
                  humidity: state.humidity,
                  humidityData: state.humidityData,
                  pressure: state.pressure,
                  pressureData: state.pressureData,
                  temperature: state.temperature,
                  temperatureData: state.temperatureData,
                ),
                const SizedBox(height: 20),
                SecondRowWidgets(
                  gyroscopeX: state.gyroscopeX,
                  gyroscopeY: state.gyroscopeY,
                  gyroscopeZ: state.gyroscopeZ,
                  accelerationX: state.accelerationX,
                  accelerationY: state.accelerationY,
                  accelerationZ: state.accelerationZ,
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<MetricsCubit, MetricsState>(
          builder: (context, state) => Positioned(
            bottom: 10,
            right: 10,
            child: ToggleButton(
              checked: state.isReadingMQTT,
              onChanged: (value) {
                context.read<MetricsCubit>().toggleMQTTReading(value: value);
                if (!state.isReadingMQTT) {
                  connectMQTT(
                    broker: state.broker,
                    clientID: state.clientID,
                    port: state.port,
                    topic: state.topic,
                  );
                } else {
                  disconnectMQTT();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      state.isReadingMQTT
                          ? FluentIcons.pause
                          : FluentIcons.play,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      state.isReadingMQTT ? 'Pausar' : 'Iniciar',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto-Medium',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> connectMQTT({
    required String broker,
    required String clientID,
    required int port,
    required String topic,
  }) async {
    try {
      client = MqttServerClient(broker, clientID);
      client!.port = port;
      client!.logging(on: false);
      client!.keepAlivePeriod = 30;
      client!.onDisconnected = onDisconnected;

      final connMess = mqtt.MqttConnectMessage()
          .withClientIdentifier(clientID)
          .startClean()
          .withWillQos(mqtt.MqttQos.atMostOnce);

      debugPrint('[MQTT client] MQTT client connecting....');
      client!.connectionMessage = connMess;

      try {
        await client!.connect();
      } catch (e) {
        debugPrint('[MQTT client] ERROR: $e');
        disconnectMQTT();
      }

      if (client!.connectionStatus!.state ==
          mqtt.MqttConnectionState.connected) {
        debugPrint('[MQTT client] connected');
        setState(() {
          connectionState = client!.connectionStatus!.state;
        });
      } else {
        debugPrint('[MQTT client] ERROR: MQTT client connection failed - '
            'disconnecting, state is ${client!.connectionStatus!.state}');
        disconnectMQTT();
      }

      subscription = client!.updates!.listen(onMessage);

      subscribeToTopic(topic);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void subscribeToTopic(String topic) {
    if (connectionState == mqtt.MqttConnectionState.connected) {
      debugPrint('[MQTT client] Subscribing to ${topic.trim()}');
      client!.subscribe(topic, mqtt.MqttQos.exactlyOnce);
    }
  }

  void onMessage(List<mqtt.MqttReceivedMessage> event) {
    debugPrint('[MQTT client] message received ${event.length}');
    final recMess = event[0].payload as mqtt.MqttPublishMessage;
    final message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    debugPrint('[MQTT client] MQTT message: topic is <${event[0].topic}>, '
        'payload is <-- $message -->');
    debugPrint(client!.connectionStatus!.state.toString());
    debugPrint('[MQTT client] message with topic: ${event[0].topic}');
    debugPrint('[MQTT client] message with message: $message');

    // Update data in cubit
    context.read<MetricsCubit>().updateMQTTData(message);
  }

  void disconnectMQTT() {
    debugPrint('[MQTT client] MQTT client disconnected');
    try {
      client!.disconnect();
    } catch (e) {
      debugPrint('[MQTT client] ERROR: $e');
    }
    onDisconnected();
  }

  void onDisconnected() {
    debugPrint('[MQTT client] onDisconnected');
    try {
      setState(() {
        connectionState = client!.connectionStatus!.state;
        client = null;
        subscription!.cancel();
        subscription = null;
      });
    } catch (e) {
      debugPrint('[MQTT client] ERROR: $e');
    }
    debugPrint('[MQTT client] MQTT client disconnected');
  }
}

class FirstRowWidgets extends StatelessWidget {
  const FirstRowWidgets({
    required this.humidity,
    required this.humidityData,
    required this.pressure,
    required this.pressureData,
    required this.temperature,
    required this.temperatureData,
    super.key,
  });

  final double humidity;
  final List<double> humidityData;
  final double pressure;
  final List<double> pressureData;
  final double temperature;
  final List<double> temperatureData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Row(
          children: [
            HumidityCard(
              humidity: humidity,
              humidityData: humidityData,
            ),
            const SizedBox(width: 20),
            PressureCard(
              pressure: pressure,
              pressureData: pressureData,
            ),
            const SizedBox(width: 20),
            TemperatureCard(
              temperature: temperature,
              temperatureData: temperatureData,
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRowWidgets extends StatelessWidget {
  const SecondRowWidgets({
    required this.gyroscopeX,
    required this.gyroscopeY,
    required this.gyroscopeZ,
    required this.accelerationX,
    required this.accelerationY,
    required this.accelerationZ,
    super.key,
  });

  final double gyroscopeX;
  final double gyroscopeY;
  final double gyroscopeZ;
  final double accelerationX;
  final double accelerationY;
  final double accelerationZ;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Row(
          children: [
            GyroscopeCard(
              x: gyroscopeX,
              y: gyroscopeY,
              z: gyroscopeZ,
            ),
            const SizedBox(width: 20),
            AccelerometerCard(
              x: accelerationX,
              y: accelerationY,
              z: accelerationZ,
            ),
          ],
        ),
      ),
    );
  }
}
