import 'package:flutter/material.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

Future<void> _loadingDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const LoadingDialog();
    },
  );
}

class ErrorDialog extends StatelessWidget {
  final String? message;

  const ErrorDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(message ?? 'An error occurred'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            AppRouter.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

Future<void> _errorDialog(BuildContext context, String? message) {
  return showDialog(
    context: context,
    builder: (context) {
      return ErrorDialog(message: message);
    },
  );
}

class SuccessDialog extends StatelessWidget {
  final String? message;
  final String? routeName;

  const SuccessDialog({Key? key, required this.message, this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Success'),
      content: Text(message ?? 'Operation successful'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            AppRouter.push(context, routeName!);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}

Future<void> _successDialog(BuildContext context, String? message) {
  return showDialog(
    context: context,
    builder: (context) {
      return SuccessDialog(message: message);
    },
  );
}
