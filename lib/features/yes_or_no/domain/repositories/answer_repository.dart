import 'package:dartz/dartz.dart';
import 'package:yes_or_no/core/error/failures.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';

// ignore: one_member_abstracts
abstract class AnswerRepository {
  Future<Either<Failure, YesNoAnswer>> getAnswer();
}
