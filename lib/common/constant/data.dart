import 'dart:io';

// const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
// const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
const emulatorIp = '10.0.2.2:3000';
const simulatorIp = '127.0.0.1:3000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;
// final ip = dotenv.get('URL');

enum RepeatCycle { daily, weekdays, weekends, custom }

List<String> weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

// const routineMockDataJson = [
//   {
//     "id": 1,
//     "totalDuration": 60,
//     "startTime":
//         "2024-07-11T10:00:00Z", // 예시로 DateTime.now().subtract(const Duration(hours: 1)) 값
//     "isFinished": false,
//     "name": "Morning Routine",
//     "subRoutines": [
//       {"id": 0, "name": "Stretching", "duration": 10, "emoji": "🤸‍♂️"},
//       {"id": 1, "name": "Jogging", "duration": 30, "emoji": "🏃‍♂️"},
//       {"id": 2, "name": "Swimming", "duration": 20, "emoji": "🏊‍♂️"}
//     ]
//   },
//   {
//     "id": 2,
//     "totalDuration": 45,
//     "startTime":
//         "2024-07-11T09:00:00Z", // 예시로 DateTime.now().subtract(const Duration(hours: 2)) 값
//     "isFinished": true,
//     "name": "Evening Routine",
//     "subRoutines": [
//       {"id": 0, "name": "Yoga", "duration": 20, "emoji": "🧘‍♂️"},
//       {"id": 1, "name": "Cycling", "duration": 25, "emoji": "🚴‍♂️"}
//     ]
//   }
// ];

// final List<RoutineModel> routineMockData = [
//   RoutineModel(
//     id: 1,
//     totalDuration: 60,
//     startTime: DateTime.now().subtract(const Duration(hours: 1)),
//     name: "Morning Routine",
//     isFinished: false,
//     subRoutines: [
//       SubRoutineModel(
//           id: 0, name: "Stretching", durationSecond: 600, emoji: "🤸‍♂️"),
//       SubRoutineModel(
//           id: 1, name: "Jogging", durationSecond: 660, emoji: "🏃‍♂️"),
//       SubRoutineModel(
//           id: 2, name: "Swimming", durationSecond: 720, emoji: "🏊‍♂️"),
//     ],
//   ),
//   RoutineModel(
//     id: 2,
//     totalDuration: 45,
//     startTime: DateTime.now().subtract(const Duration(hours: 2)),
//     name: "Evening Routine",
//     isFinished: true,
//     subRoutines: [
//       SubRoutineModel(id: 0, name: "Yoga", durationSecond: 20, emoji: "🧘‍♂️"),
//       SubRoutineModel(
//           id: 1, name: "Cycling", durationSecond: 25, emoji: "🚴‍♂️"),
//     ],
//   ),
// ];
