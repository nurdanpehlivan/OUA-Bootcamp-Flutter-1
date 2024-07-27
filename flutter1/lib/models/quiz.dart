// lib/models/quiz.dart
class Quiz {
  final String question;
  final List<String> options;
  final String answer;

  Quiz({
    required this.question,
    required this.options,
    required this.answer,
  });
}
