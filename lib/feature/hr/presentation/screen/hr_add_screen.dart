import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class HrAddScreen extends StatefulWidget {
  const HrAddScreen({super.key});
  @override
  State<HrAddScreen> createState() => _HrAddScreenState();
}

class _HrAddScreenState extends State<HrAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _designationController = TextEditingController();
  final _departmentController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _salaryController = TextEditingController();
  final _nidController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedGender = 'male';
  String? _selectedBloodGroup;
  String? _selectedMaritalStatus = 'single';
  String? _selectedEmploymentType = 'full-time';
  String _selectedStatus = 'active';
  
  DateTime? _dateOfBirth;
  DateTime? _joinDate;
  DateTime? _contractEndDate;
  
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _joinDateController = TextEditingController();
  final TextEditingController _contractEndDateController = TextEditingController();

  final List<String> _departments = [
    'Sales',
    'Operations',
    'Finance',
    'Human Resources',
    'Warehouse',
    'Logistics',
    'Support',
    'Marketing',
    'IT',
    'Administration',
  ];

  final List<String> _designations = [
    'Store Manager',
    'Assistant Manager',
    'Sales Executive',
    'Accountant',
    'Warehouse Supervisor',
    'Delivery Supervisor',
    'HR Manager',
    'Customer Service',
    'Cashier',
    'Security Guard',
    'Cleaner',
  ];

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  final List<String> _employmentTypes = [
    'full-time',
    'part-time',
    'contract',
    'intern',
    'temporary',
  ];

  @override
  void initState() {
    super.initState();
    // Set default dates
    _joinDate = DateTime.now();
    _joinDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    
    // Set default employee ID
    _employeeIdController.text = 'EMP${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _employeeIdController.dispose();
    _designationController.dispose();
    _departmentController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    _salaryController.dispose();
    _nidController.dispose();
    _bankAccountController.dispose();
    _notesController.dispose();
    _dobController.dispose();
    _joinDateController.dispose();
    _contractEndDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(1990, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColor.primary,
              onPrimary: MyColor.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectJoinDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _joinDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColor.primary,
              onPrimary: MyColor.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _joinDate) {
      setState(() {
        _joinDate = picked;
        _joinDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _selectContractEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _contractEndDate ?? DateTime.now().add(Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColor.primary,
              onPrimary: MyColor.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _contractEndDate) {
      setState(() {
        _contractEndDate = picked;
        _contractEndDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
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
          'Add Employee',
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

                // Basic Information
                _buildSectionTitle('Basic Information'),
                SizedBox(height: 16.h),

                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name *',
                  hint: 'Enter employee full name',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter employee name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _employeeIdController,
                        label: 'Employee ID',
                        hint: 'Auto-generated',
                        icon: Icons.badge_outlined,
                        readOnly: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender *',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.h),
                          _buildGenderSelector(),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Contact Information
                _buildSectionTitle('Contact Information'),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _emailController,
                        label: 'Email Address',
                        hint: 'employee@company.com',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number *',
                        hint: '+880 1XXX XXXXXX',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          if (value.length < 10) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                _buildTextField(
                  controller: _addressController,
                  label: 'Address',
                  hint: 'Enter residential address',
                  icon: Icons.home_outlined,
                  maxLines: 3,
                ),

                SizedBox(height: 24.h),

                // Employment Details
                _buildSectionTitle('Employment Details'),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Department *',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.h),
                          _buildDepartmentDropdown(),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Designation *',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.h),
                          _buildDesignationDropdown(),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                        controller: _joinDateController,
                        label: 'Join Date *',
                        hint: 'Select join date',
                        icon: Icons.calendar_today_outlined,
                        onTap: () => _selectJoinDate(context),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildDateField(
                        controller: _contractEndDateController,
                        label: 'Contract End',
                        hint: 'Select end date',
                        icon: Icons.event_busy_outlined,
                        onTap: () => _selectContractEndDate(context),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Employment Type *',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.h),
                          _buildEmploymentTypeDropdown(),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildTextField(
                        controller: _salaryController,
                        label: 'Monthly Salary (৳) *',
                        hint: '0.00',
                        icon: Icons.attach_money_outlined,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter salary';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Invalid amount';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Personal Information
                _buildSectionTitle('Personal Information'),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                        controller: _dobController,
                        label: 'Date of Birth',
                        hint: 'Select date of birth',
                        icon: Icons.cake_outlined,
                        onTap: () => _selectDateOfBirth(context),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Blood Group',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.h),
                          _buildBloodGroupDropdown(),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _nidController,
                        label: 'NID Number',
                        hint: 'Enter NID number',
                        icon: Icons.credit_card_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Marital Status',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.h),
                          _buildMaritalStatusSelector(),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Emergency Contact
                _buildTextField(
                  controller: _emergencyContactController,
                  label: 'Emergency Contact *',
                  hint: 'Emergency contact number',
                  icon: Icons.emergency_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter emergency contact';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                // Bank Details
                _buildTextField(
                  controller: _bankAccountController,
                  label: 'Bank Account (Optional)',
                  hint: 'Bank account number',
                  icon: Icons.account_balance_outlined,
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 24.h),

                // Status & Notes
                _buildSectionTitle('Status & Notes'),
                SizedBox(height: 16.h),

                _buildStatusSelector(),

                SizedBox(height: 16.h),

                _buildTextField(
                  controller: _notesController,
                  label: 'Additional Notes',
                  hint: 'Any additional information...',
                  icon: Icons.note_outlined,
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
              Icons.person_add_outlined,
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
                  'New Employee Registration',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Fill in the details to add a new employee',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.gray600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: maxLines > 1
                ? Padding(
                    padding: EdgeInsets.only(bottom: (maxLines * 20).h),
                    child: Icon(icon),
                  )
                : Icon(icon),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        InkWell(
          onTap: onTap,
          child: IgnorePointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                prefixIcon: Icon(icon),
                suffixIcon: Icon(Icons.calendar_today, color: MyColor.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColor.outlineVariant),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedGender = 'male'),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: _selectedGender == 'male'
                      ? MyColor.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                  border: _selectedGender == 'male'
                      ? Border.all(color: MyColor.primary, width: 1.5.w)
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.male,
                      color: _selectedGender == 'male'
                          ? MyColor.primary
                          : MyColor.gray500,
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Male',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _selectedGender == 'male'
                            ? MyColor.primary
                            : MyColor.gray600,
                        fontWeight: _selectedGender == 'male'
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 40.h,
            color: MyColor.outlineVariant,
          ),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedGender = 'female'),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: _selectedGender == 'female'
                      ? Color(0xFFEC4899).withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                  border: _selectedGender == 'female'
                      ? Border.all(color: Color(0xFFEC4899), width: 1.5.w)
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.female,
                      color: _selectedGender == 'female'
                          ? Color(0xFFEC4899)
                          : MyColor.gray500,
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Female',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _selectedGender == 'female'
                            ? Color(0xFFEC4899)
                            : MyColor.gray600,
                        fontWeight: _selectedGender == 'female'
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaritalStatusSelector() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: MyColor.outlineVariant),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedMaritalStatus = 'single'),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: _selectedMaritalStatus == 'single'
                      ? MyColor.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                  border: _selectedMaritalStatus == 'single'
                      ? Border.all(color: MyColor.primary, width: 1.5.w)
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Single',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _selectedMaritalStatus == 'single'
                          ? MyColor.primary
                          : MyColor.gray600,
                      fontWeight: _selectedMaritalStatus == 'single'
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 40.h,
            color: MyColor.outlineVariant,
          ),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedMaritalStatus = 'married'),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: _selectedMaritalStatus == 'married'
                      ? MyColor.primary.withOpacity(0.1)
                      : Colors.transparent,
                  border: _selectedMaritalStatus == 'married'
                      ? Border.all(color: MyColor.primary, width: 1.5.w)
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Married',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _selectedMaritalStatus == 'married'
                          ? MyColor.primary
                          : MyColor.gray600,
                      fontWeight: _selectedMaritalStatus == 'married'
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 1.w,
            height: 40.h,
            color: MyColor.outlineVariant,
          ),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _selectedMaritalStatus = 'other'),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: _selectedMaritalStatus == 'other'
                      ? MyColor.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                  border: _selectedMaritalStatus == 'other'
                      ? Border.all(color: MyColor.primary, width: 1.5.w)
                      : null,
                ),
                child: Center(
                  child: Text(
                    'Other',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _selectedMaritalStatus == 'other'
                          ? MyColor.primary
                          : MyColor.gray600,
                      fontWeight: _selectedMaritalStatus == 'other'
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSelector() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.work_outline, color: MyColor.primary, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Employee Status',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildStatusChip('Active', 'active', MyColor.success),
              SizedBox(width: 8.w),
              _buildStatusChip('On Leave', 'on-leave', Color(0xFFF97316)),
              SizedBox(width: 8.w),
              _buildStatusChip('Inactive', 'inactive', MyColor.gray400),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, String value, Color color) {
    final isSelected = _selectedStatus == value;
    return ChoiceChip(
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: isSelected ? MyColor.onPrimary : color,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = value;
        });
      },
      backgroundColor: color.withOpacity(0.1),
      selectedColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: isSelected ? color : MyColor.outlineVariant),
      ),
    );
  }

  Widget _buildDepartmentDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _departmentController.text.isNotEmpty
          ? _departmentController.text
          : null,
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.business_outlined),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hintText: 'Select department',
      ),
      items: _departments.map((dept) {
        return DropdownMenuItem<String>(
          value: dept,
          child: Text(dept, overflow: TextOverflow.ellipsis, maxLines: 1),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _departmentController.text = value ?? '';
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select department';
        }
        return null;
      },
    );
  }

  Widget _buildDesignationDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _designationController.text.isNotEmpty
          ? _designationController.text
          : null,
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.work_outline),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hintText: 'Select designation',
      ),
      items: _designations.map((designation) {
        return DropdownMenuItem<String>(
          value: designation,
          child: Text(designation, overflow: TextOverflow.ellipsis, maxLines: 1),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _designationController.text = value ?? '';
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select designation';
        }
        return null;
      },
    );
  }

  Widget _buildBloodGroupDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedBloodGroup,
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.bloodtype_outlined),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hintText: 'Select blood group',
      ),
      items: _bloodGroups.map((group) {
        return DropdownMenuItem<String>(
          value: group,
          child: Text(group),
        );
      }).toList(),
      onChanged: (value) => setState(() => _selectedBloodGroup = value),
    );
  }

  Widget _buildEmploymentTypeDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedEmploymentType,
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.work_history_outlined),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hintText: 'Select employment type',
      ),
      items: _employmentTypes.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(
            type.replaceAll('-', ' ').toUpperCase(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
      }).toList(),
      onChanged: (value) => setState(() => _selectedEmploymentType = value),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select employment type';
        }
        return null;
      },
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
                // Create employee object
                final newEmployee = Employee(
                  id: _employeeIdController.text,
                  name: _nameController.text,
                  designation: _designationController.text,
                  department: _departmentController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  salary: double.parse(_salaryController.text),
                  joinDate: _joinDate!,
                  status: _selectedStatus,
                  address: _addressController.text,
                  emergencyContact: _emergencyContactController.text,
                  gender: _selectedGender!,
                  dateOfBirth: _dateOfBirth,
                  bloodGroup: _selectedBloodGroup,
                  maritalStatus: _selectedMaritalStatus!,
                  employmentType: _selectedEmploymentType!,
                  nid: _nidController.text,
                  bankAccount: _bankAccountController.text,
                  contractEndDate: _contractEndDate,
                  notes: _notesController.text,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Employee added successfully!'),
                    backgroundColor: MyColor.success,
                  ),
                );
                Navigator.pop(context, newEmployee);
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
                Icon(Icons.person_add_alt_1, color: MyColor.onPrimary, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Add Employee',
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

// Employee Model
class Employee {
  final String id;
  final String name;
  final String designation;
  final String department;
  final String email;
  final String phone;
  final double salary;
  final DateTime joinDate;
  final String status;
  final String address;
  final String emergencyContact;
  final String gender;
  final DateTime? dateOfBirth;
  final String? bloodGroup;
  final String maritalStatus;
  final String employmentType;
  final String? nid;
  final String? bankAccount;
  final DateTime? contractEndDate;
  final String? notes;

  Employee({
    required this.id,
    required this.name,
    required this.designation,
    required this.department,
    required this.email,
    required this.phone,
    required this.salary,
    required this.joinDate,
    required this.status,
    required this.address,
    required this.emergencyContact,
    required this.gender,
    this.dateOfBirth,
    this.bloodGroup,
    required this.maritalStatus,
    required this.employmentType,
    this.nid,
    this.bankAccount,
    this.contractEndDate,
    this.notes,
  });
}