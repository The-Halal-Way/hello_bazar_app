import 'package:flutter/material.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class CmYearPicker extends StatelessWidget {
  const CmYearPicker(
      {super.key, required this.lable, required this.selectedYear});
  final String lable;
  final ValueNotifier<String> selectedYear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: MyColor.gray300,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: MyColor.gray400, width: .3)),
      child: Row(
        children: [
          // title
          ValueListenableBuilder(
            valueListenable: selectedYear,
            builder: (context, year, _) => Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "$year Passing Year",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 14),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => _selectDate(context),
            icon: const Icon(Icons.calendar_month_outlined,
                size: 20, color: MyColor.gray900),
          ),
        ],
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 0,
        title: const Text('Select Year'),
        content: SizedBox(
          height: 300,
          width: 300,
          child: YearPicker(
            firstDate: DateTime(DateTime.now().year - 30, 1),
            lastDate: DateTime(DateTime.now().year + 1),
            selectedDate: DateTime.now(),
            onChanged: (date) {
              selectedYear.value = date.year.toString();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
