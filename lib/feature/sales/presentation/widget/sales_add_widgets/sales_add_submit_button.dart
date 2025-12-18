import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalesAddSubmitButton extends StatelessWidget {
  const SalesAddSubmitButton({
    super.key,
    required this.numberController,
    required this.totalController,
    required this.loyaltyController,
    required this.getSubTotal,
    required this.getGrandTotal,
  });
  final TextEditingController numberController;
  final TextEditingController totalController;
  final TextEditingController loyaltyController;
  final double getSubTotal;
  final double getGrandTotal;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _validateAndSubmit(context),
      child: const Text("Submit"),
    );
  }

  void _validateAndSubmit(BuildContext context) {
    if (numberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter customer number")),
      );
      return;
    }
    if (totalController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter total amount")),
      );
      return;
    }

    // Show confirmation dialog
    _showConfirmationDialog(context);
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Submission"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Customer: ${numberController.text}"),
            SizedBox(height: 8.h),
            Text("Total: ৳ $getSubTotal"),
            if (double.parse(loyaltyController.text) > 0) ...[
              SizedBox(height: 8.h),
              Text("Loyalty Discount: ৳ ${loyaltyController.text}"),
            ],
            SizedBox(height: 8.h),
            Text(
              "Grand Total: ৳ $getGrandTotal",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitData(context);
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _submitData(BuildContext context) {
    // Implement your submission logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product added successfully!")),
    );

    // Clear form after submission
    Future.delayed(const Duration(milliseconds: 500), () {
      numberController.clear();
      totalController.clear();
      loyaltyController.clear();
    });
  }
}
