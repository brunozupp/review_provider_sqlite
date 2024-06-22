import 'package:flutter/material.dart';

import '../todo_list_icons.dart';

class TodoListField extends StatelessWidget {

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String label;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final FocusNode? focusNode;

  final ValueNotifier<bool> obscureTextVN;

  TodoListField({
    super.key,
    this.controller,
    this.validator,
    required this.label,
    this.obscureText = false,
    this.suffixIconButton,
    this.focusNode,
  }) : 
    assert(obscureText == true ? suffixIconButton == null : true, "obscureText can not be set to true if suffixIconButton is already set"),
    obscureTextVN = ValueNotifier(obscureText);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, __) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            isDense: true,
            suffixIcon: _buildSuffixIcon(),
          ),
          obscureText: obscureTextValue,
        );
      }
    );
  }

  Widget? _buildSuffixIcon() {
    if(suffixIconButton != null) {
      return suffixIconButton!;
    }

    if(obscureText) {
      return IconButton(
        onPressed: () => obscureTextVN.value = !obscureTextVN.value, 
        icon: Icon(
          obscureTextVN.value ? TodoListIcons.eye : TodoListIcons.eye_slash,
        ),
      );
    }

    return null;
  }
}
