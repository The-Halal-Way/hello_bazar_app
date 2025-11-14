import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CmDateField extends StatelessWidget {
  const CmDateField(
      {super.key,
      required this.label,
      required this.controller,
      this.firstDate,
      this.lastDate});
  final String label;
  final TextEditingController controller;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        textInputAction: TextInputAction.done,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_month_outlined),
        ),
        onTap: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: firstDate ??
                DateTime.now().subtract(const Duration(days: 70 * 365)),
            lastDate: lastDate ?? DateTime.now().add(const Duration(days: 30)),
          );
          if (date == null) return;
          controller.text = DateFormat.yMMMd().format(date);
        },
      ),
    );
  }
}
