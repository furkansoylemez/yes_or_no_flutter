import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yes_or_no/core/error/failures.dart';
import 'package:yes_or_no/core/usecases/usecase.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/question.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';
import 'package:yes_or_no/features/yes_or_no/domain/usecases/get_answer.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/bloc/answer_bloc.dart';

class MockGetAnswer extends Mock implements GetAnswer {}

void main() {
  late MockGetAnswer mockGetAnswer;
  late AnswerBloc answerBloc;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetAnswer = MockGetAnswer();
  });

  const tYesNoAnswer = YesNoAnswer(
    answer: 'answer',
    imageUrl: 'imageUrl',
  );

  group('AnswerBloc', () {
    test('Should be correct initial state', () {
      answerBloc = AnswerBloc(getAnswer: mockGetAnswer);
      final state = answerBloc.state;
      expect(state.question, const Question.pure());
      expect(state.lastQuestion, '');
      expect(state.answer, null);
      expect(state.failure, null);
      expect(state.status, FormzSubmissionStatus.initial);
      expect(state.isValid, false);
    });

    group('onQuestionChanged', () {
      blocTest<AnswerBloc, AnswerState>(
        '''
emits [AnswerState] with new question and 
      true isValid when QuestionChanged is added.''',
        build: () => AnswerBloc(getAnswer: mockGetAnswer),
        act: (bloc) => bloc
          ..add(const QuestionChanged('newQuestion'))
          ..add(const QuestionChanged('newQuestion2')),
        expect: () => [
          isA<AnswerState>()
              .having(
                (s) => s.question,
                'question',
                const Question.dirty('newQuestion'),
              )
              .having((s) => s.isValid, 'isValid', true),
          isA<AnswerState>()
              .having(
                (s) => s.question,
                'question',
                const Question.dirty('newQuestion2'),
              )
              .having((s) => s.isValid, 'isValid', true)
        ],
      );

      blocTest<AnswerBloc, AnswerState>(
        '''
emits [AnswerState] with empty question and 
      false isValid when QuestionChanged is added.''',
        build: () => AnswerBloc(getAnswer: mockGetAnswer),
        act: (bloc) => bloc.add(const QuestionChanged('')),
        expect: () => [
          isA<AnswerState>()
              .having(
                (s) => s.question,
                'question',
                const Question.dirty(),
              )
              .having((s) => s.isValid, 'isValid', false)
        ],
      );
    });

    group('onQuestionSubmitted', () {
      blocTest<AnswerBloc, AnswerState>(
        'should not emit any state when state is not valid',
        build: () => AnswerBloc(getAnswer: mockGetAnswer),
        act: (bloc) => bloc.add(const QuestionSubmitted()),
        expect: () => <AnswerState>[],
      );
      blocTest<AnswerBloc, AnswerState>(
        'emits nonNull answer [AnswerState] when QuestionSubmitted is added.',
        setUp: () {
          when(() => mockGetAnswer(any()))
              .thenAnswer((_) async => const Right(tYesNoAnswer));
        },
        build: () => AnswerBloc(getAnswer: mockGetAnswer),
        seed: () {
          return const AnswerState(
            question: Question.dirty('test'),
            isValid: true,
          );
        },
        act: (bloc) => bloc.add(const QuestionSubmitted()),
        expect: () => [
          isA<AnswerState>().having(
            (s) => s.status,
            'status',
            FormzSubmissionStatus.inProgress,
          ),
          isA<AnswerState>()
              .having((s) => s.answer, 'answer', tYesNoAnswer)
              .having((s) => s.lastQuestion, 'lastQuestion', 'test')
        ],
        verify: (_) {
          verify(() => mockGetAnswer(any())).called(1);
        },
      );

      blocTest<AnswerBloc, AnswerState>(
        '''emits failed [AnswerState] if failure return when QuestionSubmitted is added.''',
        setUp: () {
          when(() => mockGetAnswer(any()))
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        build: () => AnswerBloc(getAnswer: mockGetAnswer),
        seed: () {
          return const AnswerState(
            question: Question.dirty('test'),
            isValid: true,
          );
        },
        act: (bloc) => bloc.add(const QuestionSubmitted()),
        expect: () => [
          isA<AnswerState>().having(
            (s) => s.status,
            'status',
            FormzSubmissionStatus.inProgress,
          ),
          isA<AnswerState>()
              .having((s) => s.status, 'status', FormzSubmissionStatus.failure)
        ],
        verify: (_) {
          verify(() => mockGetAnswer(any())).called(1);
        },
      );

      blocTest<AnswerBloc, AnswerState>(
        'handles just one trigger if sequential QuestionSubmitted is added.',
        setUp: () {
          when(() => mockGetAnswer(any())).thenAnswer((_) async {
            await Future.delayed(const Duration(seconds: 2), () {});
            return const Right(tYesNoAnswer);
          });
        },
        wait: const Duration(seconds: 4),
        build: () => AnswerBloc(getAnswer: mockGetAnswer),
        seed: () {
          return const AnswerState(
            question: Question.dirty('test'),
            isValid: true,
          );
        },
        act: (bloc) {
          bloc
            ..add(const QuestionSubmitted())
            ..add(const QuestionSubmitted());
        },
        expect: () => [
          isA<AnswerState>().having(
            (s) => s.status,
            'status',
            FormzSubmissionStatus.inProgress,
          ),
          isA<AnswerState>().having((s) => s.answer, 'answer', tYesNoAnswer)
        ],
      );
    });
  });
}
