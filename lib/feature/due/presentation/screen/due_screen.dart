import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/common/presentation/widget/textfield_widgets/cm_number_field.dart';

class DueScreen extends StatefulWidget {
  const DueScreen({super.key});
  @override
  State<DueScreen> createState() => _DueScreenState();
}

class _DueScreenState extends State<DueScreen> {
  final _userField = TextEditingController();
  final _amountField = TextEditingController();
  final _duePaidField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyDimens().getNormalAppBar("Due List", [], context),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "User Name",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                CmNumberField(controller: _userField, label: "Select the user"),
                SizedBox(height: 8.h),
                Text(
                  "Total amount",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                CmNumberField(
                  controller: _amountField,
                  label: "৳ ..................",
                ),
                SizedBox(height: 8.h),
                Text(
                  "Due Paid",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                CmNumberField(
                  controller: _duePaidField,
                  label: "৳ ..................",
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
