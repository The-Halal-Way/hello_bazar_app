import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/common/presentation/widget/textfield_widgets/cm_number_field.dart';

class LoyaltyAddSummaryDetails extends StatelessWidget {
  const LoyaltyAddSummaryDetails({
    super.key,
    required this.loyaltyController,
    required this.getSubTotal,
    required this.getGrandTotal,
  });
  final TextEditingController loyaltyController;
  final String getSubTotal;
  final String getGrandTotal;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: MyDimens.getBoxDecoration,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Summary", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 16.h),
            _buildSummaryRow(
              title: "Sub Total",
              amount: getSubTotal,
              context: context,
            ),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Loyalty Discount:",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  width: 120.w,
                  child: CmNumberField(
                    controller: loyaltyController,
                    label: "৳ 0.00",
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Divider(thickness: 1.h),
            SizedBox(height: 8.h),
            _buildSummaryRow(
              title: "Grand Total",
              amount: getGrandTotal,
              context: context,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required String title,
    required String amount,
    required BuildContext context,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title:",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "৳ $amount",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
