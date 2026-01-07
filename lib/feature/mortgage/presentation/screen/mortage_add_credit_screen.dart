import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class MortageAddCreditScreen extends StatefulWidget {
  const MortageAddCreditScreen({super.key});

  @override
  State<MortageAddCreditScreen> createState() => _MortageAddCreditScreenState();
}

class _MortageAddCreditScreenState extends State<MortageAddCreditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _totalAmountController = TextEditingController();
  final TextEditingController _paidAmountController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _selectedType = 'customer'; // 'customer' or 'supplier'
  DateTime _selectedDueDate = DateTime.now().add(Duration(days: 7));

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _totalAmountController.dispose();
    _paidAmountController.dispose();
    _referenceController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  double get _totalAmount {
    return double.tryParse(_totalAmountController.text) ?? 0.0;
  }

  double get _paidAmount {
    return double.tryParse(_paidAmountController.text) ?? 0.0;
  }

  double get _dueAmount {
    return _totalAmount - _paidAmount;
  }

  String get _paymentStatus {
    if (_paidAmount == 0) return 'unpaid';
    if (_paidAmount >= _totalAmount) return 'paid';
    return 'partial';
  }

  void _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColor.primary,
              onPrimary: MyColor.onPrimary,
              surface: MyColor.surface,
              onSurface: MyColor.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  void _saveCredit() {
    if (_formKey.currentState!.validate()) {
      final credit = {
        'type': _selectedType,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'totalAmount': _totalAmount,
        'paidAmount': _paidAmount,
        'dueAmount': _dueAmount,
        'dueDate': _selectedDueDate,
        'status': _paymentStatus,
        'reference': _referenceController.text,
        'note': _noteController.text,
      };

      Navigator.pop(context, credit);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Credit record added successfully!'),
          backgroundColor: MyColor.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColor.surface,
        leading: IconButton(
          icon: Icon(Icons.close, color: MyColor.onSurfaceVariant),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Credit Record',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type Selector
                    _buildSectionHeader('Credit Type', Icons.category),
                    SizedBox(height: 12.h),
                    _buildTypeSelector(),
                    SizedBox(height: 24.h),

                    // Party Information
                    _buildSectionHeader(
                      _selectedType == 'customer'
                          ? 'Customer Information'
                          : 'Supplier Information',
                      _selectedType == 'customer' ? Icons.person : Icons.store,
                    ),
                    SizedBox(height: 12.h),
                    _buildPartyInfo(),
                    SizedBox(height: 24.h),

                    // Amount Details
                    _buildSectionHeader('Amount Details', Icons.attach_money),
                    SizedBox(height: 12.h),
                    _buildAmountDetails(),
                    SizedBox(height: 24.h),

                    // Due Date
                    _buildSectionHeader('Payment Due Date', Icons.calendar_today),
                    SizedBox(height: 12.h),
                    _buildDueDatePicker(),
                    SizedBox(height: 24.h),

                    // Reference & Note
                    _buildSectionHeader('Additional Information', Icons.info_outline),
                    SizedBox(height: 12.h),
                    _buildAdditionalInfo(),
                    SizedBox(height: 24.h),

                    // Summary Card
                    _buildSummaryCard(),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),

            // Bottom Action Bar
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: MyColor.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 20.sp, color: MyColor.primary),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: MyColor.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildTypeSelector() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: MyColor.gray100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTypeOption(
              'Customer Credit',
              'customer',
              Icons.person,
              MyColor.success,
              'Money to Receive',
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildTypeOption(
              'Supplier Credit',
              'supplier',
              Icons.store,
              MyColor.warning,
              'Money to Pay',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeOption(
    String label,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    final isSelected = _selectedType == value;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedType = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? MyColor.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
          border: isSelected
              ? Border.all(color: color.withOpacity(0.3), width: 1.5.w)
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.15) : MyColor.gray200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? color : MyColor.gray600,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? color : MyColor.gray600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected ? color.withOpacity(0.8) : MyColor.gray500,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartyInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: _selectedType == 'customer' ? 'Customer Name' : 'Supplier Name',
              hintText: 'Enter name',
              prefixIcon: Icon(
                _selectedType == 'customer' ? Icons.person : Icons.store,
                color: MyColor.primary,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: '+880 1XXX-XXXXXX',
              prefixIcon: Icon(Icons.phone, color: MyColor.primary),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAmountDetails() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _totalAmountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              labelText: 'Total Credit Amount',
              hintText: '0.00',
              prefixIcon: Icon(Icons.attach_money, color: MyColor.primary),
              suffixText: '৳',
              suffixStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: MyColor.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            onChanged: (value) => setState(() {}),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter total amount';
              }
              if (double.tryParse(value) == null || double.parse(value) <= 0) {
                return 'Please enter a valid amount';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _paidAmountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              labelText: 'Paid Amount (Optional)',
              hintText: '0.00',
              prefixIcon: Icon(Icons.payment, color: MyColor.success),
              suffixText: '৳',
              suffixStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: MyColor.success,
                fontWeight: FontWeight.w600,
              ),
              helperText: 'Leave empty if no payment made yet',
              helperStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: MyColor.gray500,
              ),
            ),
            onChanged: (value) => setState(() {}),
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final amount = double.tryParse(value);
                if (amount == null) {
                  return 'Please enter a valid amount';
                }
                if (amount > _totalAmount) {
                  return 'Cannot exceed total amount';
                }
              }
              return null;
            },
          ),
          if (_dueAmount > 0) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: MyColor.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: MyColor.error.withOpacity(0.3),
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber, color: MyColor.error, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Due Amount',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '৳${_dueAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: MyColor.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDueDatePicker() {
    final daysUntilDue = _selectedDueDate.difference(DateTime.now()).inDays;

    return InkWell(
      onTap: _selectDueDate,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: MyColor.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: MyColor.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.calendar_today,
                color: MyColor.warning,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Due Date',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: MyColor.gray600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formatDate(_selectedDueDate),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    daysUntilDue == 0
                        ? 'Due today'
                        : daysUntilDue == 1
                        ? 'Due tomorrow'
                        : 'Due in $daysUntilDue days',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: daysUntilDue <= 3 ? MyColor.warning : MyColor.gray500,
                      fontWeight: daysUntilDue <= 3 ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: MyColor.gray400),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _referenceController,
            decoration: InputDecoration(
              labelText: 'Reference (Optional)',
              hintText: 'e.g., SAL-001, PUR-045',
              prefixIcon: Icon(Icons.tag, color: MyColor.primary),
            ),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _noteController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Note (Optional)',
              hintText: 'Add any additional notes...',
              prefixIcon: Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: Icon(Icons.note, color: MyColor.primary),
              ),
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (_paymentStatus) {
      case 'paid':
        statusColor = MyColor.success;
        statusText = 'PAID';
        statusIcon = Icons.check_circle;
        break;
      case 'partial':
        statusColor = MyColor.warning;
        statusText = 'PARTIAL';
        statusIcon = Icons.warning;
        break;
      default:
        statusColor = MyColor.error;
        statusText = 'UNPAID';
        statusIcon = Icons.cancel;
    }

    final typeColor = _selectedType == 'customer' ? MyColor.success : MyColor.warning;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MyColor.primary.withOpacity(0.1),
            MyColor.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.primary.withOpacity(0.3), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: MyColor.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.account_balance_wallet,
                      color: MyColor.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Credit Summary',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      statusText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow(
            'Type',
            _selectedType == 'customer' ? 'Customer Credit' : 'Supplier Credit',
            typeColor,
          ),
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Total Amount',
            '৳${_totalAmount.toStringAsFixed(2)}',
            MyColor.onSurface,
            bold: true,
          ),
          if (_paidAmount > 0) ...[
            SizedBox(height: 8.h),
            _buildSummaryRow(
              'Paid Amount',
              '৳${_paidAmount.toStringAsFixed(2)}',
              MyColor.success,
            ),
          ],
          if (_dueAmount > 0) ...[
            SizedBox(height: 8.h),
            _buildSummaryRow(
              'Due Amount',
              '৳${_dueAmount.toStringAsFixed(2)}',
              MyColor.error,
              bold: true,
            ),
          ],
          SizedBox(height: 8.h),
          _buildSummaryRow(
            'Due Date',
            _formatDate(_selectedDueDate),
            MyColor.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color valueColor,
      {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MyColor.gray600,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: valueColor,
            fontWeight: bold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surface,
        boxShadow: [
          BoxShadow(
            color: MyColor.gray300.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                side: BorderSide(color: MyColor.outlineVariant),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: MyColor.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _saveCredit,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                backgroundColor: MyColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Save Credit',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: MyColor.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}