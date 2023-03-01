import 'package:cansat_interface/settings/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Card(
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 30,
                left: 30,
                right: 10,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const SettingTextTitle(
                              title: 'Configuración MQTT',
                            ),
                            const SizedBox(height: 10),
                            SettingTextField(
                              header: 'Broker MQTT',
                              placeholder: '127.0.0.1',
                              initialValue:
                                  context.select<SettingsCubit, String>(
                                (cubit) => cubit.state.broker,
                              ),
                              onChanged: (value) => context
                                  .read<SettingsCubit>()
                                  .brokerChanged(value),
                            ),
                            const SizedBox(height: 10),
                            SettingTextField(
                              header: 'Puerto',
                              placeholder: '1883',
                              initialValue:
                                  context.select<SettingsCubit, String>(
                                (cubit) => cubit.state.port.toString(),
                              ),
                              onChanged: (value) => context
                                  .read<SettingsCubit>()
                                  .portChanged(value),
                            ),
                            const SizedBox(height: 10),
                            SettingTextField(
                              header: 'ID Cliente',
                              placeholder: 'interface',
                              initialValue:
                                  context.select<SettingsCubit, String>(
                                (cubit) => cubit.state.clientID,
                              ),
                              onChanged: (value) => context
                                  .read<SettingsCubit>()
                                  .clientIDChanged(value),
                            ),
                            const SizedBox(height: 10),
                            SettingTextField(
                              header: 'Topico',
                              placeholder: 'test/topic',
                              initialValue:
                                  context.select<SettingsCubit, String>(
                                (cubit) => cubit.state.topic,
                              ),
                              onChanged: (value) => context
                                  .read<SettingsCubit>()
                                  .topicChanged(value),
                            ),
                            const SizedBox(height: 20),
                            const SettingTextTitle(
                              title: 'Configuración Serial',
                            ),
                            const SizedBox(height: 10),
                            SettingTextField(
                              header: 'Puerto Serial',
                              placeholder: 'COM5',
                              initialValue:
                                  context.select<SettingsCubit, String>(
                                (cubit) => cubit.state.serialPort,
                              ),
                              onChanged: (value) => context
                                  .read<SettingsCubit>()
                                  .serialPortChanged(value),
                            ),
                            const SizedBox(height: 10),
                            SettingTextField(
                              header: 'Baud Rate',
                              placeholder: '115200',
                              initialValue:
                                  context.select<SettingsCubit, String>(
                                (cubit) =>
                                    cubit.state.serialBaudRate.toString(),
                              ),
                              onChanged: (value) => context
                                  .read<SettingsCubit>()
                                  .serialBaudRateChanged(value),
                            ),
                            const SizedBox(height: 10),
                            SettingTextField(
                              header: 'Tamaño de bits',
                              placeholder: '8',
                              initialValue:
                                  context.select<SettingsCubit, String>(
                                (cubit) =>
                                    cubit.state.serialDataBits.toString(),
                              ),
                              onChanged: (value) => context
                                  .read<SettingsCubit>()
                                  .serialDataBitsChanged(value),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) => Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: ButtonStyle(
                            shape: ButtonState.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () => state.savingStatus.isInitial
                              ? context.read<SettingsCubit>().saveSettings()
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              state.savingStatus.isInitial
                                  ? 'Guardar'
                                  : state.savingStatus.isSaving
                                      ? 'Guardando...'
                                      : 'Guardado',
                              style: const TextStyle(
                                fontFamily: 'Roboto-Medium',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

class SettingTextTitle extends StatelessWidget {
  const SettingTextTitle({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Roboto-Medium',
          fontSize: 16,
        ),
      ),
    );
  }
}

class SettingTextField extends StatelessWidget {
  const SettingTextField({
    required this.header,
    required this.placeholder,
    required this.initialValue,
    required this.onChanged,
    super.key,
  });

  final String header;
  final String placeholder;
  final String initialValue;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: TextBox(
        header: header,
        headerStyle: const TextStyle(
          fontFamily: 'Roboto-Medium',
          fontSize: 14,
        ),
        placeholder: placeholder,
        placeholderStyle: const TextStyle(
          fontFamily: 'Roboto-Medium',
          fontSize: 12,
        ),
        style: const TextStyle(
          fontFamily: 'Roboto-Medium',
          fontSize: 12,
        ),
        initialValue: initialValue,
        onChanged: onChanged,
      ),
    );
  }
}
