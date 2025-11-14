import 'package:flutter/material.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class CmSortDropDownField extends StatelessWidget {
  const CmSortDropDownField(
      {super.key,
      required this.selectedType,
      required this.dropdownList,
      required this.width});
  final ValueNotifier<String> selectedType;
  final List<String> dropdownList;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColor.gray300),
      ),
      child: ValueListenableBuilder(
        valueListenable: selectedType,
        builder: (context, val, _) => DropdownButtonFormField(
          isExpanded: true,
          key: ValueKey(val),
          isDense: true,
          initialValue: val.isNotEmpty ? val : null,
          items: dropdownList
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e, overflow: TextOverflow.ellipsis, maxLines: 1),
                ),
              )
              .toList(),
          onChanged: (val) => selectedType.value = val!,
          icon: const Icon(Icons.arrow_drop_down, color: MyColor.gray500),
          dropdownColor: Colors.white,
          style: const TextStyle(fontSize: 12, color: MyColor.gray900),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(left: 10),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
