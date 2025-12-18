import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/sales/presentation/screen/sales_add_screen.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});
  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'all'; // 'all', 'paid', 'partial', 'unpaid'

  final List<Sale> _sales = [
    Sale(
      id: 'SAL001',
      customerName: 'John Doe',
      customerPhone: '+880 1712-345678',
      date: DateTime(2024, 12, 19),
      time: '10:30 AM',
      items: [
        SaleItem(name: 'Rice 5kg', quantity: 2, price: 500.00),
        SaleItem(name: 'Oil 2L', quantity: 1, price: 450.00),
        SaleItem(name: 'Sugar 1kg', quantity: 3, price: 100.00),
      ],
      totalAmount: 1750.00,
      paidAmount: 1750.00,
      dueAmount: 0.00,
      status: 'paid',
      paymentMethod: 'Cash',
    ),
    Sale(
      id: 'SAL002',
      customerName: 'Jane Smith',
      customerPhone: '+880 1823-456789',
      date: DateTime(2024, 12, 19),
      time: '11:45 AM',
      items: [
        SaleItem(name: 'Flour 2kg', quantity: 3, price: 150.00),
        SaleItem(name: 'Milk 1L', quantity: 5, price: 120.00),
      ],
      totalAmount: 1050.00,
      paidAmount: 500.00,
      dueAmount: 550.00,
      status: 'partial',
      paymentMethod: 'Cash',
    ),
    Sale(
      id: 'SAL003',
      customerName: 'Mike Johnson',
      customerPhone: '+880 1934-567890',
      date: DateTime(2024, 12, 19),
      time: '02:15 PM',
      items: [
        SaleItem(name: 'Tea 200g', quantity: 2, price: 250.00),
        SaleItem(name: 'Biscuits', quantity: 10, price: 35.00),
      ],
      totalAmount: 850.00,
      paidAmount: 0.00,
      dueAmount: 850.00,
      status: 'unpaid',
      paymentMethod: 'Due',
    ),
    Sale(
      id: 'SAL004',
      customerName: 'Sarah Williams',
      customerPhone: '+880 1645-678901',
      date: DateTime(2024, 12, 18),
      time: '09:20 AM',
      items: [
        SaleItem(name: 'Chicken 1kg', quantity: 2, price: 280.00),
        SaleItem(name: 'Eggs 12pcs', quantity: 1, price: 180.00),
      ],
      totalAmount: 740.00,
      paidAmount: 740.00,
      dueAmount: 0.00,
      status: 'paid',
      paymentMethod: 'Card',
    ),
    Sale(
      id: 'SAL005',
      customerName: 'Robert Brown',
      customerPhone: '+880 1756-789012',
      date: DateTime(2024, 12, 18),
      time: '03:50 PM',
      items: [
        SaleItem(name: 'Bread', quantity: 5, price: 45.00),
        SaleItem(name: 'Butter 250g', quantity: 2, price: 320.00),
      ],
      totalAmount: 865.00,
      paidAmount: 400.00,
      dueAmount: 465.00,
      status: 'partial',
      paymentMethod: 'Mobile Banking',
    ),
    Sale(
      id: 'SAL006',
      customerName: 'Emma Davis',
      customerPhone: '+880 1867-890123',
      date: DateTime(2024, 12, 17),
      time: '11:00 AM',
      items: [
        SaleItem(name: 'Potato 5kg', quantity: 1, price: 350.00),
        SaleItem(name: 'Onion 3kg', quantity: 1, price: 240.00),
      ],
      totalAmount: 590.00,
      paidAmount: 590.00,
      dueAmount: 0.00,
      status: 'paid',
      paymentMethod: 'Cash',
    ),
  ];

  List<Sale> get _filteredSales {
    var filtered = _sales.where((sale) {
      final matchesSearch =
          sale.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          sale.customerName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          sale.customerPhone.contains(_searchQuery);

      if (!matchesSearch) return false;

      switch (_selectedFilter) {
        case 'paid':
          return sale.status == 'paid';
        case 'partial':
          return sale.status == 'partial';
        case 'unpaid':
          return sale.status == 'unpaid';
        default:
          return true;
      }
    }).toList();

    // Sort by date (most recent first)
    filtered.sort((a, b) => b.date.compareTo(a.date));

    return filtered;
  }

  double get _todayTotal {
    final today = DateTime.now();
    return _sales
        .where(
          (sale) =>
              sale.date.year == today.year &&
              sale.date.month == today.month &&
              sale.date.day == today.day,
        )
        .fold(0.0, (sum, sale) => sum + sale.totalAmount);
  }

  double get _todayDue {
    final today = DateTime.now();
    return _sales
        .where(
          (sale) =>
              sale.date.year == today.year &&
              sale.date.month == today.month &&
              sale.date.day == today.day,
        )
        .fold(0.0, (sum, sale) => sum + sale.dueAmount);
  }

  int get _todayCount {
    final today = DateTime.now();
    return _sales
        .where(
          (sale) =>
              sale.date.year == today.year &&
              sale.date.month == today.month &&
              sale.date.day == today.day,
        )
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
        title: Text('Sales', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: MyColor.onSurfaceVariant),
            onPressed: () {
              // Show date picker
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

          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search by ID, customer or phone',
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
          _buildFilterChips(),

          SizedBox(height: 12.h),

          // Sales Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredSales.length} Sales',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.gray600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Sort by: Recent',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Sales List
          Expanded(
            child: _filteredSales.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _filteredSales.length,
                    itemBuilder: (context, index) {
                      return _buildSaleCard(_filteredSales[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SalesAddScreen()),
          );
        },
        backgroundColor: MyColor.primary,
        icon: Icon(Icons.add, color: MyColor.onPrimary),
        label: Text(
          'New Sale',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MyColor.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBanner() {
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
                  Icons.shopping_cart,
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
                      'Today\'s Sales',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.onPrimary.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳${_todayTotal.toStringAsFixed(2)}',
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
                  color: MyColor.success.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.trending_up, color: MyColor.white, size: 16.w),
                    SizedBox(width: 4.w),
                    Text(
                      '+12%',
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
                  icon: Icons.receipt_long,
                  label: 'Orders',
                  value: '$_todayCount',
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.account_balance_wallet,
                  label: 'Due Amount',
                  value: '৳${_todayDue.toStringAsFixed(0)}',
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
  }) {
    return Column(
      children: [
        Icon(icon, color: MyColor.white, size: 24.sp),
        SizedBox(height: 6.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: MyColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: MyColor.white.withOpacity(0.85),
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildFilterChip('All', 'all', _sales.length),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Paid',
            'paid',
            _sales.where((s) => s.status == 'paid').length,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Partial',
            'partial',
            _sales.where((s) => s.status == 'partial').length,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Unpaid',
            'unpaid',
            _sales.where((s) => s.status == 'unpaid').length,
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

  Widget _buildSaleCard(Sale sale) {
    Color statusColor;
    IconData statusIcon;

    switch (sale.status) {
      case 'paid':
        statusColor = MyColor.success;
        statusIcon = Icons.check_circle;
        break;
      case 'partial':
        statusColor = MyColor.warning;
        statusIcon = Icons.warning;
        break;
      default:
        statusColor = MyColor.error;
        statusIcon = Icons.cancel;
    }

    final isToday =
        sale.date.year == DateTime.now().year &&
        sale.date.month == DateTime.now().month &&
        sale.date.day == DateTime.now().day;

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
            // Navigate to sale detail page
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
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: MyColor.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.receipt_long,
                            color: MyColor.primary,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sale.id,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 12.sp,
                                  color: MyColor.gray500,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  isToday ? 'Today' : _formatDate(sale.date),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: MyColor.gray500),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.access_time,
                                  size: 12.sp,
                                  color: MyColor.gray500,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  sale.time,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: MyColor.gray500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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
                            sale.status.toUpperCase(),
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

                // Customer Info
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: MyColor.primaryFixed,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Text(
                          sale.customerName
                              .split(' ')
                              .map((e) => e[0])
                              .take(2)
                              .join(),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: MyColor.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
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
                            sale.customerName,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            sale.customerPhone,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: MyColor.gray500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.gray100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.inventory_2,
                            size: 12.sp,
                            color: MyColor.gray600,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${sale.items.length} items',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: MyColor.gray600,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
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
                          Row(
                            children: [
                              Icon(
                                Icons.payments,
                                size: 16.sp,
                                color: MyColor.gray600,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                sale.paymentMethod,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: MyColor.gray600,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          Text(
                            '৳${sale.totalAmount.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      if (sale.dueAmount > 0) ...[
                        SizedBox(height: 8.h),
                        Divider(height: 1.h, color: MyColor.outlineVariant),
                        SizedBox(height: 8.h),
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
                              '৳${sale.dueAmount.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyMedium
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
            Icons.shopping_cart_outlined,
            size: 80.sp,
            color: MyColor.gray300,
          ),
          SizedBox(height: 16.h),
          Text(
            'No sales found',
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
class Sale {
  final String id;
  final String customerName;
  final String customerPhone;
  final DateTime date;
  final String time;
  final List<SaleItem> items;
  final double totalAmount;
  final double paidAmount;
  final double dueAmount;
  final String status; // 'paid', 'partial', 'unpaid'
  final String paymentMethod;

  Sale({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.date,
    required this.time,
    required this.items,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.status,
    required this.paymentMethod,
  });
}

class SaleItem {
  final String name;
  final int quantity;
  final double price;

  SaleItem({required this.name, required this.quantity, required this.price});

  double get total => quantity * price;
}
