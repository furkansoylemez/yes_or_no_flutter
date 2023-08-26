import 'package:equatable/equatable.dart';

class YesNoAnswer extends Equatable {
  const YesNoAnswer({required this.answer, required this.imageUrl});

  final String answer;
  final String imageUrl;

  @override
  List<Object?> get props => [answer, imageUrl];
}
