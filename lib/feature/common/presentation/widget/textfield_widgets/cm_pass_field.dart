import 'package:flutter/material.dart';

class CmPassField extends StatelessWidget {
  const CmPassField({super.key, required this.controller, required this.label});
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isObsecure = ValueNotifier<bool>(true);
    return
        // textField
        Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ValueListenableBuilder(
        valueListenable: isObsecure,
        builder: (context, val, _) => TextFormField(
          controller: controller,
          textInputAction: TextInputAction.done,
          obscureText: val,
          decoration: InputDecoration(
            labelText: label,
            hintText: "m#P52s@ap\$V",
            suffix: InkWell(
              onTap: () => isObsecure.value = !val,
              child: Icon(val ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          validator: (val) {
            bool hasSpecialCharacter = containsSpecialCharacter(val!);
            bool hasNumber = containsNumber(val);
            bool hasCapitalLetter = containsCapitalLetter(val);
            bool hasSmallLetter = containsSmallLetter(val);
            if (val.isEmpty || val.length < 4) {
              return 'Plz insert a Password of 4 characters atleast';
            } else if (!hasSpecialCharacter) {
              return 'Plz add a Special character [!@#\$%^&*(),.?":{}|<>]';
            } else if (!hasNumber) {
              return 'Plz add a NUMBER ( 0-9 )';
            } else if (!hasCapitalLetter) {
              return 'Plz add a capital letter ( A-Z )';
            } else if (!hasSmallLetter) {
              return 'Plz add a small letter ( a-z )';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  bool containsSpecialCharacter(String str) {
    RegExp specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharacterRegex.hasMatch(str);
  }

  bool containsNumber(String str) {
    RegExp numberRegex = RegExp(r'[0-9]');
    return numberRegex.hasMatch(str);
  }

  bool containsCapitalLetter(String str) {
    RegExp capitalLetterRegex = RegExp(r'[A-Z]');
    return capitalLetterRegex.hasMatch(str);
  }

  bool containsSmallLetter(String str) {
    RegExp smallLetterRegex = RegExp(r'[a-z]');
    return smallLetterRegex.hasMatch(str);
  }
}
