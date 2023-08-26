import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yes_or_no/core/error/exceptions.dart';
import 'package:yes_or_no/core/services/answer_client.dart';
import 'package:yes_or_no/features/yes_or_no/data/datasources/answer_remote_data_source.dart';
import 'package:yes_or_no/features/yes_or_no/data/models/yes_no_answer_model.dart';

class MockAnswerClient extends Mock implements AnswerClient {}

void main() {
  late MockAnswerClient mockAnswerClient;
  late AnswerRemoteDataSourceImpl answerRemoteDataSource;

  setUp(() {
    mockAnswerClient = MockAnswerClient();
    answerRemoteDataSource = AnswerRemoteDataSourceImpl(mockAnswerClient);
  });
  const tYesNoAnswerModel = YesNoAnswerModel(
    answer: 'answer',
    forced: false,
    image: 'image',
  );

  group('getAnswer', () {
    test(
      '''
        should return YesNoAnswerModel when
        AnswerClient returns YesNoAnswerModel''',
      () async {
        // arrange
        when(() => mockAnswerClient.getAnswer())
            .thenAnswer((_) async => tYesNoAnswerModel);
        // act
        final result = await answerRemoteDataSource.getAnswer();
        // assert
        expect(result, tYesNoAnswerModel);
        verify(() => mockAnswerClient.getAnswer()).called(1);
        verifyNoMoreInteractions(mockAnswerClient);
      },
    );

    test(
      '''
should throw a ServerException when AnswerClient 
      throws a ServerException''',
      () async {
        // arrange
        when(() => mockAnswerClient.getAnswer()).thenThrow(ServerException());
        // act
        final call = answerRemoteDataSource.getAnswer();
        // assert
        expect(
          () => call,
          throwsA(isA<ServerException>()),
        );
        verify(() => mockAnswerClient.getAnswer()).called(1);
        verifyNoMoreInteractions(mockAnswerClient);
      },
    );
  });
}
