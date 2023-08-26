import 'package:dartz/dartz.dart';
import 'package:yes_or_no/core/error/exceptions.dart';
import 'package:yes_or_no/core/error/failures.dart';
import 'package:yes_or_no/features/yes_or_no/data/datasources/answer_remote_data_source.dart';
import 'package:yes_or_no/features/yes_or_no/domain/entities/yes_no_answer.dart';
import 'package:yes_or_no/features/yes_or_no/domain/mappers/yes_no_answer_mapper.dart';
import 'package:yes_or_no/features/yes_or_no/domain/repositories/answer_repository.dart';

class AnswerRepositoryImpl implements AnswerRepository {
  AnswerRepositoryImpl({
    required this.remoteDataSource,
    required this.yesNoAnswerMapper,
  });

  final AnswerRemoteDataSource remoteDataSource;
  final YesNoAnswerMapper yesNoAnswerMapper;
  @override
  Future<Either<Failure, YesNoAnswer>> getAnswer() async {
    try {
      final result = await remoteDataSource.getAnswer();
      final entity = yesNoAnswerMapper.toEntity(result);
      return Right(entity);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
