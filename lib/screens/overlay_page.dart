
import 'package:flutter/material.dart';
import 'package:think_lite/widgets/alert_dialog_header.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        body: const Center(
          child: AlertDialogHeader(),
        ),
      ),
    );
  }
}
