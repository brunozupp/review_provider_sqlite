import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/auth/auth_controller.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Selector<AuthController, String>(
        selector: (_, controller) => controller.user?.displayName ?? "No name provided",
        builder: (_, value, __) {
          return Text(
            "Hi, $value!",
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}
