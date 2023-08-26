import 'package:flutter_test/flutter_test.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/answer.dart';

void main() {
  group('Answer', () {
    test(
      "should compare based on values of 'answer' and 'imageUrl'",
      () {
        // arrange
        const answer1 = Answer(answer: 'yes', imageUrl: 'url');
        const answer2 = Answer(answer: 'yes', imageUrl: 'url');
        const answer3 = Answer(answer: 'no', imageUrl: 'url');
        const answer4 = Answer(answer: 'yes', imageUrl: 'other url');
        // act
        // assert
        expect(answer1, answer2);
        expect(answer1, isNot(answer3));
        expect(answer1, isNot(answer4));
      },
    );
  });
}
