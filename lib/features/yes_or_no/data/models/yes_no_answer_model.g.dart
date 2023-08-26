// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yes_no_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YesNoAnswerModel _$YesNoAnswerModelFromJson(Map<String, dynamic> json) =>
    YesNoAnswerModel(
      answer: json['answer'] as String,
      forced: json['forced'] as bool,
      image: json['image'] as String,
    );

Map<String, dynamic> _$YesNoAnswerModelToJson(YesNoAnswerModel instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'forced': instance.forced,
      'image': instance.image,
    };
