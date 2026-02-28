import 'package:finance/core/util/extensions.dart';
import 'package:finance/core/widgets/pin_input_field.dart';
import 'package:finance/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:finance/features/settings/presentation/bloc/settings_event.dart';
import 'package:finance/features/settings/presentation/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerifyPinPage extends StatefulWidget {
  final VoidCallback onSuccess;

  const VerifyPinPage({super.key, required this.onSuccess});

  @override
  State<VerifyPinPage> createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<VerifyPinPage> {
  final GlobalKey<State<PinInputField>> _pinInputKey = GlobalKey();
  int _attempts = 0;
  final int _maxAttempts = 5;

  String _getMessage(BuildContext context) {
    if (_attempts >= _maxAttempts) {
      return context.translate.pinToomanyAttemptsMessage;
    }
    if (_attempts > 0) {
      return context.translate.pinAttemptsRemainingMessage(
        _maxAttempts - _attempts,
      );
    }
    return context.translate.settingsEnterYourPin;
  }

  void _onPinCompleted(String pin) {
    context.read<SettingsBloc>().add(VerifyPinEvent(pin));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state.status == SettingsStatus.success) {
            widget.onSuccess();
          } else if (state.status == SettingsStatus.failure) {
            setState(() {
              _attempts++;
            });
            (_pinInputKey.currentState as dynamic)?.clear();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.lock,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 32),
                Text(
                  'Finance App',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _getMessage(context),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: _attempts > 0 ? Colors.red : null,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                if (_attempts < _maxAttempts)
                  PinInputField(key: _pinInputKey, onCompleted: _onPinCompleted)
                else
                  Column(
                    children: [
                      const Icon(Icons.block, size: 60, color: Colors.red),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _attempts = 0;
                          });
                        },
                        child: Text(context.translate.tryAgain),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
