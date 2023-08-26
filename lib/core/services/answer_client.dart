import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yes_or_no/features/yes_or_no/data/models/yes_no_answer_model.dart';

part 'answer_client.g.dart';

const String baseUrl = 'https://yesno.wtf';

@RestApi(baseUrl: baseUrl)
abstract class AnswerClient {
  factory AnswerClient(Dio dio, {String baseUrl}) = _AnswerClient;

  @GET('/api')
  Future<YesNoAnswerModel> getAnswer();
}
