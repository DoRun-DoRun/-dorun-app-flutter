import 'package:dorun_app_flutter/features/habit/model/habit_model.dart';
import 'package:dorun_app_flutter/features/search/model/search_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine_model.g.dart';

@JsonSerializable()
class CreateRoutineModel {
  final String goal;
  final int startTime;
  final List<bool> repeatDays;
  final int? notificationTime;
  final List<SubRoutineTemplate>? subRoutines;
  final String? habitCategory;
  final List<String>? actions;

  CreateRoutineModel({
    required this.goal,
    required this.startTime,
    required this.repeatDays,
    this.notificationTime,
    required this.subRoutines,
    this.habitCategory,
    this.actions,
  });

  factory CreateRoutineModel.fromJson(Map<String, dynamic> json) =>
      _$CreateRoutineModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRoutineModelToJson(this);
}

@JsonSerializable()
class EditRoutineModel {
  final int routineId;
  final String goal;
  final int startTime;
  final List<bool> repeatDays;
  final int? notificationTime;

  EditRoutineModel({
    required this.routineId,
    required this.goal,
    required this.startTime,
    required this.repeatDays,
    this.notificationTime,
  });

  factory EditRoutineModel.fromJson(Map<String, dynamic> json) =>
      _$EditRoutineModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditRoutineModelToJson(this);
}

@JsonSerializable()
class RoutineModel {
  final int id;
  final int startTime;
  final bool isFinished;
  final String name;
  final bool isToday;
  final List<bool> repeatDays;
  final int? notificationTime;

  RoutineModel({
    required this.id,
    required this.startTime,
    required this.isFinished,
    required this.name,
    required this.isToday,
    required this.repeatDays,
    required this.notificationTime,
  });
  factory RoutineModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineModelToJson(this);
}

@JsonSerializable()
class DetailRoutineModel {
  final int id;
  final String name;
  final int totalDuration;
  final int? notificationTime;
  final List<bool> repeatDays;
  final int startTime;
  final List<SubRoutineModel> subRoutines;

  DetailRoutineModel({
    required this.notificationTime,
    required this.totalDuration,
    required this.startTime,
    required this.repeatDays,
    required this.name,
    required this.subRoutines,
    required this.id,
  });
  factory DetailRoutineModel.fromJson(Map<String, dynamic> json) =>
      _$DetailRoutineModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailRoutineModelToJson(this);
}

@JsonSerializable()
class SubRoutineModel extends SubRoutineRequestModel {
  final int id;
  final int index;

  SubRoutineModel({
    required this.id,
    required this.index,
    required super.routineId,
    required super.goal,
    required super.emoji,
    required super.duration,
  });

  SubRoutineModel copyWith({
    int? id,
    int? index,
    int? routineId,
    String? goal,
    String? emoji,
    int? duration,
  }) {
    return SubRoutineModel(
      id: id ?? this.id,
      index: index ?? this.index,
      routineId: routineId ?? this.routineId,
      goal: goal ?? this.goal,
      emoji: emoji ?? this.emoji,
      duration: duration ?? this.duration,
    );
  }

  factory SubRoutineModel.fromJson(Map<String, dynamic> json) =>
      _$SubRoutineModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SubRoutineModelToJson(this);
}

@JsonSerializable()
class SubRoutineRequestModel {
  final int routineId;
  final String goal;
  final String emoji;
  final int duration;

  SubRoutineRequestModel({
    required this.routineId,
    required this.goal,
    required this.emoji,
    required this.duration,
  });

  factory SubRoutineRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SubRoutineRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubRoutineRequestModelToJson(this);
}

@JsonSerializable()
class SubRoutineOrderModel {
  final int id;
  final int index;

  SubRoutineOrderModel({required this.id, required this.index});

  factory SubRoutineOrderModel.fromJson(Map<String, dynamic> json) =>
      _$SubRoutineOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubRoutineOrderModelToJson(this);
}

enum RoutineHistoryState { passed, complete }

class RoutineHistory {
  final int routineId;
  final List<SubRoutineHistory> histories;

  RoutineHistory({
    required this.histories,
    required this.routineId,
  });

  void setDurtaionTime(int duration, int index) {
    histories[index].duration = duration;
  }

  void setRoutineState(RoutineHistoryState state, int index) {
    histories[index].state = state;
  }
}

class SubRoutineHistory {
  SubRoutineModel subRoutine;
  int duration;
  RoutineHistoryState state;

  SubRoutineHistory({
    required this.subRoutine,
    required this.duration,
    required this.state,
  });
}

@JsonSerializable()
class RoutineReviewModel {
  final int routineId;
  final String overallRating;
  final String? comments;
  final List<SubRoutineReviewModel> subRoutineReviews;

  RoutineReviewModel({
    required this.routineId,
    required this.overallRating,
    this.comments,
    required this.subRoutineReviews,
  });

  factory RoutineReviewModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineReviewModelToJson(this);
}

@JsonSerializable()
class SubRoutineReviewModel {
  final int subRoutineId;
  final int timeSpent;
  final bool isSkipped;

  SubRoutineReviewModel({
    required this.subRoutineId,
    required this.timeSpent,
    required this.isSkipped,
  });

  factory SubRoutineReviewModel.fromJson(Map<String, dynamic> json) =>
      _$SubRoutineReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubRoutineReviewModelToJson(this);
}

class RoutineCreateProgressArgs {
  final String routineGoal;
  final Duration startTime;
  final List<bool> weekDays;
  final Duration? alertTime;
  final List<SubRoutineTemplate>? subRoutines;
  final CreateHabitModel? habitModel;
  final HabitResponse? habitResponse;

  RoutineCreateProgressArgs({
    required this.routineGoal,
    required this.startTime,
    required this.weekDays,
    this.alertTime,
    this.subRoutines,
    this.habitModel,
    this.habitResponse,
  });
}
