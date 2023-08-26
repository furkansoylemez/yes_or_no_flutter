import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:yes_or_no/features/yes_or_no/data/models/yes_no_answer_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tYesNoAnswerModel = YesNoAnswerModel(
    answer: 'yes',
    forced: false,
    image:
        'https://yesno.wtf/assets/yes/5-64c2804cc48057b94fd0b3eaf323d92c.gif',
  );
  group('YesNoAnswerModel', () {
    test(
      'fromJson should return a valid model',
      () {
        // arrange
        final jsonMap =
            json.decode(fixture('yes_no_answer.json')) as Map<String, dynamic>;
        // act
        final result = YesNoAnswerModel.fromJson(jsonMap);
        // assert
        expect(result, tYesNoAnswerModel);
      },
    );

    test(
      'toJson should return a JSON map containing the proper data',
      () {
        // act
        final result = tYesNoAnswerModel.toJson();
        // assert
        final expectedMap = {
          'answer': 'yes',
          'forced': false,
          'image':
              'https://yesno.wtf/assets/yes/5-64c2804cc48057b94fd0b3eaf323d92c.gif',
        };
        expect(result, expectedMap);
      },
    );
  });
}
