import 'dart:async';
import 'package:flutter/material.dart';
import 'package:think_lite/screens/home_page.dart';
import 'package:think_lite/utils/permission_controller.dart';

class PermissionsPage extends StatefulWidget{

 
  const PermissionsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PermissionsPageState();
  }
}

class _PermissionsPageState extends State<PermissionsPage>{

  bool usagePermissionGranted = false;
  bool showNotificationPermissionGranted = false;
  late Timer timer;
  final permissionController = PermissionController();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async{
      usagePermissionGranted = await permissionController.checkUsageStatePermission();
      showNotificationPermissionGranted = await permissionController.checkNotificationPermission();
      setState(() {});
    });
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: screenHeight*0.07,),
            _logo(),
            SizedBox(height: screenHeight*0.03,),
            Text("Permissions Required", style: TextStyle(fontSize: screenWidth*0.06,),),
            SizedBox(height: screenHeight*0.02,),
            _aboutPermissionsSection(),
            SizedBox(height: screenHeight*0.04,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _usagePermissionWidget(),
                SizedBox(width: screenWidth*0.07,),
                _showNotificationPermissionWidget(),
              ],
            ),
            const Spacer(),
            showNotificationPermissionGranted && usagePermissionGranted ? _continueToAppButton() : const SizedBox.shrink(),
            SizedBox(height: screenHeight*0.02,)
          ],
        )
    );

  }

  Widget _logo(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: SizedBox(
          height: screenHeight*0.15,
          width: screenWidth*0.6,
          child: const Icon(Icons.android)
      ),
    );
  }

  Widget _aboutPermissionsSection(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        height: screenHeight*0.33,
        width: screenWidth*0.95,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              SizedBox(height: screenHeight*0.01,),
              Row(
                children: [
                  SizedBox(width: screenWidth*0.1,),
                  CircleAvatar(
                      backgroundColor:Colors.blue,
                      radius: screenWidth*0.09,
                      child: Icon(Icons.query_stats, size: screenWidth*0.13, color: Colors.white,)
                  ),
                  SizedBox(width: screenWidth*0.04,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Usage Stats", style: TextStyle(fontSize: screenWidth*0.04,fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                      Text("To determine Application startup", style: TextStyle(fontSize: screenWidth*0.03, fontStyle: FontStyle.italic),)
                    ],
                  )
                ],
              ),
              SizedBox(height: screenHeight*0.03,),
              Row(
                children: [
                  SizedBox(width: screenWidth*0.1,),
                  CircleAvatar(
                      backgroundColor:Colors.blue,
                      radius: screenWidth*0.09,
                      child: Icon(Icons.timer, size: screenWidth*0.13, color: Colors.white,)
                  ),
                  SizedBox(width: screenWidth*0.04,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Notification Permission.", style: TextStyle(fontSize: screenWidth*0.04,fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                      Text("To popup a timer display", style: TextStyle(fontSize: screenWidth*0.03, fontStyle: FontStyle.italic),)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _continueToAppButton(){
    final double screenWidth = MediaQuery.of(context).size.width;

    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(10),
      onPressed: (showNotificationPermissionGranted && usagePermissionGranted)
          ? () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()))
          : null,
      color: Colors.white,
      disabledColor: Colors.grey,
      child: Text("Continue to App", style: TextStyle(fontSize: screenWidth*0.04, color: Colors.black),),
    );
  }
  Widget _usagePermissionWidget(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight*0.2,
      width: screenWidth*0.35,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 10,
        //color: Colors.blue,
        child: Column(
          children: [
            SizedBox(height: screenHeight*0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.query_stats, size: screenWidth*0.1, color: Colors.blue,),
                Text(" : ", style: TextStyle(fontSize: screenWidth*0.045),),
                Icon(
                  usagePermissionGranted
                      ? Icons.check_circle_sharp
                      : Icons.close_rounded,
                  color: usagePermissionGranted
                      ? Colors.green
                      : Colors.red,
                  size: screenWidth*0.1,
                )
              ],
            ),
            SizedBox(
              height: screenHeight*0.01,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              disabledColor: Colors.grey,
              onPressed: usagePermissionGranted
                  ? null
                  : () async{
                await permissionController.askForUsagePermission();
                setState(() {});
              },
              child: Text("Grant", style: TextStyle(fontSize: screenWidth*0.03, color: Colors.black),),
            )
          ],
        ),
      ),
    );
  }

  Widget _showNotificationPermissionWidget(){
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight*0.2,
      width: screenWidth*0.35,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 10,
        child: Column(
          children: [
            SizedBox(height: screenHeight*0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer, size: screenWidth*0.1, color: Colors.blue,),
                Text(" : ", style: TextStyle(fontSize: screenWidth*0.045),),
                Icon(
                  showNotificationPermissionGranted
                      ? Icons.check_circle_sharp
                      : Icons.close_rounded,
                  color: showNotificationPermissionGranted
                      ? Colors.green
                      : Colors.red,
                  size: screenWidth*0.1,
                )
              ],
            ),
            SizedBox(
              height: screenHeight*0.01,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              disabledColor: Colors.grey,
              onPressed: showNotificationPermissionGranted
                  ? null
                  : () async{
                await permissionController.askNotificationPermission();
                setState(() {});
              },
              child: Text("Grant", style: TextStyle(fontSize: screenWidth*0.03, color: Colors.black),),
            )
          ],
        ),
      ),
    );
  }


}