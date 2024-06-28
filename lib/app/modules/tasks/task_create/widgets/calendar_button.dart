import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';
import 'package:review_provider_sqlite/app/modules/tasks/task_create/task_create_controller.dart';

class CalendarButton extends StatelessWidget {
  CalendarButton({super.key});

  final dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {

        final currentDate = DateTime.now();

        final DateTime? selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2024),
          lastDate: DateTime(currentDate.year + 1, currentDate.month, currentDate.day),
        );

        context.read<TaskCreateController>().selectedDate = selectedDate;
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
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
            
            Selector<TaskCreateController, String>(
              selector: (_, controller) {
                if(controller.selectedDate == null) {
                  return "SELECT A DATE";
                }

                return dateFormat.format(controller.selectedDate!);
              },
              builder: (_, value, __) {
                return Text(
                  value,
                  style: context.titleStyle,
                );
              }, 
            ),
          ],
        ),
      ),
    );
  }
}
