import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CmClockField extends StatelessWidget {
  const CmClockField(
      {super.key, required this.label, required this.controller});
  final String label;
  final TextEditingController controller;

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
          suffixIcon: const Icon(CupertinoIcons.clock),
        ),
        onTap: () => _onDateChange(context),
        validator: (value) {
          return null;
        },
      ),
    );
  }

  void _onDateChange(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: TimeOfDay.now().hour,
        minute: TimeOfDay.now().minute,
      ),
    );

    if (time == null) return;
    controller.text =
        "${time.hour % 12}:${time.minute.toString().padLeft(2, '0')} ${time.hour < 12 ? "AM" : "PM"}";
  }
}
