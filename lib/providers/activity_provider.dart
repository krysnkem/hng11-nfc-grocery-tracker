import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/core/models/activity.dart';
import 'package:grocey_tag/services/storage.service.dart';

class ActivityStateNotifier extends StateNotifier<List<Activity>> {
  ActivityStateNotifier() : super([]);

  Future<void> readFromDb() async {
    try {
      state = await StorageService.readAllActivity();
    } catch (e) {}
  }

  Future<void> registerActivity(Activity activity) async {
    await StorageService.registerActivity(activity);
    state = [...state, activity];
  }
}
