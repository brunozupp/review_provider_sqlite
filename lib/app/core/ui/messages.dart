import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';

class Messages {
  
  final BuildContext context;

  Messages._(this.context);

  factory Messages.of(BuildContext context) {
    return Messages._(context);
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void showError(String message) => _showMessage(message, Colors.red);

  void showInfo(String message) => _showMessage(message, context.primaryColor);
}