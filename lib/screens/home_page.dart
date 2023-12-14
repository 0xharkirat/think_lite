import 'package:flutter/material.dart';
import 'package:think_lite/service/alert_dialog_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Think'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          AlertDialogService.createAlertDialog();
        }, child: const Text('Show overlay')),
      ),
    );
  }
}
