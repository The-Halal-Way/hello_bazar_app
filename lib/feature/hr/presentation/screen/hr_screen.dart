import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class HrScreen extends StatefulWidget {
  const HrScreen({super.key});
  @override
  State<HrScreen> createState() => _HrScreenState();
}

class _HrScreenState extends State<HrScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'all'; // 'all', 'active', 'on-leave', 'inactive'
  String _selectedView = 'list'; // 'list' or 'grid'

  final List<Employee> _employees = [
    Employee(
      id: 'EMP001',
      name: 'Md. Rahman',
      designation: 'Store Manager',
      department: 'Operations',
      email: 'rahman@loyaltyplus.com',
      phone: '+880 1712 345678',
      salary: 55000.00,
      joinDate: DateTime(2023, 1, 15),
      status: 'active',
      address: '123 Main Street, Dhaka',
      emergencyContact: '+880 1712 987654',
      profileImage: null,
      attendance: Attendance(
        totalPresent: 22,
        totalAbsent: 1,
        totalLate: 2,
        totalLeave: 5,
      ),
      performance: Performance(
        rating: 4.5,
        completedTasks: 45,
        pendingTasks: 3,
        salesTarget: 1200000.00,
        salesAchieved: 1350000.00,
      ),
    ),
    Employee(
      id: 'EMP002',
      name: 'Ms. Fatima Begum',
      designation: 'Assistant Manager',
      department: 'Sales',
      email: 'fatima@loyaltyplus.com',
      phone: '+880 1713 456789',
      salary: 42000.00,
      joinDate: DateTime(2023, 3, 10),
      status: 'active',
      address: '456 North Avenue, Uttara',
      emergencyContact: '+880 1713 876543',
      profileImage: null,
      attendance: Attendance(
        totalPresent: 21,
        totalAbsent: 2,
        totalLate: 1,
        totalLeave: 4,
      ),
      performance: Performance(
        rating: 4.2,
        completedTasks: 38,
        pendingTasks: 5,
        salesTarget: 800000.00,
        salesAchieved: 920000.00,
      ),
    ),
    Employee(
      id: 'EMP003',
      name: 'Mr. Karim Ahmed',
      designation: 'Accountant',
      department: 'Finance',
      email: 'karim@loyaltyplus.com',
      phone: '+880 1714 567890',
      salary: 38000.00,
      joinDate: DateTime(2022, 11, 5),
      status: 'active',
      address: '789 South Road, Mirpur',
      emergencyContact: '+880 1714 765432',
      profileImage: null,
      attendance: Attendance(
        totalPresent: 20,
        totalAbsent: 0,
        totalLate: 0,
        totalLeave: 8,
      ),
      performance: Performance(
        rating: 4.8,
        completedTasks: 50,
        pendingTasks: 2,
        salesTarget: 0.00,
        salesAchieved: 0.00,
      ),
    ),
    Employee(
      id: 'EMP004',
      name: 'Ms. Sabina Akter',
      designation: 'Sales Executive',
      department: 'Sales',
      email: 'sabina@loyaltyplus.com',
      phone: '+880 1715 678901',
      salary: 32000.00,
      joinDate: DateTime(2023, 6, 20),
      status: 'on-leave',
      address: '321 East Lane, Banani',
      emergencyContact: '+880 1715 654321',
      profileImage: null,
      attendance: Attendance(
        totalPresent: 18,
        totalAbsent: 0,
        totalLate: 3,
        totalLeave: 7,
      ),
      performance: Performance(
        rating: 3.9,
        completedTasks: 32,
        pendingTasks: 8,
        salesTarget: 500000.00,
        salesAchieved: 420000.00,
      ),
    ),
    Employee(
      id: 'EMP005',
      name: 'Mr. Jamal Uddin',
      designation: 'Warehouse Supervisor',
      department: 'Warehouse',
      email: 'jamal@loyaltyplus.com',
      phone: '+880 1716 789012',
      salary: 35000.00,
      joinDate: DateTime(2022, 8, 12),
      status: 'active',
      address: '654 West Bazar, Dhanmondi',
      emergencyContact: '+880 1716 543210',
      profileImage: null,
      attendance: Attendance(
        totalPresent: 23,
        totalAbsent: 1,
        totalLate: 1,
        totalLeave: 3,
      ),
      performance: Performance(
        rating: 4.3,
        completedTasks: 42,
        pendingTasks: 4,
        salesTarget: 0.00,
        salesAchieved: 0.00,
      ),
    ),
    Employee(
      id: 'EMP006',
      name: 'Ms. Nusrat Jahan',
      designation: 'HR Manager',
      department: 'Human Resources',
      email: 'nusrat@loyaltyplus.com',
      phone: '+880 1717 890123',
      salary: 48000.00,
      joinDate: DateTime(2022, 5, 25),
      status: 'active',
      address: '147 Central Plaza, Motijheel',
      emergencyContact: '+880 1717 432109',
      profileImage: null,
      attendance: Attendance(
        totalPresent: 22,
        totalAbsent: 0,
        totalLate: 0,
        totalLeave: 6,
      ),
      performance: Performance(
        rating: 4.6,
        completedTasks: 48,
        pendingTasks: 2,
        salesTarget: 0.00,
        salesAchieved: 0.00,
      ),
    ),
    Employee(
      id: 'EMP007',
      name: 'Mr. Farid Uddin',
      designation: 'Delivery Supervisor',
      department: 'Logistics',
      email: 'farid@loyaltyplus.com',
      phone: '+880 1718 901234',
      salary: 30000.00,
      joinDate: DateTime(2023, 9, 15),
      status: 'inactive',
      address: '258 Express Road, Gulshan',
      emergencyContact: '+880 1718 321098',
      profileImage: null,
      attendance: Attendance(
        totalPresent: 15,
        totalAbsent: 3,
        totalLate: 5,
        totalLeave: 5,
      ),
      performance: Performance(
        rating: 3.2,
        completedTasks: 25,
        pendingTasks: 12,
        salesTarget: 0.00,
        salesAchieved: 0.00,
      ),
    ),
    Employee(
      id: 'EMP008',
      name: 'Ms. Sonia Rahman',
      designation: 'Customer Service',
      department: 'Support',
      email: 'sonia@loyaltyplus.com',
      phone: '+880 1719 012345',
      salary: 28000.00,
      joinDate: DateTime(2023, 11, 30),
      status: 'active',
      address: '369 Customer Care, Mohakhali',
      emergencyContact: '+880 1719 210987',
      profileImage: null,
      attendance: Attendance(
        totalPresent: 19,
        totalAbsent: 1,
        totalLate: 2,
        totalLeave: 6,
      ),
      performance: Performance(
        rating: 4.0,
        completedTasks: 35,
        pendingTasks: 7,
        salesTarget: 300000.00,
        salesAchieved: 280000.00,
      ),
    ),
  ];

  List<Employee> get _filteredEmployees {
    var filtered = _employees.where((employee) {
      final matchesSearch = employee.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          employee.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          employee.designation.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          employee.department.toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesSearch) return false;

      switch (_selectedFilter) {
        case 'active':
          return employee.status == 'active';
        case 'on-leave':
          return employee.status == 'on-leave';
        case 'inactive':
          return employee.status == 'inactive';
        default:
          return true;
      }
    }).toList();

    // Sort by active status first, then by name
    filtered.sort((a, b) {
      if (a.status != b.status) {
        if (a.status == 'active') return -1;
        if (b.status == 'active') return 1;
        if (a.status == 'on-leave') return -1;
        if (b.status == 'on-leave') return 1;
      }
      return a.name.compareTo(b.name);
    });

    return filtered;
  }

  int get _activeCount => _employees.where((e) => e.status == 'active').length;
  int get _onLeaveCount => _employees.where((e) => e.status == 'on-leave').length;
  int get _inactiveCount => _employees.where((e) => e.status == 'inactive').length;
  double get _totalMonthlySalary => _employees.fold(0.0, (sum, e) => sum + e.salary);
  double get _averagePerformance => _employees.isNotEmpty 
      ? _employees.map((e) => e.performance.rating).reduce((a, b) => a + b) / _employees.length
      : 0.0;

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
          'HR Management',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: MyColor.onSurfaceVariant),
            onPressed: () {
              _showAddEmployeeDialog();
            },
          ),
          IconButton(
            icon: Icon(
              _selectedView == 'list' ? Icons.grid_view : Icons.list,
              color: MyColor.onSurfaceVariant,
            ),
            onPressed: () {
              setState(() {
                _selectedView = _selectedView == 'list' ? 'grid' : 'list';
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: MyColor.onSurfaceVariant),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Column(
        children: [
          // Header Card
          _buildHeaderCard(),

          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by name, ID or designation...',
                prefixIcon: Icon(Icons.search, color: MyColor.outline),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: MyColor.outline),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                _buildFilterChip('All', 'all', _employees.length),
                SizedBox(width: 8.w),
                _buildFilterChip('Active', 'active', _activeCount),
                SizedBox(width: 8.w),
                _buildFilterChip('On Leave', 'on-leave', _onLeaveCount),
                SizedBox(width: 8.w),
                _buildFilterChip('Inactive', 'inactive', _inactiveCount),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Employee Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredEmployees.length} Employees',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.gray600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Total Salary: ৳${_totalMonthlySalary.toInt()}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Employee List/Grid
          Expanded(
            child: _filteredEmployees.isEmpty
                ? _buildEmptyState()
                : _selectedView == 'list'
                    ? _buildListView()
                    : _buildGridView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddEmployeeDialog();
        },
        backgroundColor: MyColor.primary,
        icon: Icon(Icons.person_add, color: MyColor.onPrimary),
        label: Text(
          'Add Employee',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MyColor.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      margin: EdgeInsets.all(20.w),
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
              Icons.people_alt,
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
                  'HR Dashboard',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Manage your team efficiently',
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

  Widget _buildFilterChip(String label, String value, int count) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text('$label ($count)'),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: MyColor.surfaceContainerLowest,
      selectedColor: MyColor.primary.withOpacity(0.15),
      checkmarkColor: MyColor.primary,
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: isSelected ? MyColor.primary : MyColor.gray600,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? MyColor.primary : MyColor.outlineVariant,
        width: isSelected ? 1.5.w : 1.w,
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: _filteredEmployees.length,
      itemBuilder: (context, index) {
        return _buildEmployeeCard(_filteredEmployees[index]);
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.7,
      ),
      itemCount: _filteredEmployees.length,
      itemBuilder: (context, index) {
        return _buildEmployeeGridCard(_filteredEmployees[index]);
      },
    );
  }

  Widget _buildEmployeeCard(Employee employee) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (employee.status) {
      case 'active':
        statusColor = MyColor.success;
        statusText = 'ACTIVE';
        statusIcon = Icons.check_circle;
        break;
      case 'on-leave':
        statusColor = Color(0xFFF97316); // Orange
        statusText = 'ON LEAVE';
        statusIcon = Icons.holiday_village;
        break;
      case 'inactive':
        statusColor = MyColor.error;
        statusText = 'INACTIVE';
        statusIcon = Icons.pause_circle;
        break;
      default:
        statusColor = MyColor.gray400;
        statusText = 'UNKNOWN';
        statusIcon = Icons.help;
    }

    final monthsInCompany = DateTime.now().difference(employee.joinDate).inDays ~/ 30;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: MyColor.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            _showEmployeeDetailDialog(employee);
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Employee Header
                Row(
                  children: [
                    // Profile Image
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: MyColor.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Center(
                        child: Text(
                          employee.name.substring(0, 1),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: MyColor.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Employee Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            employee.designation,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: MyColor.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: MyColor.gray100,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  employee.department,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: MyColor.gray600,
                                        fontSize: 10.sp,
                                      ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'ID: ${employee.id}',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: MyColor.gray500,
                                      fontSize: 11.sp,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, color: statusColor, size: 12.sp),
                          SizedBox(width: 4.w),
                          Text(
                            statusText,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Divider(height: 1.h, color: MyColor.outlineVariant),
                SizedBox(height: 12.h),
                // Performance & Salary
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Performance',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: MyColor.gray500),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 14.sp),
                              SizedBox(width: 4.w),
                              Text(
                                '${employee.performance.rating.toStringAsFixed(1)}/5.0',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 30.h,
                      color: MyColor.outlineVariant,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Salary',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: MyColor.gray500),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '৳${employee.salary.toInt()}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.success,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 30.h,
                      color: MyColor.outlineVariant,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Tenure',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: MyColor.gray500),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '$monthsInCompany months',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // Quick Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildQuickActionButton(
                      icon: Icons.phone,
                      label: 'Call',
                      color: MyColor.primary,
                      onTap: () {
                        // Call employee
                      },
                    ),
                    _buildQuickActionButton(
                      icon: Icons.email,
                      label: 'Email',
                      color: MyColor.primary,
                      onTap: () {
                        // Email employee
                      },
                    ),
                    _buildQuickActionButton(
                      icon: Icons.calendar_today,
                      label: 'Schedule',
                      color: Color(0xFF8B5CF6),
                      onTap: () {
                        // Schedule meeting
                      },
                    ),
                    _buildQuickActionButton(
                      icon: Icons.more_vert,
                      label: 'More',
                      color: MyColor.gray600,
                      onTap: () {
                        // More options
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeGridCard(Employee employee) {
    Color statusColor;
    switch (employee.status) {
      case 'active':
        statusColor = MyColor.success;
        break;
      case 'on-leave':
        statusColor = Color(0xFFF97316);
        break;
      case 'inactive':
        statusColor = MyColor.error;
        break;
      default:
        statusColor = MyColor.gray400;
    }

    return Container(
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: MyColor.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            _showEmployeeDetailDialog(employee);
          },
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                // Profile Image
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: MyColor.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: statusColor, width: 2.w),
                  ),
                  child: Center(
                    child: Text(
                      employee.name.substring(0, 1),
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: MyColor.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                // Employee Name
                Text(
                  employee.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                // Designation
                Text(
                  employee.designation,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.gray600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                // Department
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: MyColor.gray100,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    employee.department,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: MyColor.gray600,
                      fontSize: 9.sp,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Divider(height: 1.h, color: MyColor.outlineVariant),
                SizedBox(height: 8.h),
                // Status & Salary
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            employee.status.toUpperCase(),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: statusColor,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '৳${(employee.salary ~/ 1000)}K',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 18.sp, color: color),
          style: IconButton.styleFrom(
            backgroundColor: color.withOpacity(0.1),
            padding: EdgeInsets.all(8.w),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontSize: 9.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80.sp, color: MyColor.gray300),
          SizedBox(height: 16.h),
          Text(
            'No employees found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: MyColor.gray600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: MyColor.gray500,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              _showAddEmployeeDialog();
            },
            child: Text('Add First Employee'),
          ),
        ],
      ),
    );
  }

  void _showEmployeeDetailDialog(Employee employee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: MyColor.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Column(
              children: [
                // Handle
                Container(
                  margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: MyColor.outlineVariant,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),

                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: MyColor.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            employee.name.substring(0, 1),
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: MyColor.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              employee.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              employee.designation,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: MyColor.primary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: MyColor.onSurfaceVariant),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status & ID
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(employee.status)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _getStatusIcon(employee.status),
                                    color: _getStatusColor(employee.status),
                                    size: 12.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    employee.status.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: _getStatusColor(employee.status),
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'ID: ${employee.id}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: MyColor.gray600),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Contact Information
                        _buildDetailSection(
                          title: 'Contact Information',
                          icon: Icons.contact_phone,
                          children: [
                            _buildDetailItem(
                              label: 'Phone',
                              value: employee.phone,
                              icon: Icons.phone,
                            ),
                            _buildDetailItem(
                              label: 'Email',
                              value: employee.email,
                              icon: Icons.email,
                            ),
                            _buildDetailItem(
                              label: 'Address',
                              value: employee.address,
                              icon: Icons.location_on,
                            ),
                            _buildDetailItem(
                              label: 'Emergency Contact',
                              value: employee.emergencyContact,
                              icon: Icons.emergency,
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Employment Details
                        _buildDetailSection(
                          title: 'Employment Details',
                          icon: Icons.business_center,
                          children: [
                            _buildDetailItem(
                              label: 'Department',
                              value: employee.department,
                              icon: Icons.business,
                            ),
                            _buildDetailItem(
                              label: 'Join Date',
                              value: DateFormat('dd MMM yyyy').format(employee.joinDate),
                              icon: Icons.calendar_today,
                            ),
                            _buildDetailItem(
                              label: 'Monthly Salary',
                              value: '৳${employee.salary.toStringAsFixed(2)}',
                              icon: Icons.attach_money,
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Performance & Attendance
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Performance',
                                value: employee.performance.rating.toStringAsFixed(1),
                                subtitle: '/5.0 rating',
                                icon: Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Attendance',
                                value: employee.attendance.totalPresent.toString(),
                                subtitle: 'days present',
                                icon: Icons.calendar_today,
                                color: MyColor.success,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        // Tasks
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Tasks Done',
                                value: employee.performance.completedTasks.toString(),
                                subtitle: 'completed',
                                icon: Icons.task_alt,
                                color: MyColor.primary,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Pending',
                                value: employee.performance.pendingTasks.toString(),
                                subtitle: 'tasks',
                                icon: Icons.pending_actions,
                                color: MyColor.warning,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.edit, size: 18.sp),
                                label: Text('Edit Details'),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.assignment, size: 18.sp),
                                label: Text('View Report'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColor.primary,
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: MyColor.primary, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: MyColor.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: MyColor.outlineVariant, width: 1.w),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: MyColor.gray500, size: 18.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.gray600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.3), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: MyColor.gray600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: MyColor.gray500,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEmployeeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Employee'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Designation',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add employee logic
              Navigator.pop(context);
            },
            child: Text('Add Employee'),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return MyColor.success;
      case 'on-leave':
        return Color(0xFFF97316);
      case 'inactive':
        return MyColor.error;
      default:
        return MyColor.gray400;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'active':
        return Icons.check_circle;
      case 'on-leave':
        return Icons.holiday_village;
      case 'inactive':
        return Icons.pause_circle;
      default:
        return Icons.help;
    }
  }
}

class Employee {
  final String id;
  final String name;
  final String designation;
  final String department;
  final String email;
  final String phone;
  final double salary;
  final DateTime joinDate;
  final String status; // 'active', 'on-leave', 'inactive'
  final String address;
  final String emergencyContact;
  final String? profileImage;
  final Attendance attendance;
  final Performance performance;

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
    this.profileImage,
    required this.attendance,
    required this.performance,
  });
}

class Attendance {
  final int totalPresent;
  final int totalAbsent;
  final int totalLate;
  final int totalLeave;

  Attendance({
    required this.totalPresent,
    required this.totalAbsent,
    required this.totalLate,
    required this.totalLeave,
  });

  double get attendancePercentage {
    final totalDays = totalPresent + totalAbsent + totalLeave;
    return totalDays > 0 ? (totalPresent / totalDays) * 100 : 0.0;
  }
}

class Performance {
  final double rating; // 0.0 to 5.0
  final int completedTasks;
  final int pendingTasks;
  final double salesTarget;
  final double salesAchieved;

  Performance({
    required this.rating,
    required this.completedTasks,
    required this.pendingTasks,
    required this.salesTarget,
    required this.salesAchieved,
  });

  double get salesAchievementPercentage {
    return salesTarget > 0 ? (salesAchieved / salesTarget) * 100 : 0.0;
  }

  double get taskCompletionPercentage {
    final totalTasks = completedTasks + pendingTasks;
    return totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0.0;
  }
}