// ignore_for_file: no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:yes_or_no/core/extensions/app_localizations.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/bloc/answer_bloc.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/widgets/widgets.dart';

class YesOrNoView extends StatefulWidget {
  const YesOrNoView({super.key});

  @override
  State<YesOrNoView> createState() => _YesOrNoViewState();
}

class _YesOrNoViewState extends State<YesOrNoView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.yesOrNo),
      ),
      body: Center(
        child: BlocConsumer<AnswerBloc, AnswerState>(
          listenWhen: (previous, current) {
            return previous.status != current.status;
          },
          listener: (context, state) {
            if (state.status == FormzSubmissionStatus.success) {
              _clear();
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state.status == FormzSubmissionStatus.inProgress)
                      const LinearProgressIndicator(),
                    if (state.status == FormzSubmissionStatus.success) ...[
                      LastQuestion(
                        lastQuestion: state.lastQuestion,
                      ),
                      const SizedBox(height: 8),
                      LastAnswer(
                        imageUrl: state.answer?.imageUrl,
                      ),
                      const SizedBox(height: 24),
                    ],
                    QuestionField(
                      controller: _controller,
                      onChanged: _questionChanged,
                    ),
                    const SizedBox(height: 8),
                    SubmitButton(
                      onPressed: state.isValid ? _submit : null,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _questionChanged(String value) {
    context.read<AnswerBloc>().add(QuestionChanged(value));
  }

  void _submit() {
    context.read<AnswerBloc>().add(const QuestionSubmitted());
  }

  void _clear() {
    _controller.clear();
    context.read<AnswerBloc>().add(const QuestionChanged(''));
  }
}
