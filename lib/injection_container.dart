import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:yes_or_no/core/services/answer_client.dart';
import 'package:yes_or_no/features/yes_or_no/data/datasources/answer_remote_data_source.dart';
import 'package:yes_or_no/features/yes_or_no/data/repositories/answer_repository_impl.dart';
import 'package:yes_or_no/features/yes_or_no/domain/mappers/yes_no_answer_mapper.dart';
import 'package:yes_or_no/features/yes_or_no/domain/repositories/answer_repository.dart';
import 'package:yes_or_no/features/yes_or_no/domain/usecases/get_answer.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/bloc/answer_bloc.dart';

final sl = GetIt.instance;

void init() {
  // Features - Yes or No

  //Bloc
  sl
    ..registerFactory(
      () => AnswerBloc(
        getAnswer: sl(),
      ),
    )

    // Use cases
    ..registerLazySingleton(() => GetAnswer(sl()))

    // Repository
    ..registerLazySingleton<AnswerRepository>(
      () => AnswerRepositoryImpl(
        remoteDataSource: sl(),
        yesNoAnswerMapper: sl(),
      ),
    )

    // Mappers

    ..registerLazySingleton(
      YesNoAnswerMapper.new,
    )

    // Data sources
    ..registerLazySingleton<AnswerRemoteDataSource>(
      () => AnswerRemoteDataSourceImpl(
        sl(),
      ),
    )

    // Core
    ..registerLazySingleton(
      () => AnswerClient(
        sl(),
      ),
    )

    // Others
    ..registerLazySingleton(
      Dio.new,
    );
}
