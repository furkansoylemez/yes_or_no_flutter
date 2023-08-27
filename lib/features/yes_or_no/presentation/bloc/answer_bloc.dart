import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:yes_or_no/core/error/failures.dart';
import 'package:yes_or_no/core/usecases/usecase.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/question.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';
import 'package:yes_or_no/features/yes_or_no/domain/usecases/get_answer.dart';

part 'answer_event.dart';
part 'answer_state.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  AnswerBloc({required GetAnswer getAnswer})
      : _getAnswer = getAnswer,
        super(const AnswerState()) {
    on<QuestionChanged>(_onQuestionChanged);
    on<QuestionSubmitted>(_onQuestionSubmitted, transformer: droppable());
  }

  final GetAnswer _getAnswer;

  FutureOr<void> _onQuestionChanged(
    QuestionChanged event,
    Emitter<AnswerState> emit,
  ) {
    final question = Question.dirty(event.question);
    emit(
      state.copyWith(
        question: question,
        isValid: Formz.validate([question]),
      ),
    );
  }

  FutureOr<void> _onQuestionSubmitted(
    QuestionSubmitted event,
    Emitter<AnswerState> emit,
  ) async {
    if (!state.isValid) return null;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await _getAnswer(NoParams());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            failure: failure,
          ),
        );
      },
      (answer) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
            lastQuestion: state.question.value,
            answer: answer,
          ),
        );
      },
    );
  }
}
