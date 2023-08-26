import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  const Answer({required this.answer, required this.imageUrl});

  final String answer;
  final String imageUrl;

  @override
  List<Object?> get props => [answer, imageUrl];
}
