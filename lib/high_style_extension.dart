import 'package:flutter/material.dart';
import 'package:highstyleapparel/result.dart';
import 'generated/l10n.dart';

class HighStyleProgressDialog {
  final BuildContext _context;
  bool _isDisplay = false;

  HighStyleProgressDialog(this._context);

  void showHighStyleProgressDialog() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          _isDisplay = true;

          return AlertDialog(
              content: Row(
            children: [
              const CircularProgressIndicator(),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(S.of(context).title_loading))
            ],
          ));
        });
  }

  void hideHighStyleProgressDialog() {
    if (_isDisplay) {
      Navigator.of(_context).pop();
    }
  }
}

extension ErrorDialogExtension on State {
  void showHighStyleErrorDialog(Error error, Function() onPressed) {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).title_alert),
            content: Text(error.exception.cause),
            actions: [
              TextButton(
                key: const Key("dialog_ok_button"),
                onPressed: onPressed,
                child: Text(S.of(context).title_okay),
              ),
            ],
          );
        });
  }

  void hideHighStyleErrorDialog() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}

extension SuccessDialogExtension on State {
  void showHighStyleSuccessDialog(Success success, Function() onPressed) {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).title_alert),
            content: Text(success.value as String),
            actions: [
              TextButton(
                key: const Key("dialog_ok_button"),
                onPressed: onPressed,
                child: Text(S.of(context).title_okay),
              ),
            ],
          );
        });
  }

  void hideHighStyleSuccessDialog() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
