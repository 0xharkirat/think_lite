import 'package:usage_stats/usage_stats.dart';

Future<Map<String, UsageInfo>> getCurrentUsageStats() async{
  DateTime endDate = DateTime.now();
  DateTime startDate = endDate.subtract(const Duration(minutes: 3));

  Map<String, UsageInfo> queryAndAggregateUsageStats = await UsageStats.queryAndAggregateUsageStats(startDate, endDate);

  List<String> keys = queryAndAggregateUsageStats.keys.toList();

  return queryAndAggregateUsageStats;
}

String? checkIfAnyAppHasBeenOpened(
    Map<String, UsageInfo> currentUsage,
    Map<String, UsageInfo> previousUsage,
    ) {
  for (String appId in currentUsage.keys) {
    if (previousUsage.containsKey(appId)) {
      UsageInfo currentAppUsage = currentUsage[appId]!;
      UsageInfo previousAppUsage = previousUsage[appId]!;

      if (currentAppUsage.lastTimeUsed != previousAppUsage.lastTimeUsed &&
          currentAppUsage.totalTimeInForeground == previousAppUsage.totalTimeInForeground) {
        return appId;
      }
    }
  }

  return null;
}