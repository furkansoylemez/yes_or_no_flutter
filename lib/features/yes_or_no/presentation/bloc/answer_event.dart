part of 'answer_bloc.dart';

sealed class AnswerEvent extends Equatable {
  const AnswerEvent();
}

final class QuestionChanged extends AnswerEvent {
  const QuestionChanged(this.question);

  final String question;

  @override
  List<Object?> get props => [question];
}

final class QuestionSubmitted extends AnswerEvent {
  const QuestionSubmitted();

  @override
  List<Object?> get props => [];
}
