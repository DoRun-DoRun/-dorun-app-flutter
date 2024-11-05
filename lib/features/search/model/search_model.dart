import 'package:dorun_app_flutter/features/habit/model/habit_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

final List<String> templateList = [
  "전체",
  "건강",
  "공부",
  "외모관리",
  "마음의 안정",
  "규칙적인 삶",
  "취미활동",
  "의료",
];

final Map<String, List<RoutineTemplate>> templateListRoutine = {
  "건강": [
    RoutineTemplate(
        goal: "매일 아침 조깅하기",
        description: "이 루틴은 매일 아침 조깅을 통해 체력을 향상시키는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "기상하기", emoji: "⏰", duration: 60),
          SubRoutineTemplate(goal: "스트레칭하기", emoji: "🤸", duration: 300),
          SubRoutineTemplate(goal: "운동복 착용하기", emoji: "👟", duration: 120),
          SubRoutineTemplate(goal: "아침 조깅하기", emoji: "🏃", duration: 1800)
        ]),
    RoutineTemplate(
        goal: "매일 물 2리터 마시기",
        description: "이 루틴은 충분한 수분 섭취를 통해 건강을 유지하는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "아침에 물 한 컵 마시기", emoji: "💧", duration: 60),
          SubRoutineTemplate(
              goal: "점심 전에 물 한 컵 마시기", emoji: "💧", duration: 60),
          SubRoutineTemplate(goal: "오후에 물 한 컵 마시기", emoji: "💧", duration: 60),
          SubRoutineTemplate(goal: "저녁에 물 한 컵 마시기", emoji: "💧", duration: 60)
        ]),
    RoutineTemplate(
        goal: "주 3회 홈트레이닝하기",
        description: "이 루틴은 집에서 주 3회 운동을 통해 근력을 강화하는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "운동 매트 준비하기", emoji: "🧘", duration: 60),
          SubRoutineTemplate(goal: "워밍업 스트레칭하기", emoji: "🔥", duration: 300),
          SubRoutineTemplate(goal: "근력 운동하기", emoji: "💪", duration: 1800),
          SubRoutineTemplate(goal: "쿨다운 스트레칭하기", emoji: "❄️", duration: 300)
        ])
  ],
  "공부": [
    RoutineTemplate(
        goal: "매일 영어 단어 암기하기",
        description: "이 루틴은 매일 영어 단어를 암기하여 어휘력을 향상시키는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "단어장 준비하기", emoji: "📘", duration: 60),
          SubRoutineTemplate(goal: "새 단어 학습하기", emoji: "📝", duration: 900),
          SubRoutineTemplate(goal: "복습하기", emoji: "🔄", duration: 600),
          SubRoutineTemplate(goal: "퀴즈 풀기", emoji: "❓", duration: 300)
        ]),
    RoutineTemplate(
        goal: "매일 코딩 연습하기",
        description: "이 루틴은 매일 코딩 연습을 통해 프로그래밍 실력을 향상시키는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "학습 목표 설정하기", emoji: "🎯", duration: 300),
          SubRoutineTemplate(goal: "코딩 문제 풀기", emoji: "💻", duration: 1800),
          SubRoutineTemplate(goal: "코드 리뷰하기", emoji: "🔍", duration: 600),
          SubRoutineTemplate(goal: "노트 정리하기", emoji: "📒", duration: 300)
        ]),
    RoutineTemplate(
        goal: "매일 독서 30분 하기",
        description: "이 루틴은 매일 30분 독서를 통해 지식을 쌓는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "책 선택하기", emoji: "📚", duration: 60),
          SubRoutineTemplate(goal: "독서하기", emoji: "📖", duration: 1800),
          SubRoutineTemplate(goal: "중요 내용 메모하기", emoji: "🖊️", duration: 300),
          SubRoutineTemplate(goal: "느낀 점 기록하기", emoji: "📝", duration: 300)
        ])
  ],
  "외모관리": [
    RoutineTemplate(
        goal: "매일 피부 관리하기",
        description: "이 루틴은 매일 피부 관리를 통해 건강한 피부를 유지하는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "클렌징하기", emoji: "🧴", duration: 300),
          SubRoutineTemplate(goal: "토너 바르기", emoji: "💧", duration: 60),
          SubRoutineTemplate(goal: "에센스 바르기", emoji: "💦", duration: 120),
          SubRoutineTemplate(goal: "수분크림 바르기", emoji: "🌿", duration: 120)
        ]),
    RoutineTemplate(
        goal: "주 2회 헤어 팩하기",
        description: "이 루틴은 주 2회 헤어 팩을 통해 모발 건강을 유지하는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "샴푸하기", emoji: "🛁", duration: 600),
          SubRoutineTemplate(goal: "헤어 팩 바르기", emoji: "💆", duration: 300),
          SubRoutineTemplate(goal: "헤어 팩 유지하기", emoji: "⏳", duration: 600),
          SubRoutineTemplate(goal: "헹구기", emoji: "🚿", duration: 300)
        ]),
    RoutineTemplate(
        goal: "매일 옷 매무새 가다듬기",
        description: "이 루틴은 매일 옷 매무새를 가다듬어 깔끔한 외모를 유지하는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "옷 다림질하기", emoji: "👔", duration: 600),
          SubRoutineTemplate(goal: "신발 닦기", emoji: "👞", duration: 300),
          SubRoutineTemplate(goal: "악세사리 정리하기", emoji: "💼", duration: 180),
          SubRoutineTemplate(goal: "거울 확인하기", emoji: "🪞", duration: 60)
        ])
  ],
  "마음의 안정": [
    RoutineTemplate(
        goal: "매일 명상하기",
        description: "이 루틴은 매일 명상을 통해 마음의 평안을 찾는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "편안한 자리 찾기", emoji: "🧘", duration: 60),
          SubRoutineTemplate(goal: "호흡 조절하기", emoji: "🌬️", duration: 300),
          SubRoutineTemplate(goal: "명상 집중하기", emoji: "🕉️", duration: 900),
          SubRoutineTemplate(goal: "마무리 스트레칭하기", emoji: "🤸", duration: 180)
        ]),
    RoutineTemplate(
        goal: "매일 감사 일기 쓰기",
        description: "이 루틴은 매일 감사한 일을 기록하여 긍정적인 마음을 유지하는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "일기장 준비하기", emoji: "📓", duration: 60),
          SubRoutineTemplate(goal: "오늘 감사한 일 생각하기", emoji: "🤔", duration: 300),
          SubRoutineTemplate(goal: "일기 쓰기", emoji: "✍️", duration: 600),
          SubRoutineTemplate(goal: "일기장 정리하기", emoji: "🗂️", duration: 60)
        ]),
    RoutineTemplate(
        goal: "주 3회 요가하기",
        description: "이 루틴은 주 3회 요가를 통해 몸과 마음의 균형을 찾는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "요가 매트 준비하기", emoji: "🧘", duration: 60),
          SubRoutineTemplate(goal: "워밍업하기", emoji: "🔥", duration: 300),
          SubRoutineTemplate(goal: "요가 자세 연습하기", emoji: "🙏", duration: 1800),
          SubRoutineTemplate(goal: "마무리 호흡하기", emoji: "🌬️", duration: 300)
        ])
  ],
  "규칙적인 삶": [
    RoutineTemplate(
        goal: "매일 같은 시간에 기상하기",
        description: "이 루틴은 매일 일정한 시간에 기상하여 규칙적인 생활을 만드는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "알람 설정하기", emoji: "⏰", duration: 60),
          SubRoutineTemplate(goal: "기상하기", emoji: "🌅", duration: 60),
          SubRoutineTemplate(goal: "침구 정리하기", emoji: "🛏️", duration: 120),
          SubRoutineTemplate(goal: "아침 준비하기", emoji: "☕", duration: 600)
        ]),
    RoutineTemplate(
        goal: "매일 식사 시간 지키기",
        description: "이 루틴은 정해진 시간에 식사하여 건강한 식습관을 만드는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "아침 식사 준비하기", emoji: "🍳", duration: 600),
          SubRoutineTemplate(goal: "점심 식사 준비하기", emoji: "🥪", duration: 600),
          SubRoutineTemplate(goal: "저녁 식사 준비하기", emoji: "🍲", duration: 600),
          SubRoutineTemplate(goal: "식사 후 설거지하기", emoji: "🍽️", duration: 300)
        ]),
    RoutineTemplate(
        goal: "매일 계획표 작성하기",
        description: "이 루틴은 하루 계획을 세워 시간을 효율적으로 사용하는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "계획표 준비하기", emoji: "📋", duration: 60),
          SubRoutineTemplate(goal: "할 일 목록 작성하기", emoji: "📝", duration: 600),
          SubRoutineTemplate(goal: "우선순위 설정하기", emoji: "🔢", duration: 300),
          SubRoutineTemplate(goal: "계획 확인하기", emoji: "👀", duration: 60)
        ])
  ],
  "취미활동": [
    RoutineTemplate(
        goal: "매일 기타 연습하기",
        description: "이 루틴은 매일 기타 연습을 통해 연주 실력을 향상시키는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "기타 조율하기", emoji: "🎸", duration: 180),
          SubRoutineTemplate(goal: "기본 스케일 연습하기", emoji: "🎶", duration: 600),
          SubRoutineTemplate(goal: "곡 연습하기", emoji: "🎵", duration: 900),
          SubRoutineTemplate(goal: "마무리 스트레칭하기", emoji: "🤸", duration: 180)
        ]),
    RoutineTemplate(
        goal: "주말에 직접 요리하기",
        description: "이 루틴은 주말마다 새로운 요리를 시도하여 요리 실력을 향상시키는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "레시피 찾기", emoji: "📖", duration: 600),
          SubRoutineTemplate(goal: "재료 준비하기", emoji: "🛒", duration: 900),
          SubRoutineTemplate(goal: "요리하기", emoji: "👩‍🍳", duration: 1800),
          SubRoutineTemplate(goal: "식사 및 정리하기", emoji: "🍽️", duration: 900)
        ]),
    RoutineTemplate(
        goal: "매일 스케치하기",
        description: "이 루틴은 매일 스케치를 통해 그림 실력을 향상시키는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "도구 준비하기", emoji: "🖌️", duration: 180),
          SubRoutineTemplate(goal: "기본 드로잉 연습하기", emoji: "✏️", duration: 900),
          SubRoutineTemplate(goal: "자유롭게 스케치하기", emoji: "🎨", duration: 900),
          SubRoutineTemplate(goal: "작품 정리하기", emoji: "🗂️", duration: 180)
        ])
  ],
  "의료": [
    RoutineTemplate(
        goal: "매일 스트레칭하기",
        description: "이 루틴은 매일 스트레칭을 통해 근육 유연성을 향상시키는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "목 스트레칭하기", emoji: "🧘", duration: 180),
          SubRoutineTemplate(goal: "어깨 스트레칭하기", emoji: "💪", duration: 180),
          SubRoutineTemplate(goal: "허리 스트레칭하기", emoji: "🔄", duration: 180),
          SubRoutineTemplate(goal: "다리 스트레칭하기", emoji: "🦵", duration: 180)
        ]),
    RoutineTemplate(
        goal: "약 복용 습관 만들기",
        description: "이 루틴은 정해진 시간에 약을 복용하여 건강을 관리하는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "약 준비하기", emoji: "💊", duration: 60),
          SubRoutineTemplate(goal: "물 한 컵 준비하기", emoji: "🥤", duration: 60),
          SubRoutineTemplate(goal: "약 복용하기", emoji: "👄", duration: 60),
          SubRoutineTemplate(goal: "복용 기록하기", emoji: "📝", duration: 60)
        ]),
    RoutineTemplate(
        goal: "주 2회 재활 운동하기",
        description: "이 루틴은 주 2회 재활 운동을 통해 건강 회복을 돕는 습관을 만듭니다.",
        subRoutines: [
          SubRoutineTemplate(goal: "운동 계획 확인하기", emoji: "📄", duration: 60),
          SubRoutineTemplate(goal: "워밍업하기", emoji: "🔥", duration: 300),
          SubRoutineTemplate(goal: "재활 운동하기", emoji: "🏋️", duration: 1800),
          SubRoutineTemplate(goal: "쿨다운하기", emoji: "❄️", duration: 300)
        ])
  ]
};

class RoutineCreateArgs {
  final RoutineTemplate? routineTemplate;
  final HabitResponse? habitResponse;
  final CreateHabitModel? habit;

  RoutineCreateArgs({this.routineTemplate, this.habitResponse, this.habit});
}

class RoutineTemplate {
  final String goal, description;
  final List<SubRoutineTemplate> subRoutines;

  RoutineTemplate({
    required this.description,
    required this.goal,
    required this.subRoutines,
  });
}

@JsonSerializable()
class SubRoutineTemplate {
  final String goal;
  final String emoji;
  final int duration;

  SubRoutineTemplate({
    required this.goal,
    required this.emoji,
    required this.duration,
  });

  factory SubRoutineTemplate.fromJson(Map<String, dynamic> json) =>
      _$SubRoutineTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$SubRoutineTemplateToJson(this);
}
