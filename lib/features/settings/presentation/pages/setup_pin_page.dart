import 'package:finance/core/util/extensions.dart';
import 'package:finance/core/widgets/pin_input_field.dart';
import 'package:finance/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:finance/features/settings/presentation/bloc/settings_event.dart';
import 'package:finance/features/settings/presentation/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SetupPinPage extends StatefulWidget {
  const SetupPinPage({super.key});

  @override
  State<SetupPinPage> createState() => _SetupPinPageState();
}

class _SetupPinPageState extends State<SetupPinPage> {
  final GlobalKey<State<PinInputField>> _pinInputKey = GlobalKey();
  final GlobalKey<State<PinInputField>> _confirmPinInputKey = GlobalKey();

  String? _firstPin;
  bool _isConfirming = false;
  bool _hasError = false;

  String _getMessage(BuildContext context) {
    if (_hasError) {
      return context.translate.settingsPinMismatchMessage;
    }
    return _isConfirming
        ? context.translate.settingsConfirmPinMessage
        : context.translate.settingsSetPinMessage;
  }

  void _onFirstPinCompleted(String pin) {
    setState(() {
      _firstPin = pin;
      _isConfirming = true;
      _hasError = false;
    });
  }

  void _onConfirmPinCompleted(String pin) {
    if (pin == _firstPin) {
      context.read<SettingsBloc>().add(EnablePinEvent(pin));
    } else {
      setState(() {
        _hasError = true;
        _firstPin = null;
        _isConfirming = false;
      });
      (_pinInputKey.currentState as dynamic)?.clear();
      (_confirmPinInputKey.currentState as dynamic)?.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translate.settingsSetupPinTitle)),
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state.status == SettingsStatus.success &&
              state.settings?.pinEnabled == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  context.translate.settingsPinEnabledSuccessMessage,
                ),
              ),
            );
            context.pop();
          } else if (state.status == SettingsStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ??
                      context.translate.settingsPinEnabledErrorMessage,
                ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32),
              Text(
                _getMessage(context),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: _hasError ? Colors.red : null,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              if (!_isConfirming)
                PinInputField(
                  key: _pinInputKey,
                  onCompleted: _onFirstPinCompleted,
                )
              else
                PinInputField(
                  key: _confirmPinInputKey,
                  onCompleted: _onConfirmPinCompleted,
                ),
              const SizedBox(height: 24),
              if (_isConfirming)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _firstPin = null;
                      _isConfirming = false;
                      _hasError = false;
                    });
                    (_confirmPinInputKey.currentState as dynamic)?.clear();
                  },
                  child: Text(context.translate.settingsPINStartOver),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
