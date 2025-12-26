import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/stock/data/model/stock_item.dart';
import 'package:hello_bazar/feature/stock/presentation/screen/stock_restock_screen.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});
  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter =
      'all'; // 'all', 'critical', 'low', 'adequate', 'overstocked'

  List<StockItem> _stockItems = [
    StockItem(
      productId: 'PRD001',
      productName: 'Premium Basmati Rice 5kg',
      sku: 'RICE-5KG-001',
      category: 'Grains',
      currentStock: 145,
      minStock: 20,
      maxStock: 200,
      reorderPoint: 30,
      unit: 'pcs',
      costPerUnit: 650.00,
      lastRestocked: DateTime(2024, 12, 15),
      supplier: 'ABC Wholesale Ltd',
    ),
    StockItem(
      productId: 'PRD002',
      productName: 'Sunflower Oil 5L',
      sku: 'OIL-5L-002',
      category: 'Cooking Oil',
      currentStock: 15,
      minStock: 20,
      maxStock: 100,
      reorderPoint: 25,
      unit: 'pcs',
      costPerUnit: 950.00,
      lastRestocked: DateTime(2024, 12, 10),
      supplier: 'Fresh Foods Supplier',
    ),
    StockItem(
      productId: 'PRD003',
      productName: 'Refined Sugar 1kg',
      sku: 'SUG-1KG-003',
      category: 'Sugar & Salt',
      currentStock: 5,
      minStock: 30,
      maxStock: 150,
      reorderPoint: 40,
      unit: 'pcs',
      costPerUnit: 95.00,
      lastRestocked: DateTime(2024, 11, 28),
      supplier: 'Green Valley Traders',
    ),
    StockItem(
      productId: 'PRD004',
      productName: 'Whole Wheat Flour 2kg',
      sku: 'FLOUR-2KG-004',
      category: 'Flour',
      currentStock: 85,
      minStock: 25,
      maxStock: 120,
      reorderPoint: 35,
      unit: 'pcs',
      costPerUnit: 140.00,
      lastRestocked: DateTime(2024, 12, 18),
      supplier: 'City Commodities',
    ),
    StockItem(
      productId: 'PRD005',
      productName: 'Green Tea 250g',
      sku: 'TEA-250G-005',
      category: 'Beverages',
      currentStock: 18,
      minStock: 15,
      maxStock: 80,
      reorderPoint: 20,
      unit: 'pcs',
      costPerUnit: 320.00,
      lastRestocked: DateTime(2024, 12, 12),
      supplier: 'Prime Distributors',
    ),
    StockItem(
      productId: 'PRD006',
      productName: 'Fresh Milk 1L',
      sku: 'MILK-1L-006',
      category: 'Dairy',
      currentStock: 220,
      minStock: 30,
      maxStock: 150,
      reorderPoint: 50,
      unit: 'pcs',
      costPerUnit: 90.00,
      lastRestocked: DateTime(2024, 12, 19),
      supplier: 'Metro Suppliers',
    ),
    StockItem(
      productId: 'PRD007',
      productName: 'Chocolate Biscuits 200g',
      sku: 'BISC-200G-007',
      category: 'Snacks',
      currentStock: 12,
      minStock: 25,
      maxStock: 100,
      reorderPoint: 30,
      unit: 'pcs',
      costPerUnit: 60.00,
      lastRestocked: DateTime(2024, 12, 8),
      supplier: 'Prime Distributors',
    ),
    StockItem(
      productId: 'PRD008',
      productName: 'Organic Honey 500g',
      sku: 'HON-500G-008',
      category: 'Organic',
      currentStock: 42,
      minStock: 10,
      maxStock: 60,
      reorderPoint: 15,
      unit: 'pcs',
      costPerUnit: 480.00,
      lastRestocked: DateTime(2024, 12, 16),
      supplier: 'ABC Wholesale Ltd',
    ),
  ];

  List<StockItem> get _filteredStockItems {
    var filtered = _stockItems.where((item) {
      final matchesSearch =
          item.productName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.sku.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.category.toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesSearch) return false;

      final status = item.stockStatus;
      switch (_selectedFilter) {
        case 'critical':
          return status == 'critical' ||
              status == 'very-low' ||
              status == 'out-of-stock';
        case 'low':
          return status == 'low';
        case 'adequate':
          return status == 'adequate';
        case 'high':
          return status == 'high';
        case 'overstocked':
          return status == 'overstocked';
        case 'out-of-stock':
          return status == 'out-of-stock';
        default:
          return true;
      }
    }).toList();

    // Sort by stock status priority with all new statuses
    filtered.sort((a, b) {
      final statusPriority = {
        'out-of-stock': 0,
        'critical': 1,
        'very-low': 2,
        'low': 3,
        'adequate': 4,
        'high': 5,
        'overstocked': 6,
      };

      // Use null-safe access with default value
      final priorityA = statusPriority[a.stockStatus] ?? 10;
      final priorityB = statusPriority[b.stockStatus] ?? 10;

      return priorityA.compareTo(priorityB);
    });

    return filtered;
  }

  int get _criticalCount => _stockItems
      .where(
        (i) =>
            i.stockStatus == 'critical' ||
            i.stockStatus == 'very-low' ||
            i.stockStatus == 'out-of-stock',
      )
      .length;
  int get _lowStockCount =>
      _stockItems.where((i) => i.stockStatus == 'low').length;
  int get _adequateCount =>
      _stockItems.where((i) => i.stockStatus == 'adequate').length;
  int get _highCount =>
      _stockItems.where((i) => i.stockStatus == 'high').length;
  int get _overstockedCount =>
      _stockItems.where((i) => i.stockStatus == 'overstocked').length;
  int get _outOfStockCount =>
      _stockItems.where((i) => i.stockStatus == 'out-of-stock').length;

  double get _totalStockValue =>
      _stockItems.fold(0.0, (sum, i) => sum + i.stockValue);

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
          'Stock Management',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download, color: MyColor.onSurfaceVariant),
            onPressed: () {
              // Export stock report
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

          // Alert Cards
          if (_criticalCount > 0 || _lowStockCount > 0) _buildAlertCards(),

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
                hintText: 'Search by name, SKU or category',
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

          // Stock Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredStockItems.length} Items',
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

          // Stock List
          Expanded(
            child: _filteredStockItems.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _filteredStockItems.length,
                    itemBuilder: (context, index) {
                      return _buildStockCard(_filteredStockItems[index]);
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StockRestockScreen(
                stockItems: _stockItems,
                onRestockComplete: (updatedItems) {
                  setState(() {
                    _stockItems = updatedItems;
                  });
                },
              ),
            ),
          );
        },
        backgroundColor: MyColor.primary,
        icon: Icon(Icons.add_shopping_cart, color: MyColor.onPrimary),
        label: Text(
          'Restock',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MyColor.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // The rest of your existing methods remain the same...
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
                child: Icon(Icons.warehouse, color: MyColor.white, size: 32.w),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Stock Value',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.onPrimary.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳${_totalStockValue.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: MyColor.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_criticalCount > 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.error.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.priority_high,
                            color: MyColor.white,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '$_criticalCount Critical',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: MyColor.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  if (_lowStockCount > 0) ...[
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.warning.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: MyColor.white,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '$_lowStockCount Low',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: MyColor.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
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
                  icon: Icons.inventory,
                  label: 'Total Items',
                  value: '${_stockItems.length}',
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.check_circle,
                  label: 'Adequate',
                  value:
                      '${_adequateCount + _highCount}', // Combine adequate and high
                ),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: MyColor.white.withOpacity(0.2),
              ),
              Expanded(
                child: _buildBannerStat(
                  icon: Icons.trending_up,
                  label: 'High',
                  value: '$_highCount',
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

  Widget _buildAlertCards() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          if (_outOfStockCount > 0)
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: MyColor.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: MyColor.error, width: 1.w),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: MyColor.error, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Out of Stock Alert',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: MyColor.error,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '$_outOfStockCount item(s) are completely out of stock',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: MyColor.gray700),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: MyColor.error,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          if (_criticalCount - _outOfStockCount > 0)
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: MyColor.error.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: MyColor.error.withOpacity(0.7),
                  width: 1.w,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.priority_high, color: MyColor.error, size: 24.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Critical Stock Alert',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: MyColor.error,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '${_criticalCount - _outOfStockCount} item(s) at critical levels',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: MyColor.gray700),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: MyColor.error,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
          if (_lowStockCount > 0)
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: MyColor.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: MyColor.warning, width: 1.w),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: MyColor.warning,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Low Stock Warning',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: MyColor.warning,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '$_lowStockCount item(s) running low on stock',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: MyColor.gray700),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: MyColor.warning,
                    size: 16.sp,
                  ),
                ],
              ),
            ),
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
          _buildFilterChip('All', 'all', _stockItems.length),
          SizedBox(width: 8.w),
          _buildFilterChip('Critical', 'critical', _criticalCount),
          SizedBox(width: 8.w),
          _buildFilterChip('Low Stock', 'low', _lowStockCount),
          SizedBox(width: 8.w),
          _buildFilterChip('Adequate', 'adequate', _adequateCount),
          SizedBox(width: 8.w),
          _buildFilterChip('High', 'high', _highCount),
          SizedBox(width: 8.w),
          _buildFilterChip('Overstocked', 'overstocked', _overstockedCount),
          SizedBox(width: 8.w),
          _buildFilterChip('Out of Stock', 'out-of-stock', _outOfStockCount),
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

  Widget _buildStockCard(StockItem item) {
    Color statusColor;
    IconData statusIcon;
    String statusText;
    String statusTooltip;

    switch (item.stockStatus) {
      case 'out-of-stock':
        statusColor = MyColor.error;
        statusIcon = Icons.error_outline;
        statusText = 'OUT OF STOCK';
        statusTooltip = 'No stock available';
        break;
      case 'critical':
        statusColor = MyColor.error;
        statusIcon = Icons.priority_high;
        statusText = 'CRITICAL';
        statusTooltip = 'Below 50% of minimum stock';
        break;
      case 'very-low':
        statusColor = Color(0xFFF97316); // Orange
        statusIcon = Icons.warning_amber;
        statusText = 'VERY LOW';
        statusTooltip = 'Below minimum stock';
        break;
      case 'low':
        statusColor = MyColor.warning;
        statusIcon = Icons.warning_amber;
        statusText = 'LOW STOCK';
        statusTooltip = 'Below reorder point';
        break;
      case 'high':
        statusColor = Color(0xFF10B981); // Emerald
        statusIcon = Icons.arrow_upward;
        statusText = 'HIGH';
        statusTooltip = 'Above 90% of max stock';
        break;
      case 'overstocked':
        statusColor = Color(0xFF0984E3); // Blue
        statusIcon = Icons.inventory;
        statusText = 'OVERSTOCKED';
        statusTooltip = 'Exceeds maximum stock';
        break;
      case 'adequate':
      default:
        statusColor = MyColor.success;
        statusIcon = Icons.check_circle;
        statusText = 'ADEQUATE';
        statusTooltip = 'Stock level is optimal';
    }

    final daysSinceRestock = item.daysSinceLastRestocked;

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
            _showStockDetailDialog(item);
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.inventory_2,
                        color: statusColor,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
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
                                  color: MyColor.gray100,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  item.category,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: MyColor.gray600,
                                        fontSize: 10.sp,
                                      ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  'SKU: ${item.sku}',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: MyColor.gray500,
                                        fontSize: 11.sp,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Tooltip(
                      message: statusTooltip,
                      child: Container(
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
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Stock Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current: ${item.currentStock} ${item.unit}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Max: ${item.maxStock} ${item.unit}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: MyColor.gray500),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: item.stockPercentage,
                        backgroundColor: MyColor.gray200,
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                        minHeight: 8.h,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Min: ${item.minStock}',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: MyColor.gray500),
                        ),
                        Text(
                          'Reorder: ${item.reorderPoint}',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: MyColor.warning),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Divider(height: 1.h, color: MyColor.outlineVariant),
                SizedBox(height: 12.h),
                // Additional Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stock Value',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: MyColor.gray500),
                        ),
                        Text(
                          '৳${item.stockValue.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: MyColor.success,
                              ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Last Restocked',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: MyColor.gray500),
                        ),
                        Text(
                          daysSinceRestock == 0
                              ? 'Today'
                              : daysSinceRestock == 1
                              ? 'Yesterday'
                              : '$daysSinceRestock days ago',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80.sp, color: MyColor.gray300),
          SizedBox(height: 16.h),
          Text(
            'No stock items found',
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

  void _showStockDetailDialog(StockItem item) {
    // Show detailed stock information dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.productName),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.qr_code, color: MyColor.primary),
                title: Text('SKU'),
                subtitle: Text(item.sku),
              ),
              ListTile(
                leading: Icon(Icons.category, color: MyColor.gray600),
                title: Text('Category'),
                subtitle: Text(item.category),
              ),
              ListTile(
                leading: Icon(Icons.numbers, color: MyColor.gray600),
                title: Text('Current Stock'),
                subtitle: Text('${item.currentStock} ${item.unit}'),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: MyColor.gray600),
                title: Text('Stock Limits'),
                subtitle: Text(
                  'Min: ${item.minStock} • Max: ${item.maxStock} • Reorder: ${item.reorderPoint}',
                ),
              ),
              ListTile(
                leading: Icon(Icons.attach_money, color: MyColor.gray600),
                title: Text('Cost'),
                subtitle: Text('৳${item.costPerUnit} per ${item.unit}'),
              ),
              ListTile(
                leading: Icon(Icons.business, color: MyColor.gray600),
                title: Text('Supplier'),
                subtitle: Text(item.supplier),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: MyColor.gray600),
                title: Text('Last Restocked'),
                subtitle: Text(
                  '${item.lastRestocked.day}/${item.lastRestocked.month}/${item.lastRestocked.year}',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StockRestockScreen(
                    stockItems: _stockItems,
                    onRestockComplete: (updatedItems) {
                      setState(() {
                        _stockItems = updatedItems;
                      });
                    },
                  ),
                ),
              );
            },
            child: Text('Add to Restock'),
          ),
        ],
      ),
    );
  }
}

class RestockItem {
  final String productId;
  final String productName;
  final int? quantity;
  final double costPerUnit;

  RestockItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.costPerUnit,
  });
}
