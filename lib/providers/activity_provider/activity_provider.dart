import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/activity.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:grocey_tag/services/storage/storage.service.dart';

import 'activity_state.dart';

class ActivityStateNotifier extends StateNotifier<ActivityState> {
  ActivityStateNotifier() : super(const ActivityState.initial()) {
    readFromDb();
  }

  Future<void> readFromDb() async {
    try {
      state = const ActivityState.loading();

      final activities = await StorageService.readAllActivity();
      activities.sort((a, b) => b.date.compareTo(a.date));

      state = ActivityState.loaded(activities);
    } catch (e) {
      state = state.setError(message: e.toString());
    }
  }

  Future<void> registerActivity(Activity activity) async {
    final activities = List<Activity>.from(state.activities);
    activities.add(activity);
    activities.sort((a, b) => b.date.compareTo(a.date));

    state = ActivityState.loaded(activities);
    await StorageService.registerActivity(activity);
  }

  void registerAdd(Item item) {
    registerActivity(Activity.generate(
      itemName: item.name,
      quantity: item.quantity,
      operation: Operation.add,
      metric: item.metric,
    ));
  }

  void registerSubract({required Item oldItem, required Item newItem}) {
    assert(oldItem.name == newItem.name);
    registerActivity(Activity.generate(
      itemName: oldItem.name,
      quantity: oldItem.quantity - newItem.quantity,
      operation: Operation.subtract,
      metric: oldItem.metric,
    ));
  }
}

final activityProvider =
    StateNotifierProvider<ActivityStateNotifier, ActivityState>(
  (ref) => ActivityStateNotifier(),
);
