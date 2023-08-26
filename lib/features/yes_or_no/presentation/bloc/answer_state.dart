part of 'answer_bloc.dart';

final class AnswerState extends Equatable {
  const AnswerState({
    this.question = const Question.pure(),
    this.answer,
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final Question question;
  final YesNoAnswer? answer;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  AnswerState copyWith({
    Question? question,
    bool? isValid,
    FormzSubmissionStatus? status,
    YesNoAnswer? answer,
    String? errorMessage,
  }) {
    return AnswerState(
      question: question ?? this.question,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      answer: answer ?? this.answer,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [question, isValid, status, answer, errorMessage];
}
