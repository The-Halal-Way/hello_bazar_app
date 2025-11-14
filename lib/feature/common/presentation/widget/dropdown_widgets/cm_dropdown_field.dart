import 'package:flutter/material.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class CmDropDownField extends StatelessWidget {
  const CmDropDownField({
    super.key,
    required this.dropList,
    required this.selectedVal,
    required this.title,
  });
  final List<String>? dropList;
  final ValueNotifier selectedVal;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedVal,
      builder: (context, val, _) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DropdownButtonFormField(
          initialValue: val.isNotEmpty ? val : null,
          isExpanded: true,
          key: ValueKey(val),
          isDense: true,
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            labelText: title,
            hintText: title,
            filled: true,
            fillColor: MyColor.gray400,
            contentPadding: const EdgeInsets.only(
              left: 20,
              right: 5,
              top: 13,
              bottom: 13,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: MyColor.gray500, width: 0.3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: MyColor.gray500, width: 0.3),
            ),
          ),
          items: dropList!
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              )
              .toList(),
          onChanged: (val) => selectedVal.value = val!,
          icon: const Icon(Icons.arrow_drop_down, color: MyColor.gray500),
        ),
      ),
    );
  }
}
