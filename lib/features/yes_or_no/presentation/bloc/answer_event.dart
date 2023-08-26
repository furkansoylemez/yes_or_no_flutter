part of 'answer_bloc.dart';

sealed class AnswerEvent {
  const AnswerEvent();
}

final class QuestionChanged extends AnswerEvent {
  const QuestionChanged(this.question);

  final String question;
}

final class QuestionSubmitted extends AnswerEvent {
  const QuestionSubmitted();
}
