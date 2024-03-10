import 'package:flutter/foundation.dart';
import 'activity.dart';

class ActivityModel with ChangeNotifier {
  final List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void updateActivity(Activity activity) {
    int index = _activities.indexWhere((act) => act.id == activity.id);
    if (index != -1) {
      _activities[index] = activity;
      notifyListeners();
    }
  }
}