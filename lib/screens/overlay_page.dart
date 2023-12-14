
import 'package:flutter/material.dart';
import 'package:think_lite/widgets/alert_dialog_header.dart';

class OverlayWidget extends StatelessWidget {
  const OverlayWidget({super.key});



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.black87,
        ),
        height: screenHeight * 0.5,
        width: screenWidth * 0.7,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AlertDialogHeader(),
          ],
        ),
      ),
    );
  }
}
