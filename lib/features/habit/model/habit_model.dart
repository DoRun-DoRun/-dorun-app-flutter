import 'package:json_annotation/json_annotation.dart';

part 'habit_model.g.dart';

@JsonSerializable()
class CreateHabitModel {
  String habitGoal;
  String habitCategory;

  CreateHabitModel({
    required this.habitGoal,
    required this.habitCategory,
  });

  factory CreateHabitModel.fromJson(Map<String, dynamic> json) =>
      _$CreateHabitModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateHabitModelToJson(this);
}

@JsonSerializable()
class HabitResponse {
  final List<String> actions;

  HabitResponse({required this.actions});

  factory HabitResponse.fromJson(Map<String, dynamic> json) =>
      _$HabitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HabitResponseToJson(this);
}
