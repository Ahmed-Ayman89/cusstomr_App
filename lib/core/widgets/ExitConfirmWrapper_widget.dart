import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/ExitConfirmDialog.dart';

class ExitConfirmWrapper extends StatelessWidget {
  final Widget child;

  const ExitConfirmWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await ExitConfirmDialog.show(context);
        return false; // Prevent default back navigation, dialog handles exit
      },
      child: child,
    );
  }
}
