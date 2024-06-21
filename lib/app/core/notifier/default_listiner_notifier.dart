import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:review_provider_sqlite/app/core/notifier/default_change_notifier.dart';
import 'package:review_provider_sqlite/app/core/ui/messages.dart';

typedef SuccessVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListinerNotifier listenerInstance,
);

typedef ErrorVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListinerNotifier listenerInstance,
);

class DefaultListinerNotifier {
  
  final DefaultChangeNotifier changeNotifier;

  DefaultListinerNotifier({
    required this.changeNotifier,
  });

  void listener(BuildContext context, {
    required SuccessVoidCallback successCallback,
    ErrorVoidCallback? errorCallback,
  }) {
    changeNotifier.addListener(() {

      if(changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if(changeNotifier.hasError) {
        if(errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? "Intern error!");
      } else if(changeNotifier.isSuccess) {
        successCallback(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}