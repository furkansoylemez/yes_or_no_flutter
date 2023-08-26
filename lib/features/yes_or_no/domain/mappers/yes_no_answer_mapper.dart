import 'package:yes_or_no/core/mappers/mapper.dart';
import 'package:yes_or_no/features/yes_or_no/data/models/yes_no_answer_model.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';

class YesNoAnswerMapper extends Mapper<YesNoAnswer, YesNoAnswerModel> {
  @override
  YesNoAnswer toEntity(YesNoAnswerModel model) {
    return YesNoAnswer(
      answer: model.answer,
      imageUrl: model.image,
    );
  }

  @override
  YesNoAnswerModel toModel(YesNoAnswer entity) {
    return YesNoAnswerModel(
      answer: entity.answer,
      forced: false,
      image: entity.imageUrl,
    );
  }
}
