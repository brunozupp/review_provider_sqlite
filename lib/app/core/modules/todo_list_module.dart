import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:review_provider_sqlite/app/core/exceptions/navigation_exception.dart';
import 'package:review_provider_sqlite/app/core/modules/todo_list_page.dart';

abstract base class TodoListModule {

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

  // This will allow me to do the Navigation by Widget. But to get the encapsulation
  // of the bindings I pass the path so I get it right. This will be used
  // to navigate to another screen using animation.
  Widget getPage({
    required String path,
    required BuildContext context,
  }) {

    final widgetBuilder = _routers[path];

    if(widgetBuilder != null) {
      return TodoListPage(
        page: widgetBuilder,
        bindings: _bindings,
      );
    }

    throw NavigationException(
      message: "There is no path '$path' set in the routes",
    );
  }
}