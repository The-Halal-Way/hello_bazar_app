import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/common/data/model/cm_user.dart';
import 'package:hello_bazar/feature/common/presentation/widget/textfield_widgets/cm_name_email_field.dart';
import 'package:hello_bazar/feature/common/presentation/widget/textfield_widgets/cm_number_field.dart';

class CustomerAddScreen extends StatefulWidget {
  const CustomerAddScreen({super.key});
  @override
  State<CustomerAddScreen> createState() => _CustomerAddScreenState();
}

class _CustomerAddScreenState extends State<CustomerAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final _nidController = TextEditingController();
  final _creditLimitController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedGender = 'Male';
  String _selectedUserType = 'customer';
  String? _imagePath;
  bool _isActive = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    _nidController.dispose();
    _creditLimitController.dispose();
    _notesController.dispose();
    super.dispose();
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
          'Add New User',
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
                _buildHeaderCard(),
                SizedBox(height: 24.h),
                // Profile Image Section
                _buildImagePicker(),
                SizedBox(height: 24.h),
                // Basic Information
                _buildSectionTitle('Basic Information'),
                SizedBox(height: 16.h),
                CmNameEmailField(
                  controller: _nameController,
                  label: 'Full Name',
                  hintText: "Enter full name",
                  prefixIcon: Icon(Icons.person_outline),
                ),
                SizedBox(height: 16.h),
                CmNameEmailField(
                  controller: _emailController,
                  label: 'Email Address',
                  hintText: 'example@email.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                SizedBox(height: 16.h),
                CmNumberField(
                  controller: _mobileController,
                  label: 'Mobile Number',
                  hintText: '+880 XXXX-XXXXXX',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                SizedBox(height: 16.h),
                // Gender Selection
                Text(
                  'Gender *',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.h),
                _buildGenderSelector(),
                SizedBox(height: 24.h),
                // Additional Information
                _buildSectionTitle('Additional Information'),
                SizedBox(height: 16.h),
                CmNameEmailField(
                  controller: _addressController,
                  label: 'Address (Optional)',
                  hintText: 'Enter address',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  maxLines: 2,
                ),
                SizedBox(height: 16.h),
                CmNameEmailField(
                  controller: _emailController,
                  label: 'National ID (Optional)',
                  hintText: 'Enter NID number',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                SizedBox(height: 24.h),
                // User Type & Credit
                _buildSectionTitle('User Settings'),
                SizedBox(height: 16.h),
                Text(
                  'User Type *',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8.h),
                _buildUserTypeSelector(),
                SizedBox(height: 16.h),
                CmNumberField(
                  controller: _mobileController,
                  label: 'Credit Limit (৳)',
                  hintText: '0.00',
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                ),
                SizedBox(height: 16.h),
                // Active Status Toggle
                _buildActiveStatusToggle(),
                SizedBox(height: 16.h),
                CmNameEmailField(
                  controller: _emailController,
                  label: 'Notes (Optional)',
                  hintText: 'Add any additional notes...',
                  prefixIcon: Icon(Icons.note_outlined),
                  maxLines: 4,
                ),
                SizedBox(height: 32.h),
                // Action Buttons
                _buildActionButtons(),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
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
        border: Border.all(color: MyColor.primary.withOpacity(0.2), width: 1.w),
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
                  'New User Registration',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Fill in the details to create a new user',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: MyColor.gray600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: MyColor.gray100,
              shape: BoxShape.circle,
              border: Border.all(color: MyColor.outlineVariant, width: 2.w),
            ),
            child: _imagePath != null
                ? ClipOval(child: Image.asset(_imagePath!, fit: BoxFit.cover))
                : Icon(Icons.person, size: 60.sp, color: MyColor.gray400),
          ),
          SizedBox(height: 12.h),
          TextButton.icon(
            onPressed: () {
              // Image picker logic here
              setState(() {
                // _imagePath = 'path_to_image';
              });
            },
            icon: Icon(Icons.camera_alt, size: 18.sp),
            label: Text('Upload Photo'),
            style: TextButton.styleFrom(foregroundColor: MyColor.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      children: [
        Expanded(child: _buildGenderOption('Male', Icons.male)),
        SizedBox(width: 12.w),
        Expanded(child: _buildGenderOption('Female', Icons.female)),
        SizedBox(width: 12.w),
        Expanded(child: _buildGenderOption('Other', Icons.person)),
      ],
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    final isSelected = _selectedGender == gender;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? MyColor.primary.withOpacity(0.1)
              : MyColor.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? MyColor.primary : MyColor.outlineVariant,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? MyColor.primary : MyColor.gray500,
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              gender,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected ? MyColor.primary : MyColor.gray600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTypeSelector() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: MyColor.gray100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(child: _buildUserTypeOption('customer', 'Customer')),
          Expanded(child: _buildUserTypeOption('staff', 'Staff')),
          Expanded(child: _buildUserTypeOption('admin', 'Admin')),
        ],
      ),
    );
  }

  Widget _buildUserTypeOption(String type, String label) {
    final isSelected = _selectedUserType == type;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedUserType = type;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? MyColor.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: MyColor.gray200.withOpacity(0.5),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected ? MyColor.primary : MyColor.gray600,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildActiveStatusToggle() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: _isActive
                      ? MyColor.success.withOpacity(0.1)
                      : MyColor.gray200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  color: _isActive ? MyColor.success : MyColor.gray500,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Status',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _isActive ? 'Account is active' : 'Account is inactive',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
                  ),
                ],
              ),
            ],
          ),
          Switch(
            value: _isActive,
            onChanged: (value) {
              setState(() {
                _isActive = value;
              });
            },
            activeThumbColor: MyColor.success,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                // Create user object
                final newUser = CmUser(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _nameController.text,
                  email: _emailController.text,
                  image: _imagePath ?? '',
                  gender: _selectedGender,
                  mobileNo: _mobileController.text,
                  isVerified: false,
                  joinDate: DateTime.now(),
                  address: _addressController.text.isEmpty
                      ? null
                      : _addressController.text,
                  nid: _nidController.text.isEmpty ? null : _nidController.text,
                  userType: _selectedUserType,
                  creditLimit:
                      double.tryParse(_creditLimitController.text) ?? 0.0,
                  notes: _notesController.text.isEmpty
                      ? null
                      : _notesController.text,
                  isActive: _isActive,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('User created successfully!'),
                    backgroundColor: MyColor.success,
                  ),
                );
                Navigator.pop(context, newUser);
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
                Icon(Icons.check, color: MyColor.onPrimary, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Create User',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
