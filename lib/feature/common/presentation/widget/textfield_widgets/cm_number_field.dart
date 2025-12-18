import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CmNumberField extends StatelessWidget {
  const CmNumberField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.label = "",
    this.readOnly = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.onlyTextField = false,
  });
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool readOnly;
  final int maxLines;
  final Widget? prefixIcon;
  final bool onlyTextField;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (onlyTextField == false) ...[
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: maxLines > 1
                ? Padding(
                    padding: EdgeInsets.only(bottom: (maxLines * 20).h),
                    child: prefixIcon,
                  )
                : prefixIcon,
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
      ],
    );
  }
}
