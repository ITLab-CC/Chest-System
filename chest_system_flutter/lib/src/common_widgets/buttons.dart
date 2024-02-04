import 'package:chest_system_flutter/src/utils/localization.dart';
import 'package:flutter/material.dart';

//TODO: Color Scheme
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.enabled = true,
  });
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      child: Text(text),
    );
  }
}

class CancleButton extends StatelessWidget {
  const CancleButton({
    required this.onPressed,
    super.key,
    this.enabled = true,
  });
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      child: Text(context.loc.cancel),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.enabled = true,
  });
  final String text;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onPressed : null,
      child: Text(text),
    );
  }
}
