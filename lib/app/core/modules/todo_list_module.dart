import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:review_provider_sqlite/app/core/modules/todo_list_page.dart';

abstract class TodoListModule {

  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  TodoListModule({
    required Map<String, WidgetBuilder> routers,
    List<SingleChildWidget>? bindings,
  })
    : _routers = routers,
      _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map((key, pageBuilder) => MapEntry(key, (_) => TodoListPage(
      page: pageBuilder,
      bindings: _bindings,
    )));
  }
}