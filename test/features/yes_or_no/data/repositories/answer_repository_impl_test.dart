import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yes_or_no/core/error/exceptions.dart';
import 'package:yes_or_no/core/error/failures.dart';
import 'package:yes_or_no/features/yes_or_no/data/datasources/answer_remote_data_source.dart';
import 'package:yes_or_no/features/yes_or_no/data/models/yes_no_answer_model.dart';
import 'package:yes_or_no/features/yes_or_no/data/repositories/answer_repository_impl.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';
import 'package:yes_or_no/features/yes_or_no/domain/mappers/yes_no_answer_mapper.dart';

class MockAnswerRemoteDataSource extends Mock
    implements AnswerRemoteDataSource {}

class MockYesNoAnswerMapper extends Mock implements YesNoAnswerMapper {}

void main() {
  late MockAnswerRemoteDataSource mockAnswerRemoteDataSource;
  late MockYesNoAnswerMapper mockYesNoAnswerMapper;
  late AnswerRepositoryImpl answerRepositoryImpl;

  setUp(() {
    mockAnswerRemoteDataSource = MockAnswerRemoteDataSource();
    mockYesNoAnswerMapper = MockYesNoAnswerMapper();
    answerRepositoryImpl = AnswerRepositoryImpl(
      remoteDataSource: mockAnswerRemoteDataSource,
      yesNoAnswerMapper: mockYesNoAnswerMapper,
    );
  });

  const tYesNoAnswerModel =
      YesNoAnswerModel(answer: 'answer', forced: false, image: 'image');

  const tYesNoAnswer = YesNoAnswer(answer: 'answer', imageUrl: 'image');

  group('getAnswer', () {
    test(
      '''
should return YesNoAnswer when remoteDataSource 
      returns YesNoAnswerModel''',
      () async {
        // arrange
        when(() => mockAnswerRemoteDataSource.getAnswer())
            .thenAnswer((_) async => tYesNoAnswerModel);
        when(() => mockYesNoAnswerMapper.toEntity(tYesNoAnswerModel))
            .thenReturn(tYesNoAnswer);
        // act
        final result = await answerRepositoryImpl.getAnswer();
        // assert
        expect(
          result,
          const Right<Failure, YesNoAnswer>(
            tYesNoAnswer,
          ),
        );
        verify(() => mockAnswerRemoteDataSource.getAnswer()).called(1);
        verify(() => mockYesNoAnswerMapper.toEntity(tYesNoAnswerModel))
            .called(1);
        verifyNoMoreInteractions(mockAnswerRemoteDataSource);
        verifyNoMoreInteractions(mockYesNoAnswerMapper);
      },
    );

    test(
      '''
should return ServerFailure when remoteDataSource 
      throws ServerException''',
      () async {
        // arrange
        when(() => mockAnswerRemoteDataSource.getAnswer())
            .thenThrow(ServerException());
        // act
        final result = await answerRepositoryImpl.getAnswer();
        // assert
        expect(result, Left<Failure, YesNoAnswer>(ServerFailure()));
        verify(() => mockAnswerRemoteDataSource.getAnswer()).called(1);
        verifyNoMoreInteractions(mockAnswerRemoteDataSource);
        verifyZeroInteractions(mockYesNoAnswerMapper);
      },
    );
  });
}
