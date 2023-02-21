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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              child: Column(
                children: [
                  SettingTextField(
                    header: 'Broker MQTT',
                    placeholder: 'Broker MQTT',
                    initialValue: context.select<SettingsCubit, String>(
                      (cubit) => cubit.state.broker,
                    ),
                    onChanged: (value) =>
                        context.read<SettingsCubit>().brokerChanged(value),
                  ),
                  const SizedBox(height: 20),
                  SettingTextField(
                    header: 'Puerto',
                    placeholder: 'Puerto',
                    initialValue: context.select<SettingsCubit, String>(
                      (cubit) => cubit.state.port.toString(),
                    ),
                    onChanged: (value) =>
                        context.read<SettingsCubit>().portChanged(value),
                  ),
                  const SizedBox(height: 20),
                  SettingTextField(
                    header: 'ID Cliente',
                    placeholder: 'ID Cliente',
                    initialValue: context.select<SettingsCubit, String>(
                      (cubit) => cubit.state.clientID,
                    ),
                    onChanged: (value) =>
                        context.read<SettingsCubit>().clientIDChanged(value),
                  ),
                  const SizedBox(height: 20),
                  SettingTextField(
                    header: 'Topico',
                    placeholder: 'Topico',
                    initialValue: context.select<SettingsCubit, String>(
                      (cubit) => cubit.state.topic,
                    ),
                    onChanged: (value) =>
                        context.read<SettingsCubit>().topicChanged(value),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) => SizedBox(
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
    return TextBox(
      header: header,
      headerStyle: const TextStyle(
        fontFamily: 'Roboto-Medium',
        fontSize: 16,
      ),
      placeholder: placeholder,
      placeholderStyle: const TextStyle(
        fontFamily: 'Roboto-Medium',
        fontSize: 12,
      ),
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }
}
