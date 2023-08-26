// ignore_for_file: no_default_cases

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:yes_or_no/features/yes_or_no/presentation/bloc/answer_bloc.dart';

class YesOrNoView extends StatefulWidget {
  const YesOrNoView({super.key});

  @override
  State<YesOrNoView> createState() => _YesOrNoViewState();
}

class _YesOrNoViewState extends State<YesOrNoView> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yes or No'),
      ),
      body: Center(
        child: BlocBuilder<AnswerBloc, AnswerState>(
          builder: (context, state) {
            switch (state.status) {
              case FormzSubmissionStatus.inProgress:
                return const CircularProgressIndicator();
              default:
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            hintText: 'Ask a question',
                          ),
                          onChanged: _questionChanged,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: state.isValid ? _submitAndClear : null,
                            child: const Text('Get answer'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (state.status == FormzSubmissionStatus.success) ...[
                          Text(state.answer?.answer ?? ''),
                          const SizedBox(height: 8),
                          Image.network(state.answer?.imageUrl ?? '')
                        ]
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  void _questionChanged(String value) {
    context.read<AnswerBloc>().add(QuestionChanged(value));
  }

  void _submitAndClear() {
    context.read<AnswerBloc>().add(const QuestionSubmitted());
    _controller.clear();
    context.read<AnswerBloc>().add(const QuestionChanged(''));
  }
}
