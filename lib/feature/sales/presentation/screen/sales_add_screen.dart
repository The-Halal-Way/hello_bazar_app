import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/common/presentation/widget/textfield_widgets/cm_name_email_field.dart';
import 'package:hello_bazar/feature/common/presentation/widget/textfield_widgets/cm_number_field.dart';
import 'package:hello_bazar/feature/sales/presentation/widget/sales_add_widgets/sales_add_summary_details.dart';

class SalesAddScreen extends StatefulWidget {
  const SalesAddScreen({super.key});
  @override
  State<SalesAddScreen> createState() => _SalesAddScreenState();
}

class _SalesAddScreenState extends State<SalesAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _totalController = TextEditingController();
  final _loyaltyController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _numberController.addListener(_updateUI);
    _totalController.addListener(_updateUI);
    _loyaltyController.addListener(_updateUI);
  }

  void _updateUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MyColor.onSurfaceVariant),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Add New Sale",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Card
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        MyColor.primary.withOpacity(0.1),
                        MyColor.primary.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: MyColor.primary.withOpacity(0.2),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: MyColor.primary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.person_add,
                          color: MyColor.onPrimary,
                          size: 28.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Sale Entry',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Fill in the customer details below',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: MyColor.gray600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                // Customer Information Section
                Text(
                  'Customer Information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                // Phone Field
                CmNumberField(
                  controller: _numberController,
                  label: 'Phone Number *',
                  hintText: '+880 XXXX-XXXXXX',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                SizedBox(height: 16.h),
                // Name Field
                CmNameEmailField(
                  controller: _nameController,
                  label: 'Full Name *',
                  hintText: "Enter customer name",
                  prefixIcon: Icon(Icons.person_outline),
                ),
                SizedBox(height: 24.h),
                // Due Details Section
                Text(
                  'Amount Details',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                // Amount Field
                CmNumberField(
                  controller: _totalController,
                  label: 'Total Amount (৳) *',
                  hintText: '0.00',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                SizedBox(height: 16.h),
                // summary
                LoyaltyAddSummaryDetails(
                  loyaltyController: _loyaltyController,
                  getSubTotal: _getSubTotal,
                  getGrandTotal: _getGrandTotal,
                ),
                SizedBox(height: 16.h),
                // Notes Field
                CmNameEmailField(
                  controller: _notesController,
                  label: 'Notes (Optional)',
                  hintText: 'Add any additional notes...',
                  prefixIcon: Icon(Icons.note_outlined),
                  maxLines: 2,
                ),
                SizedBox(height: 32.h),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: MyColor.outline),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: MyColor.gray700,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle save logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Loyalty added successfully!'),
                                backgroundColor: MyColor.success,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.primary,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: MyColor.onPrimary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Save All',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: MyColor.onPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get _getSubTotal {
    final total = double.tryParse(_totalController.text.trim()) ?? 0.0;
    return total.toStringAsFixed(2);
  }

  String get _getGrandTotal {
    final total = double.tryParse(_totalController.text.trim()) ?? 0.0;
    final loyalty = double.tryParse(_loyaltyController.text.trim()) ?? 0.0;
    final grandTotal = total - loyalty;
    return grandTotal.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _numberController.removeListener(_updateUI);
    _totalController.removeListener(_updateUI);
    _loyaltyController.removeListener(_updateUI);
    _numberController.dispose();
    _totalController.dispose();
    _loyaltyController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
