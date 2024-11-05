import 'package:dio/dio.dart' hide Headers;
import 'package:dorun_app_flutter/features/habit/model/habit_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../../common/constant/data.dart';
import '../../../common/dio/dio.dart';

part 'habit_repository.g.dart';

final habitRepositoryProvider = Provider<HabitRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);

    return HabitRepository(dio, baseUrl: 'http://$ip/habits');
  },
);

@RestApi()
abstract class HabitRepository {
  factory HabitRepository(Dio dio, {String baseUrl}) = _HabitRepository;

  @POST('/')
  @Headers({'accessToken': 'true'})
  Future<HabitResponse> createHabit(@Body() CreateHabitModel createHabitModel);
}
