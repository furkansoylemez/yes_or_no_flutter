import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ServerFailure extends Failure {}
