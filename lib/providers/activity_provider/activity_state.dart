import 'package:grocey_tag/core/models/activity.dart';

class ActivityState {
  const ActivityState._({
    this.activities = const [],
    this.isLoading = false,
    this.error,
  });

  

  const ActivityState.initial() : this._();

  const ActivityState.loading() : this._(isLoading: true);

  const ActivityState.loaded(List<Activity> activities)
      : this._(activities: activities);

  const ActivityState.error(String error) : this._(error: error);

  ActivityState setLoading() {
    return copyWith(isLoading: true);
  }

  ActivityState clearLoading() {
    return copyWith(isLoading: false);
  }

  ActivityState setError({required String message}) {
    return copyWith(error: message);
  }

  ActivityState clearError() {
    return copyWith(error: null);
  }

  final List<Activity> activities;
  final bool isLoading;
  final String? error;

  ActivityState copyWith({
    List<Activity>? activities,
    bool? isLoading,
    String? error,
  }) {
    return ActivityState._(
      activities: activities ?? this.activities,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
