import 'package:flutter/material.dart';

class CmNumberField extends StatelessWidget {
  const CmNumberField(
      {super.key,
      required this.controller,
      required this.label,
      this.readOnly});
  final TextEditingController controller;
  final String label;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(labelText: label),
        readOnly: readOnly ?? false,
        validator: (val) {
          if (val!.isEmpty) {
            return 'This Field is required';
          } else {
            final intValue = int.tryParse(val);
            if (intValue == null) return "Plz provide valid number";
            return null;
          }
        },
      ),
    );
  }
}
