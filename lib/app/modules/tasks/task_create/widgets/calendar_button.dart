import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.today,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "SELECT A DATE",
            style: context.titleStyle,
          )
        ],
      ),
    );
  }
}
