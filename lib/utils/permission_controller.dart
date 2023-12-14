import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:usage_stats/usage_stats.dart';

class PermissionController {
  static const platform = MethodChannel('flutter.native/helper');

  Future<bool> checkPermissions() async {
    return await checkNotificationPermission() &&
        await checkUsageStatePermission();
  }


  Future<bool> checkNotificationPermission() async {
    return await Permission.notification.isGranted;
  }

  /// Ask for Notification permissions.
  Future<void> askNotificationPermission() async {
    await Permission.notification.request();
  }

  /// UsageStatePermissions...
  /// Check for usageState permission.
  Future<bool> checkUsageStatePermission() async {
    return
    (await UsageStats.checkUsagePermission() ?? false);
    // Update any Riverpod state notifier if necessary
  }

  Future<void> askForUsagePermission() async{
    await UsageStats.grantUsagePermission();
  }

  Future<bool> checkOverlayPermission() async {
    try {
      return await platform
          .invokeMethod('checkOverlayPermission')
          .then((value) {
        return value as bool;
        // Update any Riverpod state notifier if necessary

      });
    } on PlatformException catch (e) {
      // Handle exceptions
      debugPrint(e.message);
      return false;
    }
  }

  /// Ask overlay permissions.
  Future<bool> askOverlayPermission() async {
    try {
      return await platform.invokeMethod('askOverlayPermission').then((value) {
        return (value as bool);

      });
    } on PlatformException catch (e) {
      // Handle exceptions
      return false;
    }
  }

}