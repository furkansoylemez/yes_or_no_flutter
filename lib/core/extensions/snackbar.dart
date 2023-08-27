import 'package:flutter/material.dart';
import 'package:yes_or_no/core/error/failures.dart';
import 'package:yes_or_no/core/extensions/app_localizations.dart';

extension SnackbarX on BuildContext {
  void showFailureSnackbar(Failure? failure) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(_getFailureMessage(failure)),
      ),
    );
  }

  String _getFailureMessage(Failure? failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return l10n.serverFailureMessage;
      default:
        return l10n.defaultFailureMessage;
    }
  }
}
