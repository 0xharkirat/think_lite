import 'package:permission_handler/permission_handler.dart';
import 'package:usage_stats/usage_stats.dart';

class PermissionController {

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

}