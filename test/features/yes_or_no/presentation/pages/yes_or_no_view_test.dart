import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart'; // You'll need to include the mocktail package in your pubspec.yaml
import 'package:network_image_mock/network_image_mock.dart';
import 'package:yes_or_no/core/error/failures.dart';
import 'package:yes_or_no/core/extensions/app_localizations.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/question.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/bloc/answer_bloc.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/pages/yes_or_no_view.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/widgets/widgets.dart';

class MockAnswerBloc extends MockBloc<AnswerEvent, AnswerState>
    implements AnswerBloc {}

void main() {
  group('YesOrNoView Widget', () {
    late AnswerBloc answerBloc;

    setUp(() {
      answerBloc = MockAnswerBloc();
      when(() => answerBloc.state)
          .thenReturn(const AnswerState()); // Default state
    });

    tearDown(() {
      answerBloc.close();
    });

    testWidgets('displays the title in app bar', (WidgetTester tester) async {
      await _pumpApp(tester, answerBloc);
      expect(find.text('Yes or No?'), findsOneWidget);
    });

    testWidgets('displays QuestionField and SubmitButton',
        (WidgetTester tester) async {
      await _pumpApp(tester, answerBloc);

      expect(find.byType(QuestionField), findsOneWidget);
      expect(find.byType(SubmitButton), findsOneWidget);
    });

    testWidgets('shows LinearProgressIndicator when status is inProgress',
        (WidgetTester tester) async {
      when(() => answerBloc.state).thenReturn(
        const AnswerState(status: FormzSubmissionStatus.inProgress),
      );

      await _pumpApp(tester, answerBloc);

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('shows LastQuestion and LastAnswer when status is success',
        (WidgetTester tester) async {
      when(() => answerBloc.state).thenReturn(
        const AnswerState(
          status: FormzSubmissionStatus.success,
          lastQuestion: 'Last Question',
          answer: YesNoAnswer(answer: 'Answer', imageUrl: 'ImageUrl'),
        ),
      );

      await _pumpApp(tester, answerBloc);

      expect(find.byType(LastQuestion), findsOneWidget);
      expect(find.text('Last Question'), findsOneWidget);
      expect(find.byType(LastAnswer), findsOneWidget);
    });

    testWidgets('Show snack bar when state is ServerFailure',
        (WidgetTester tester) async {
      final expectedStates = [
        const AnswerState(
          status: FormzSubmissionStatus.inProgress,
        ),
        AnswerState(
          status: FormzSubmissionStatus.failure,
          failure: ServerFailure(),
        ),
      ];

      whenListen(answerBloc, Stream.fromIterable(expectedStates));

      await _pumpApp(tester, answerBloc);
      expect(find.byType(SnackBar), findsNothing);
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('Show snack with default message when failure is null',
        (WidgetTester tester) async {
      final expectedStates = [
        const AnswerState(
          status: FormzSubmissionStatus.inProgress,
        ),
        const AnswerState(
          status: FormzSubmissionStatus.failure,
        ),
      ];

      whenListen(answerBloc, Stream.fromIterable(expectedStates));

      await _pumpApp(tester, answerBloc);
      expect(find.byType(SnackBar), findsNothing);
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('call _clear when status is success',
        (WidgetTester tester) async {
      final expectedStates = [
        const AnswerState(
          status: FormzSubmissionStatus.inProgress,
        ),
        const AnswerState(
          status: FormzSubmissionStatus.success,
        ),
      ];

      whenListen(answerBloc, Stream.fromIterable(expectedStates));

      await _pumpApp(tester, answerBloc);
      verify(() => answerBloc.add(const QuestionChanged(''))).called(1);
    });

    testWidgets('call _questionChanged when entering text in QuestionField',
        (WidgetTester tester) async {
      await _pumpApp(tester, answerBloc);

      await tester.enterText(find.byType(QuestionField), 'Question');

      verify(() => answerBloc.add(const QuestionChanged('Question'))).called(1);
    });

    testWidgets('call _submit when pressing SubmitButton',
        (WidgetTester tester) async {
      when(() => answerBloc.state).thenReturn(
        const AnswerState(
          question: Question.dirty('Question'),
          isValid: true,
        ),
      );

      await _pumpApp(tester, answerBloc);

      await tester.tap(find.byType(SubmitButton));

      expect(const QuestionSubmitted().props.length, 0);

      verify(() => answerBloc.add(const QuestionSubmitted())).called(1);
    });
  });
}

Future<void> _pumpApp(WidgetTester tester, AnswerBloc answerBloc) async {
  await mockNetworkImagesFor(
    () => tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en', 'US'),
        home: BlocProvider<AnswerBloc>(
          create: (_) => answerBloc,
          child: const YesOrNoView(),
        ),
      ),
    ),
  );
}
