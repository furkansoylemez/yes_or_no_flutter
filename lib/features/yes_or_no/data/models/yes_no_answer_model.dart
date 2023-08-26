import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'yes_no_answer_model.g.dart';

@JsonSerializable()
class YesNoAnswerModel extends Equatable {
  const YesNoAnswerModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  factory YesNoAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$YesNoAnswerModelFromJson(json);

  final String answer;
  final bool forced;
  final String image;

  Map<String, dynamic> toJson() => _$YesNoAnswerModelToJson(this);

  @override
  List<Object?> get props => [answer, forced, image];
}
