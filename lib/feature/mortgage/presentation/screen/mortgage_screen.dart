import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/mortgage/presentation/screen/mortage_add_credit_screen.dart';

class MortgageScreen extends StatefulWidget {
  const MortgageScreen({super.key});
  @override
  State<MortgageScreen> createState() => _MortgageScreenState();
}

class _MortgageScreenState extends State<MortgageScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'all'; // 'all', 'customer', 'supplier', 'overdue'

  final List<MortgageRecord> _mortgageRecords = [
    MortgageRecord(
      id: 'MRT001',
      type: 'customer', // customer or supplier
      name: 'John Doe',
      phone: '+880 1712-345678',
      totalAmount: 25000.00,
      paidAmount: 15000.00,
      dueAmount: 10000.00,
      dueDate: DateTime(2025, 1, 15),
      status: 'partial',
      transactions: [
        MortgageTransaction(
          date: DateTime(2024, 12, 1),
          amount: 10000.00,
          type: 'credit',
          note: 'Initial credit',
        ),
        MortgageTransaction(
          date: DateTime(2024, 12, 10),
          amount: 5000.00,
          type: 'payment',
          note: 'Partial payment',
        ),
        MortgageTransaction(
          date: DateTime(2024, 12, 20),
          amount: 15000.00,
          type: 'credit',
          note: 'Additional purchase',
        ),
      ],
      reference: 'SAL-DEC-001',
    ),
    MortgageRecord(
      id: 'MRT002',
      type: 'customer',
      name: 'Jane Smith',
      phone: '+880 1823-456789',
      totalAmount: 8500.00,
      paidAmount: 0.00,
      dueAmount: 8500.00,
      dueDate: DateTime(2025, 1, 5),
      status: 'unpaid',
      transactions: [
        MortgageTransaction(
          date: DateTime(2024, 12, 18),
          amount: 8500.00,
          type: 'credit',
          note: 'Credit sale',
        ),
      ],
      reference: 'SAL-DEC-045',
    ),
    MortgageRecord(
      id: 'MRT003',
      type: 'supplier',
      name: 'ABC Wholesale Ltd',
      phone: '+880 1934-567890',
      totalAmount: 45000.00,
      paidAmount: 20000.00,
      dueAmount: 25000.00,
      dueDate: DateTime(2025, 1, 20),
      status: 'partial',
      transactions: [
        MortgageTransaction(
          date: DateTime(2024, 12, 5),
          amount: 45000.00,
          type: 'debit',
          note: 'Purchase on credit',
        ),
        MortgageTransaction(
          date: DateTime(2024, 12, 15),
          amount: 20000.00,
          type: 'payment',
          note: 'Partial payment',
        ),
      ],
      reference: 'PUR-DEC-012',
    ),
    MortgageRecord(
      id: 'MRT004',
      type: 'customer',
      name: 'Robert Brown',
      phone: '+880 1645-678901',
      totalAmount: 12000.00,
      paidAmount: 12000.00,
      dueAmount: 0.00,
      dueDate: DateTime(2024, 12, 25),
      status: 'paid',
      transactions: [
        MortgageTransaction(
          date: DateTime(2024, 12, 8),
          amount: 12000.00,
          type: 'credit',
          note: 'Credit sale',
        ),
        MortgageTransaction(
          date: DateTime(2024, 12, 22),
          amount: 12000.00,
          type: 'payment',
          note: 'Full payment',
        ),
      ],
      reference: 'SAL-DEC-067',
    ),
    MortgageRecord(
      id: 'MRT005',
      type: 'supplier',
      name: 'Fresh Foods Supplier',
      phone: '+880 1756-789012',
      totalAmount: 18000.00,
      paidAmount: 0.00,
      dueAmount: 18000.00,
      dueDate: DateTime(2024, 12, 30),
      status: 'overdue',
      transactions: [
        MortgageTransaction(
          date: DateTime(2024, 11, 25),
          amount: 18000.00,
          type: 'debit',
          note: 'Purchase on credit',
        ),
      ],
      reference: 'PUR-NOV-089',
    ),
    MortgageRecord(
      id: 'MRT006',
      type: 'customer',
      name: 'Sarah Williams',
      phone: '+880 1867-890123',
      totalAmount: 6500.00,
      paidAmount: 3000.00,
      dueAmount: 3500.00,
      dueDate: DateTime(2025, 1, 10),
      status: 'partial',
      transactions: [
        MortgageTransaction(
          date: DateTime(2024, 12, 12),
          amount: 6500.00,
          type: 'credit',
          note: 'Credit sale',
        ),
        MortgageTransaction(
          date: DateTime(2024, 12, 18),
          amount: 3000.00,
          type: 'payment',
          note: 'Partial payment',
        ),
      ],
      reference: 'SAL-DEC-078',
    ),
  ];

  List<MortgageRecord> get _filteredRecords {
    var filtered = _mortgageRecords.where((record) {
      final matchesSearch =
          record.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record.phone.contains(_searchQuery);

      if (!matchesSearch) return false;

      switch (_selectedFilter) {
        case 'customer':
          return record.type == 'customer';
        case 'supplier':
          return record.type == 'supplier';
        case 'overdue':
          return record.status == 'overdue' ||
              (record.dueAmount > 0 && record.dueDate.isBefore(DateTime.now()));
        default:
          return true;
      }
    }).toList();

    filtered.sort((a, b) {
      // Priority: overdue > unpaid > partial > paid
      final statusPriority = {
        'overdue': 0,
        'unpaid': 1,
        'partial': 2,
        'paid': 3,
      };
      return statusPriority[a.status]!.compareTo(statusPriority[b.status]!);
    });

    return filtered;
  }

  double get _totalReceivable {
    return _mortgageRecords
        .where((r) => r.type == 'customer' && r.dueAmount > 0)
        .fold(0.0, (sum, record) => sum + record.dueAmount);
  }

  double get _totalPayable {
    return _mortgageRecords
        .where((r) => r.type == 'supplier' && r.dueAmount > 0)
        .fold(0.0, (sum, record) => sum + record.dueAmount);
  }

  int get _overdueCount {
    return _mortgageRecords
        .where((r) => r.dueAmount > 0 && r.dueDate.isBefore(DateTime.now()))
        .length;
  }

  int get _customerCount {
    return _mortgageRecords
        .where((r) => r.type == 'customer' && r.dueAmount > 0)
        .length;
  }

  int get _supplierCount {
    return _mortgageRecords
        .where((r) => r.type == 'supplier' && r.dueAmount > 0)
        .length;
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
          'Credit Management',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download, color: MyColor.onSurfaceVariant),
            onPressed: () {
              // Export report
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
          // Summary Banner
          _buildSummaryBanner(),

          // Alert Card for Overdue
          if (_overdueCount > 0) _buildOverdueAlert(),

          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by name, ID or phone',
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

          SizedBox(height: 16.h),

          // Filter Chips
          _buildFilterChips(),

          SizedBox(height: 12.h),

          // Record Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredRecords.length} Records',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.gray600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Sort by: Priority',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Records List
          Expanded(
            child: _filteredRecords.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _filteredRecords.length,
                    itemBuilder: (context, index) {
                      return _buildMortgageCard(_filteredRecords[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MortageAddCreditScreen()),
          );
        },
        backgroundColor: MyColor.primary,
        icon: Icon(Icons.add, color: MyColor.onPrimary),
        label: Text(
          'Add Credit',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MyColor.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBanner() {
    final netBalance = _totalReceivable - _totalPayable;

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [MyColor.primary, MyColor.primary.withOpacity(0.85)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.primary.withOpacity(0.25),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: MyColor.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: MyColor.white,
                  size: 32.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Net Credit Balance',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.onPrimary.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳${netBalance.abs().toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: MyColor.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: netBalance >= 0
                      ? MyColor.success.withOpacity(0.2)
                      : MyColor.error.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      netBalance >= 0
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: MyColor.white,
                      size: 16.w,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      netBalance >= 0 ? 'Receivable' : 'Payable',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: MyColor.white.withOpacity(0.2), height: 1.h),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.arrow_downward,
                  label: 'Receivable',
                  value: '৳${_totalReceivable.toStringAsFixed(0)}',
                  subtitle: '$_customerCount Customers',
                ),
              ),
              Container(
                width: 1.w,
                height: 50.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.arrow_upward,
                  label: 'Payable',
                  value: '৳${_totalPayable.toStringAsFixed(0)}',
                  subtitle: '$_supplierCount Suppliers',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBannerStat({
    required IconData icon,
    required String label,
    required String value,
    required String subtitle,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: MyColor.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: MyColor.white, size: 20.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: MyColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: MyColor.white.withOpacity(0.85),
            fontSize: 11.sp,
          ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: MyColor.white.withOpacity(0.7),
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildOverdueAlert() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.error, width: 1.w),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: MyColor.error, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overdue Payments Alert',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$_overdueCount payment(s) are overdue',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: MyColor.gray700),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: MyColor.error, size: 16.sp),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildFilterChip('All', 'all', _mortgageRecords.length),
          SizedBox(width: 8.w),
          _buildFilterChip('Customers', 'customer', _customerCount),
          SizedBox(width: 8.w),
          _buildFilterChip('Suppliers', 'supplier', _supplierCount),
          SizedBox(width: 8.w),
          _buildFilterChip('Overdue', 'overdue', _overdueCount),
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

  Widget _buildMortgageCard(MortgageRecord record) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    final isOverdue =
        record.dueAmount > 0 && record.dueDate.isBefore(DateTime.now());

    if (isOverdue) {
      statusColor = MyColor.error;
      statusIcon = Icons.warning;
      statusText = 'OVERDUE';
    } else {
      switch (record.status) {
        case 'paid':
          statusColor = MyColor.success;
          statusIcon = Icons.check_circle;
          statusText = 'PAID';
          break;
        case 'partial':
          statusColor = MyColor.warning;
          statusIcon = Icons.pending;
          statusText = 'PARTIAL';
          break;
        default:
          statusColor = MyColor.error;
          statusIcon = Icons.cancel;
          statusText = 'UNPAID';
      }
    }

    final typeColor = record.type == 'customer'
        ? MyColor.success
        : MyColor.warning;
    final typeIcon = record.type == 'customer' ? Icons.person : Icons.store;
    final typeText = record.type == 'customer' ? 'Customer' : 'Supplier';

    final daysUntilDue = record.dueDate.difference(DateTime.now()).inDays;

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
            _showMortgageDetailDialog(record);
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: typeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              typeIcon,
                              color: typeColor,
                              size: 22.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  record.name,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: typeColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                      child: Text(
                                        typeText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: typeColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10.sp,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      record.id,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: MyColor.gray500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          Icon(statusIcon, color: statusColor, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            statusText,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
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

                SizedBox(height: 12.h),
                Divider(height: 1.h, color: MyColor.outlineVariant),
                SizedBox(height: 12.h),

                // Contact & Reference
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone, size: 14.sp, color: MyColor.gray500),
                        SizedBox(width: 6.w),
                        Text(
                          record.phone,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: MyColor.gray600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.receipt,
                          size: 14.sp,
                          color: MyColor.gray500,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          record.reference,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: MyColor.gray600),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Amount Section
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: MyColor.gray50,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount:',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: MyColor.gray600),
                          ),
                          Text(
                            '৳${record.totalAmount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      if (record.paidAmount > 0) ...[
                        SizedBox(height: 6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Paid Amount:',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: MyColor.success),
                            ),
                            Text(
                              '৳${record.paidAmount.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: MyColor.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ],
                      if (record.dueAmount > 0) ...[
                        SizedBox(height: 6.h),
                        Divider(height: 1.h, color: MyColor.outlineVariant),
                        SizedBox(height: 6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Due Amount:',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: MyColor.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              '৳${record.dueAmount.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: MyColor.error,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                if (record.dueAmount > 0) ...[
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14.sp,
                            color: isOverdue ? MyColor.error : MyColor.gray500,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Due: ${_formatDate(record.dueDate)}',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isOverdue
                                      ? MyColor.error
                                      : MyColor.gray600,
                                  fontWeight: isOverdue
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: isOverdue
                              ? MyColor.error.withOpacity(0.1)
                              : daysUntilDue <= 3
                              ? MyColor.warning.withOpacity(0.1)
                              : MyColor.gray100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          isOverdue
                              ? '${daysUntilDue.abs()} days overdue'
                              : daysUntilDue == 0
                              ? 'Due today'
                              : '$daysUntilDue days left',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: isOverdue
                                    ? MyColor.error
                                    : daysUntilDue <= 3
                                    ? MyColor.warning
                                    : MyColor.gray600,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 80.sp,
            color: MyColor.gray300,
          ),
          SizedBox(height: 16.h),
          Text(
            'No credit records found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: MyColor.gray600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
          ),
        ],
      ),
    );
  }

  void _showMortgageDetailDialog(MortgageRecord record) {
    showDialog(
      context: context,
      builder: (context) => _MortgageDetailDialog(
        record: record,
        onPayment: () {
          Navigator.pop(context);
          _showAddPaymentDialog(record);
        },
      ),
    );
  }

  void _showAddPaymentDialog(MortgageRecord record) {
    final amountController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: MyColor.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.payment, color: MyColor.success, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text('Add Payment', style: TextStyle(fontSize: 18.sp)),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record.name,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4.h),
            Text(
              'Due Amount: ৳${record.dueAmount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: MyColor.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                labelText: 'Payment Amount',
                hintText: '0.00',
                prefixText: '৳',
                prefixIcon: Icon(Icons.attach_money, color: MyColor.primary),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                labelText: 'Note (Optional)',
                hintText: 'Enter payment note',
                prefixIcon: Icon(Icons.note, color: MyColor.primary),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (amountController.text.isNotEmpty) {
                final amount = double.parse(amountController.text);
                if (amount > 0 && amount <= record.dueAmount) {
                  Navigator.pop(context);
                  setState(() {
                    // Update payment - In real app, update via state management
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment recorded successfully!'),
                      backgroundColor: MyColor.success,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
            child: Text('Record Payment'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// Mortgage Detail Dialog
class _MortgageDetailDialog extends StatelessWidget {
  final MortgageRecord record;
  final VoidCallback onPayment;

  const _MortgageDetailDialog({required this.record, required this.onPayment});

  @override
  Widget build(BuildContext context) {
    final typeColor = record.type == 'customer'
        ? MyColor.success
        : MyColor.warning;
    final isOverdue =
        record.dueAmount > 0 && record.dueDate.isBefore(DateTime.now());

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        padding: EdgeInsets.all(20.w),
        constraints: BoxConstraints(maxHeight: 600.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    record.type == 'customer' ? Icons.person : Icons.store,
                    color: typeColor,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        record.type == 'customer' ? 'Customer' : 'Supplier',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: typeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Summary Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: MyColor.gray50,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: MyColor.outlineVariant, width: 1.w),
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Total Amount',
                    '৳${record.totalAmount.toStringAsFixed(2)}',
                  ),
                  SizedBox(height: 8.h),
                  _buildSummaryRow(
                    'Paid Amount',
                    '৳${record.paidAmount.toStringAsFixed(2)}',
                    valueColor: MyColor.success,
                  ),
                  SizedBox(height: 8.h),
                  Divider(height: 1.h),
                  SizedBox(height: 8.h),
                  _buildSummaryRow(
                    'Due Amount',
                    '৳${record.dueAmount.toStringAsFixed(2)}',
                    valueColor: MyColor.error,
                    bold: true,
                  ),
                  if (record.dueAmount > 0) ...[
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Due Date',
                          style: TextStyle(
                            color: MyColor.gray600,
                            fontSize: 14.sp,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: isOverdue
                                ? MyColor.error.withOpacity(0.1)
                                : MyColor.warning.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            _formatDate(record.dueDate),
                            style: TextStyle(
                              color: isOverdue
                                  ? MyColor.error
                                  : MyColor.warning,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Contact & Reference
            _buildInfoRow(Icons.phone, 'Phone', record.phone),
            SizedBox(height: 8.h),
            _buildInfoRow(Icons.receipt, 'Reference', record.reference),
            SizedBox(height: 8.h),
            _buildInfoRow(Icons.tag, 'Record ID', record.id),
            SizedBox(height: 20.h),

            // Transaction History
            Row(
              children: [
                Icon(Icons.history, size: 18.sp, color: MyColor.primary),
                SizedBox(width: 8.w),
                Text(
                  'Transaction History',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Transactions List
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColor.gray50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: record.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = record.transactions[index];
                    return _buildTransactionItem(context, transaction);
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Action Button
            if (record.dueAmount > 0)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onPayment,
                  icon: Icon(Icons.payment),
                  label: Text('Record Payment'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    backgroundColor: MyColor.success,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? valueColor,
    bool bold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: MyColor.gray600, fontSize: 14.sp),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? MyColor.onSurface,
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: MyColor.gray500),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: TextStyle(color: MyColor.gray600, fontSize: 13.sp),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    MortgageTransaction transaction,
  ) {
    final isCredit =
        transaction.type == 'credit' || transaction.type == 'debit';
    final color = transaction.type == 'payment'
        ? MyColor.success
        : MyColor.warning;
    final icon = transaction.type == 'payment'
        ? Icons.arrow_downward
        : Icons.arrow_upward;

    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.note,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text(
                  _formatDate(transaction.date),
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: MyColor.gray500),
                ),
              ],
            ),
          ),
          Text(
            '${transaction.type == 'payment' ? '-' : '+'}৳${transaction.amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

// Models
class MortgageRecord {
  final String id;
  final String type; // 'customer' or 'supplier'
  final String name;
  final String phone;
  final double totalAmount;
  final double paidAmount;
  final double dueAmount;
  final DateTime dueDate;
  final String status; // 'paid', 'partial', 'unpaid', 'overdue'
  final List<MortgageTransaction> transactions;
  final String reference;

  MortgageRecord({
    required this.id,
    required this.type,
    required this.name,
    required this.phone,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.dueDate,
    required this.status,
    required this.transactions,
    required this.reference,
  });
}

class MortgageTransaction {
  final DateTime date;
  final double amount;
  final String type; // 'credit', 'debit', 'payment'
  final String note;

  MortgageTransaction({
    required this.date,
    required this.amount,
    required this.type,
    required this.note,
  });
}
