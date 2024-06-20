import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';
import 'package:review_provider_sqlite/app/core/ui/components/todo_list_field.dart';
import 'package:review_provider_sqlite/app/core/ui/components/todo_list_logo.dart';
import 'package:review_provider_sqlite/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final controller = context.read<RegisterController>();

    controller.addListener(() {
      
      final success = controller.success;
      final error = controller.error;
      
      if(success) {
        Navigator.of(context).pop();
      } else if(error != null && error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Todo List",
              style: TextStyle(
                fontSize: 10,
                color: context.primaryColor,
              ),
            ),
            Text(
              "Sign up",
              style: TextStyle(
                fontSize: 15,
                color: context.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).width * 0.5,
            child: const FittedBox( // It makes that the widget child increase ou decrease its size depending on the phone's size
              fit: BoxFit.fitHeight, // It makes that the widget child increase ou decrease its size depending on the phone's size
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    controller: _emailEC, 
                    label: "Email",
                    validator: Validatorless.multiple([
                      Validatorless.required("Email is required"),
                      Validatorless.email("Email is invalid"),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    controller: _passwordEC, 
                    label: "Password",
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required("Password is required"),
                      Validatorless.min(6, "Password must have at least 6 characters")
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListField(
                    controller: _confirmPasswordEC, 
                    label: "Confirm password",
                    obscureText: true,
                    validator: Validatorless.compare(_passwordEC, "Confirm password must be the same as Password"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {

                        final isValidForm = _formKey.currentState?.validate() ?? false;

                        if(isValidForm) {

                          final email = _emailEC.text;
                          final password = _passwordEC.text;

                          context.read<RegisterController>().registerUser(
                            email: email,
                            password: password,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ), 
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Register"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
