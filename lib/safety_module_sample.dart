import 'package:flutter/material.dart';

/// Çocuklara yönelik güvenlik eğitiminde kullanılan sade içerik modeli.
class SafetyLesson {
  const SafetyLesson({
    required this.title,
    required this.description,
    required this.symbol,
  });

  final String title;
  final String description;
  final String symbol;
}

const safetyLessons = <SafetyLesson>[
  SafetyLesson(
    title: '112 Acil Çağrı',
    description: 'Gerçek bir acil durumda güvenilir bir yetişkinle 112 aranır.',
    symbol: '☎️',
  ),
  SafetyLesson(
    title: 'Kaybolursam',
    description:
        'Olduğum yerde kalır, görevli veya çocuklu bir aileden yardım isterim.',
    symbol: '🧭',
  ),
  SafetyLesson(
    title: 'Tanımadığım Kişiler',
    description:
        'Ailemden izin almadan kimseyle gitmem ve hiçbir şey kabul etmem.',
    symbol: '✋',
  ),
  SafetyLesson(
    title: 'Deprem Anı',
    description: 'Çök, kapan ve tutun hareketini yaparım.',
    symbol: '🏠',
  ),
  SafetyLesson(
    title: 'Güvenilir Yetişkin',
    description:
        'Yardıma ihtiyaç duyduğumda aileme, öğretmenime veya görevliye söylerim.',
    symbol: '🤝',
  ),
];

class SafetyLessonsPage extends StatelessWidget {
  const SafetyLessonsPage({
    super.key,
    required this.completedLessonIndexes,
    required this.onLessonCompleted,
  });

  final Set<int> completedLessonIndexes;
  final ValueChanged<int> onLessonCompleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Güvenliğim')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: safetyLessons.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final lesson = safetyLessons[index];
          final completed = completedLessonIndexes.contains(index);

          return _SafetyLessonCard(
            lesson: lesson,
            completed: completed,
            onCompleted: () => onLessonCompleted(index),
          );
        },
      ),
    );
  }
}

class _SafetyLessonCard extends StatelessWidget {
  const _SafetyLessonCard({
    required this.lesson,
    required this.completed,
    required this.onCompleted,
  });

  final SafetyLesson lesson;
  final bool completed;
  final VoidCallback onCompleted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: '${lesson.title}. ${lesson.description}',
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onCompleted,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(lesson.symbol, style: const TextStyle(fontSize: 38)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(lesson.description),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  completed
                      ? Icons.check_circle_rounded
                      : Icons.play_circle_outline_rounded,
                  color: completed ? Colors.green : colors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
