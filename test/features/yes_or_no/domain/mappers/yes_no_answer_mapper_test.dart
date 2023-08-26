import 'package:flutter_test/flutter_test.dart';
import 'package:yes_or_no/features/yes_or_no/data/models/yes_no_answer_model.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';
import 'package:yes_or_no/features/yes_or_no/domain/mappers/yes_no_answer_mapper.dart';

void main() {
  late YesNoAnswerMapper yesNoAnswerMapper;

  setUp(() => yesNoAnswerMapper = YesNoAnswerMapper());

  const tYesNoAnswer = YesNoAnswer(
    answer: 'answer',
    imageUrl: 'imageUrl',
  );
  const tYesNoAnswerModel = YesNoAnswerModel(
    answer: 'answer',
    forced: false,
    image: 'imageUrl',
  );
  group('YesNoAnswerMapper', () {
    test('should return YesNoAnswerModel when toModel is called', () async {
      // act
      final result = yesNoAnswerMapper.toModel(tYesNoAnswer);
      // assert
      expect(result, tYesNoAnswerModel);
    });

    test('should return YesNoAnswer when toEntity is called', () async {
      // act
      final result = yesNoAnswerMapper.toEntity(tYesNoAnswerModel);
      // assert
      expect(result, tYesNoAnswer);
    });
  });
}
