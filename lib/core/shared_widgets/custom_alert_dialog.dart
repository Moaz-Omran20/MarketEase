import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.alertMessage,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  final String alertMessage;
 final VoidCallback? onYesPressed;
 final VoidCallback? onNoPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: onYesPressed,
          child: Text("Yes", style: TextStyle(color: Colors.red)),
        ),
        TextButton(onPressed: onNoPressed, child: Text("No")),
      ],
      title: Text(style: Theme.of(context).textTheme.titleMedium, alertMessage),
    );
  }
}
