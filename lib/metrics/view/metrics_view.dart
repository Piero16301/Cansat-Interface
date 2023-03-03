// ignore_for_file: strict_raw_type

import 'dart:async';

import 'package:cansat_interface/metrics/metrics.dart';
import 'package:ditredi/ditredi.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
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
  StreamSubscription? mqttSubscription;

  SerialPort? port;
  SerialPortReader? reader;
  StreamSubscription? serialSubscription;

  int metricsLength = 20;

  @override
  Widget build(BuildContext context) {
    context.read<MetricsCubit>().initializeConnection();
    context.read<MetricsCubit>().load3DModel();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<MetricsCubit, MetricsState>(
            builder: (context, state) => Column(
              children: [
                FirstRowWidgets(
                  humidity: state.humidity,
                  humidityData: state.humidityData.length < metricsLength
                      ? state.humidityData
                      : state.humidityData.sublist(
                          state.humidityData.length - metricsLength,
                        ),
                  humidityStartIndex: state.humidityData.length < metricsLength
                      ? 0
                      : state.humidityData.length - metricsLength,
                  pressure: state.pressure,
                  pressureData: state.pressureData.length < metricsLength
                      ? state.pressureData
                      : state.pressureData.sublist(
                          state.pressureData.length - metricsLength,
                        ),
                  pressureStartIndex: state.pressureData.length < metricsLength
                      ? 0
                      : state.pressureData.length - metricsLength,
                  temperature: state.temperature,
                  temperatureData: state.temperatureData.length < metricsLength
                      ? state.temperatureData
                      : state.temperatureData.sublist(
                          state.temperatureData.length - metricsLength,
                        ),
                  temperatureStartIndex:
                      state.temperatureData.length < metricsLength
                          ? 0
                          : state.temperatureData.length - metricsLength,
                ),
                const SizedBox(height: 20),
                SecondRowWidgets(
                  faces: state.faces,
                  gyroscopeX: state.gyroscopeX,
                  gyroscopeY: state.gyroscopeY,
                  gyroscopeZ: state.gyroscopeZ,
                  accelerationX: state.accelerationX,
                  accelerationY: state.accelerationY,
                  accelerationZ: state.accelerationZ,
                  altitude: state.altitude,
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
              checked: state.isReading,
              onChanged: (value) {
                context.read<MetricsCubit>().toggleReading(value: value);
                if (!state.isReading) {
                  disconnectMQTT();
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
                      state.isReading ? FluentIcons.pause : FluentIcons.play,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      state.isReading ? 'Pausar' : 'Iniciar',
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
      if (mqttSubscription != null) {
        await mqttSubscription!.cancel();
        mqttSubscription = null;
      }

      if (serialSubscription != null) {
        await serialSubscription!.cancel();
        serialSubscription = null;
      }

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

      mqttSubscription = client!.updates!.listen(onMessage);

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
    context.read<MetricsCubit>().updateData(message);
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
        mqttSubscription!.cancel();
        mqttSubscription = null;
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
    required this.humidityStartIndex,
    required this.pressure,
    required this.pressureData,
    required this.pressureStartIndex,
    required this.temperature,
    required this.temperatureData,
    required this.temperatureStartIndex,
    super.key,
  });

  final double humidity;
  final List<double> humidityData;
  final int humidityStartIndex;
  final double pressure;
  final List<double> pressureData;
  final int pressureStartIndex;
  final double temperature;
  final List<double> temperatureData;
  final int temperatureStartIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Row(
          children: [
            HumidityCard(
              humidity: humidity,
              humidityData: humidityData,
              humidityStartIndex: humidityStartIndex,
            ),
            const SizedBox(width: 20),
            PressureCard(
              pressure: pressure,
              pressureData: pressureData,
              pressureStartIndex: pressureStartIndex,
            ),
            const SizedBox(width: 20),
            TemperatureCard(
              temperature: temperature,
              temperatureData: temperatureData,
              temperatureStartIndex: temperatureStartIndex,
            ),
          ],
        ),
      ),
    );
  }
}

class SecondRowWidgets extends StatelessWidget {
  const SecondRowWidgets({
    required this.faces,
    required this.gyroscopeX,
    required this.gyroscopeY,
    required this.gyroscopeZ,
    required this.accelerationX,
    required this.accelerationY,
    required this.accelerationZ,
    required this.altitude,
    super.key,
  });

  final List<Face3D> faces;
  final double gyroscopeX;
  final double gyroscopeY;
  final double gyroscopeZ;
  final double accelerationX;
  final double accelerationY;
  final double accelerationZ;
  final double altitude;

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
              faces: faces,
              altitude: altitude,
            ),
            const SizedBox(width: 20),
            AltitudeCard(
              altitude: altitude,
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
