import 'package:flutter/material.dart';

class CmNameEmailField extends StatelessWidget {
  const CmNameEmailField(
      {super.key,
      required this.controller,
      required this.label,
      required this.readOnly,
      this.maxLine = 1,
      this.icon});
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final int maxLine;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        textInputAction: TextInputAction.done,
        style: const TextStyle(fontSize: 15),
        maxLines: maxLine,
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
          prefixIcon: icon == null ? null : Icon(icon),
        ),
        validator: (value) {
          // validation if it's city
          if (label.toLowerCase().contains('city')) {
            final haveNumber = _containsNumber(value!.trim());
            final haveSpecialChar = _containsSpecialChar(value.trim());
            if (value.trim().isEmpty) {
              return 'Please give your City.';
            } else if (haveNumber || haveSpecialChar) {
              return 'Cities can\'t have number or special character';
            } else {
              return null;
            }
          }
          // validation for email address
          else if (label.toLowerCase().contains('email')) {
            final haveDotCom = value!.trim().contains(".com");
            final haveDotOrg = value.trim().contains(".org");
            final haveSpace = value.trim().contains("..");
            final haveAtTheRate = value.trim().contains("@");
            if (value.trim().isEmpty) {
              return 'Please give your email address.';
            } else if ((!haveDotCom && !haveDotOrg) ||
                !haveAtTheRate ||
                haveSpace) {
              return 'Please give a valid email address';
            } else {
              return null;
            }
          }
          // validation for name or address
          else {
            if (value!.trim().isEmpty) {
              return 'Please give your $label';
            } else {
              return null;
            }
          }
        },
      ),
    );
  }

  bool _containsNumber(String str) {
    RegExp numberRegex = RegExp(r'[0-9]');
    return numberRegex.hasMatch(str);
  }

  bool _containsSpecialChar(String str) {
    RegExp specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharacterRegex.hasMatch(str);
  }
}
