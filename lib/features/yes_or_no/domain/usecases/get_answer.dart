import 'package:dartz/dartz.dart';
import 'package:yes_or_no/core/error/failures.dart';
import 'package:yes_or_no/core/usecases/usecase.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';
import 'package:yes_or_no/features/yes_or_no/domain/repositories/answer_repository.dart';

class GetAnswer extends UseCase<YesNoAnswer, NoParams> {
  GetAnswer(this.repository);

  final AnswerRepository repository;

  @override
  Future<Either<Failure, YesNoAnswer>> call(NoParams params) {
    return repository.getAnswer();
  }
}
