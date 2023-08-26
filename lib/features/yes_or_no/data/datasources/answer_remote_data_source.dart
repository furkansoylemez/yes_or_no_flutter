import 'package:yes_or_no/core/error/exceptions.dart';
import 'package:yes_or_no/core/services/answer_client.dart';
import 'package:yes_or_no/features/yes_or_no/data/models/yes_no_answer_model.dart';

abstract class AnswerRemoteDataSource {
  /// Calls the endpoint via client.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<YesNoAnswerModel> getAnswer();
}

class AnswerRemoteDataSourceImpl implements AnswerRemoteDataSource {
  AnswerRemoteDataSourceImpl(this.client);

  final AnswerClient client;

  @override
  Future<YesNoAnswerModel> getAnswer() async {
    try {
      final response = await client.getAnswer();
      return response;
    } catch (e) {
      throw ServerException();
    }
  }
}
