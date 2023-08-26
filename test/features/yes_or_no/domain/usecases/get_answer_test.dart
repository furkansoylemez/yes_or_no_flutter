import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yes_or_no/core/usecases/usecase.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';
import 'package:yes_or_no/features/yes_or_no/domain/repositories/answer_repository.dart';
import 'package:yes_or_no/features/yes_or_no/domain/usecases/get_answer.dart';

class MockAnswerRepository extends Mock implements AnswerRepository {}

void main() {
  late GetAnswer usecase;
  late MockAnswerRepository mockAnswerRepository;

  setUp(() {
    mockAnswerRepository = MockAnswerRepository();
    usecase = GetAnswer(mockAnswerRepository);
  });

  test(
    'should get answer from the repository',
    () async {
      // arrange
      when(() => mockAnswerRepository.getAnswer()).thenAnswer(
        (_) async => const Right(YesNoAnswer(answer: 'yes', imageUrl: 'url')),
      );
      // act
      await usecase(NoParams());
      // assert
      verify(() => mockAnswerRepository.getAnswer()).called(1);
      verifyNoMoreInteractions(mockAnswerRepository);
    },
  );
}
