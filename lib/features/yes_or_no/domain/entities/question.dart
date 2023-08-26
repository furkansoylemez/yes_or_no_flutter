import 'package:formz/formz.dart';

/// Validation errors for the [Question] [FormzInput].
enum QuestionValidationError { empty }

class Question extends FormzInput<String, QuestionValidationError> {
  const Question.pure() : super.pure('');

  const Question.dirty([super.value = '']) : super.dirty();

  @override
  QuestionValidationError? validator(String? value) {
    return (value?.isNotEmpty ?? false) ? null : QuestionValidationError.empty;
  }
}
