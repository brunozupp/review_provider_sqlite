import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/notifier/default_listener_notifier.dart';
import 'package:review_provider_sqlite/app/core/ui/components/todo_list_logo.dart';
import 'package:review_provider_sqlite/app/core/ui/messages.dart';
import 'package:review_provider_sqlite/app/modules/auth/login/login_controller.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/components/todo_list_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    final controller = context.read<LoginController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final listenerNotifier = DefaultListenerNotifier(
        changeNotifier: controller,
      );

      listenerNotifier.listener(
        context, 
        successCallback: (notifier, listenerInstance) {
          listenerInstance.dispose();
        },
        everCallback: (notifier, listenerInstance) {
          if(controller.hasInfo) {
            Messages.of(context).showInfo(controller.infoMessage!);
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight( // Using this the Column will have the exact size of its children's size
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const TodoListLogo(),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 40,
                        ),
                        child: Column(
                          children: [
                            TodoListField(
                              controller: _emailEC,
                              label: "Email",
                              validator: Validatorless.multiple([
                                Validatorless.required("Email is required"),
                                Validatorless.email("Email is invalid"),
                              ]),
                              focusNode: _emailFocusNode,
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
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if(_emailEC.text.isNotEmpty) {
                                      
                                      context.read<LoginController>().forgotPassword(
                                        email: _emailEC.text,
                                      );

                                    } else {
                                      _emailFocusNode.requestFocus();
                                      Messages.of(context).showError("Type the email you used to enter this app to be sent a recovery email to you");
                                    }
                                  },
                                  child: const Text("Forgot your password?"),
                                ),
                                ElevatedButton(
                                  onPressed: () {

                                    final isFormValid = _formKey.currentState?.validate() ?? false;

                                    if(isFormValid) {
                                      context.read<LoginController>().login(
                                        email: _emailEC.text, 
                                        password: _passwordEC.text,
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
                                    child: Text("Login"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F3F7),
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SignInButton(
                              Buttons.google,
                              text: "Continue with Google",
                              onPressed: () {
                                context.read<LoginController>().googleLogin();
                              },
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Do not have an account?",
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed("/register");
                                  },
                                  child: const Text("SIGN UP"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
