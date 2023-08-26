import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/bloc/answer_bloc.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/pages/yes_or_no_view.dart';
import 'package:yes_or_no/injection_container.dart';

class YesOrNoPage extends StatelessWidget {
  const YesOrNoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnswerBloc>(
      create: (_) => sl.get<AnswerBloc>(),
      child: const YesOrNoView(),
    );
  }
}
