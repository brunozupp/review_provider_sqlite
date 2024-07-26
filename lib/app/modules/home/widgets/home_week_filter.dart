import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';
import 'package:review_provider_sqlite/app/modules/home/home_controller.dart';

import '../../../models/task_filter_enum.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>((controller) => controller.filterSelected == TaskFilterEnum.week),
      child: Column(
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
            child: Selector<HomeController, DateTime>(
              selector: (_, controller) => controller.initialDateOfWeek ?? DateTime.now(),
              builder: (context, value, child) {
                return DatePicker(
                  value,
                  locale: "en_US",
                  initialSelectedDate: value,
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
                  onDateChange: (date) {
                    context.read<HomeController>().filterByDay(date);
                  },
                );
              },
            )
          )
        ],
      ),
    );
  }
}
