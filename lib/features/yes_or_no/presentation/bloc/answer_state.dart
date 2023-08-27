part of 'answer_bloc.dart';

final class AnswerState extends Equatable {
  const AnswerState({
    this.question = const Question.pure(),
    this.lastQuestion = '',
    this.answer,
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.failure,
  });

  final Question question;
  final String lastQuestion;
  final YesNoAnswer? answer;
  final bool isValid;
  final FormzSubmissionStatus status;
  final Failure? failure;

  AnswerState copyWith({
    Question? question,
    String? lastQuestion,
    bool? isValid,
    FormzSubmissionStatus? status,
    YesNoAnswer? answer,
    Failure? failure,
  }) {
    return AnswerState(
      question: question ?? this.question,
      lastQuestion: lastQuestion ?? this.lastQuestion,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      answer: answer ?? this.answer,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props =>
      [question, lastQuestion, isValid, status, answer, failure];
}
