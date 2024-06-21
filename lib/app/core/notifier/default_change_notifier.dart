import 'package:flutter/material.dart';

abstract class DefaultChangeNotifier extends ChangeNotifier {

  bool _loading = false;
  String? _error;
  bool _success = false;

  bool get loading => _loading;
  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;

  String? get error => _error;
  bool get hasError => _error != null;
  void setError(String error) => _error = error;
  void cleanError() => _error = null;
  
  bool get isSuccess => _success;
  void success() => _success = true;

  void resetState() {
    _loading = false;
    _error = null;
    _success = false;
  }

  void resetStateAndShowLoading() {
    resetState();
    showLoading();
  }
}