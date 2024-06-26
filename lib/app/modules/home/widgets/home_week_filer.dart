import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';

class HomeWeekFiler extends StatelessWidget {
  const HomeWeekFiler({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "WEEKDAY",
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 95,
          child: DatePicker(
            DateTime.now(),
            locale: "en_US",
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            monthTextStyle: const TextStyle(
              fontSize: 8,
            ),
            dayTextStyle: const TextStyle(
              fontSize: 13,
            ),
            dateTextStyle: const TextStyle(
              fontSize: 13,
            ),
          ),
        )
      ],
    );
  }
}
