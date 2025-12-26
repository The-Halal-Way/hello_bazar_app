import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/stock/data/model/stock_item.dart';

class StockRestockScreen extends StatefulWidget {
  final List<StockItem> stockItems;
  final Function(List<StockItem>) onRestockComplete;
  const StockRestockScreen({
    super.key,
    required this.stockItems,
    required this.onRestockComplete,
  });
  @override
  State<StockRestockScreen> createState() => _StockRestockScreenState();
}

class _StockRestockScreenState extends State<StockRestockScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'critical'; // 'critical', 'low', 'all'

  final Map<String, RestockItem> _restockCart = {};
  double _cartTotalValue = 0.0;
  int _cartItemCount = 0;

  List<StockItem> get _filteredStockItems {
    var filtered = widget.stockItems.where((item) {
      final matchesSearch =
          item.productName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.sku.toLowerCase().contains(_searchQuery.toLowerCase());

      if (!matchesSearch) return false;

      final status = item.stockStatus;
      switch (_selectedFilter) {
        case 'critical':
          return status == 'critical' ||
              status == 'very-low' ||
              status == 'out-of-stock';
        case 'low':
          return status == 'low';
        default:
          return true;
      }
    }).toList();

    // Sort by critical first, then low stock
    filtered.sort((a, b) {
      if (a.stockStatus == 'critical' && b.stockStatus != 'critical') return -1;
      if (a.stockStatus != 'critical' && b.stockStatus == 'critical') return 1;
      if (a.stockStatus == 'very-low' && b.stockStatus != 'very-low') return -1;
      if (a.stockStatus != 'very-low' && b.stockStatus == 'very-low') return 1;
      if (a.stockStatus == 'out-of-stock' && b.stockStatus != 'out-of-stock') {
        return -1;
      }
      if (a.stockStatus != 'out-of-stock' && b.stockStatus == 'out-of-stock') {
        return 1;
      }
      if (a.stockStatus == 'low' && b.stockStatus != 'low') return -1;
      if (a.stockStatus != 'low' && b.stockStatus == 'low') return 1;
      return 0;
    });

    return filtered;
  }

  void _updateCartTotals() {
    setState(() {
      _cartTotalValue = _restockCart.values.fold(
        0.0,
        (sum, item) => sum + (item.quantity ?? 0) * item.costPerUnit,
      );
      _cartItemCount = _restockCart.length;
    });
  }

  void _addToCart(StockItem item, int quantity) {
    setState(() {
      _restockCart[item.productId] = RestockItem(
        productId: item.productId,
        productName: item.productName,
        quantity: quantity,
        costPerUnit: item.costPerUnit,
        supplier: item.supplier,
      );
    });
    _updateCartTotals();
  }

  void _removeFromCart(String productId) {
    setState(() {
      _restockCart.remove(productId);
    });
    _updateCartTotals();
  }

  void _updateQuantity(String productId, int newQuantity) {
    if (newQuantity <= 0) {
      _removeFromCart(productId);
      return;
    }

    setState(() {
      final item = _restockCart[productId]!;
      _restockCart[productId] = item.copyWith(quantity: newQuantity);
    });
    _updateCartTotals();
  }

  void _confirmRestock() {
    if (_restockCart.isEmpty) return;

    // Create updated stock items
    final updatedItems = widget.stockItems.map((item) {
      if (_restockCart.containsKey(item.productId)) {
        final restockItem = _restockCart[item.productId]!;
        return item.restock(
          quantity: restockItem.quantity!,
          newSupplier: restockItem.supplier,
        );
      }
      return item;
    }).toList();

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => _buildConfirmationDialog(updatedItems),
    );
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
          'Quick Restock',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          if (_cartItemCount > 0)
            Badge(
              label: Text('$_cartItemCount'),
              backgroundColor: MyColor.primary,
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: MyColor.onSurfaceVariant,
                ),
                onPressed: () => _showCartDetails(),
              ),
            ),
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
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search products to restock...',
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

          // Filter Tabs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                _buildFilterTab('Critical', 'critical'),
                SizedBox(width: 8.w),
                _buildFilterTab('Low Stock', 'low'),
                SizedBox(width: 8.w),
                _buildFilterTab('All Items', 'all'),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Product List
          Expanded(
            child: _filteredStockItems.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: _filteredStockItems.length,
                    itemBuilder: (context, index) {
                      return _buildRestockItemCard(_filteredStockItems[index]);
                    },
                  ),
          ),

          // Cart Summary & Action Buttons
          if (_cartItemCount > 0) _buildCartSummary(),
        ],
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
              Icons.add_shopping_cart,
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
                  'Quick Restock',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Add items to cart and confirm restock',
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

  Widget _buildFilterTab(String label, String value) {
    final isSelected = _selectedFilter == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = value),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? MyColor.primary : MyColor.surfaceContainer,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected ? MyColor.primary : MyColor.outlineVariant,
              width: 1.w,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? MyColor.onPrimary : MyColor.onSurface,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestockItemCard(StockItem item) {
    final isInCart = _restockCart.containsKey(item.productId);
    final cartItem = isInCart ? _restockCart[item.productId]! : null;

    final statusColor = _getStatusColor(item.stockStatus);
    final requiredStock = item.reorderPoint - item.currentStock;
    final suggestedQuantity = requiredStock > 0 ? requiredStock : 10;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isInCart
            ? MyColor.primary.withOpacity(0.03)
            : MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isInCart
              ? MyColor.primary.withOpacity(0.3)
              : MyColor.outlineVariant,
          width: isInCart ? 1.5.w : 1.w,
        ),
        boxShadow: [
          if (isInCart)
            BoxShadow(
              color: MyColor.primary.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Header
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.inventory_2,
                    color: statusColor,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'SKU: ${item.sku}',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: MyColor.gray600),
                      ),
                    ],
                  ),
                ),
                if (isInCart)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: MyColor.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check, color: MyColor.primary, size: 12.sp),
                        SizedBox(width: 4.w),
                        Text(
                          '${cartItem!.quantity} ${item.unit}',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: MyColor.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),

            SizedBox(height: 12.h),

            // Stock Information
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current: ${item.currentStock} ${item.unit}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Reorder at: ${item.reorderPoint} ${item.unit}',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: MyColor.gray600),
                      ),
                      if (requiredStock > 0)
                        Text(
                          'Need $requiredStock more',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: MyColor.error,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                    ],
                  ),
                ),

                // Quantity Controls
                Container(
                  decoration: BoxDecoration(
                    color: MyColor.surfaceContainer,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: MyColor.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      // Decrement Button
                      IconButton(
                        onPressed: isInCart && cartItem!.quantity! > 1
                            ? () => _updateQuantity(
                                item.productId,
                                cartItem.quantity! - 1,
                              )
                            : null,
                        icon: Icon(Icons.remove, size: 18.sp),
                        iconSize: 18.sp,
                        padding: EdgeInsets.all(6.w),
                        color: isInCart && cartItem!.quantity! > 1
                            ? MyColor.onSurfaceVariant
                            : MyColor.outlineVariant,
                      ),

                      // Quantity Display
                      Container(
                        width: 40.w,
                        alignment: Alignment.center,
                        child: Text(
                          isInCart ? '${cartItem!.quantity}' : '0',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),

                      // Increment Button
                      IconButton(
                        onPressed: () {
                          final newQuantity = isInCart
                              ? cartItem!.quantity! + 1
                              : 1;
                          _addToCart(item, newQuantity);
                        },
                        icon: Icon(Icons.add, size: 18.sp),
                        iconSize: 18.sp,
                        padding: EdgeInsets.all(6.w),
                        color: MyColor.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '৳${item.costPerUnit.toStringAsFixed(2)} per ${item.unit}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: MyColor.gray600),
                ),
                Row(
                  children: [
                    if (!isInCart)
                      OutlinedButton.icon(
                        onPressed: () => _addToCart(item, suggestedQuantity),
                        icon: Icon(Icons.add_shopping_cart, size: 14.sp),
                        label: Text('Add $suggestedQuantity'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          side: BorderSide(color: MyColor.primary),
                        ),
                      ),
                    if (isInCart)
                      OutlinedButton.icon(
                        onPressed: () => _removeFromCart(item.productId),
                        icon: Icon(Icons.remove_shopping_cart, size: 14.sp),
                        label: Text('Remove'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          side: BorderSide(color: MyColor.error),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 60.sp, color: MyColor.gray300),
          SizedBox(height: 12.h),
          Text(
            'No products found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: MyColor.gray600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Try adjusting your search or filter',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
          ),
        ],
      ),
    );
  }

  Widget _buildCartSummary() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        border: Border(
          top: BorderSide(color: MyColor.outlineVariant, width: 1.w),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restock Cart',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$_cartItemCount items • ${_getTotalQuantity()} units',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: MyColor.gray600),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total Cost',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: MyColor.gray600),
                  ),
                  Text(
                    '৳${_cartTotalValue.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: MyColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _clearCart(),
                  icon: Icon(Icons.delete_outline, size: 18.sp),
                  label: Text('Clear Cart'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: BorderSide(color: MyColor.error),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _confirmRestock,
                  icon: Icon(Icons.check, size: 18.sp),
                  label: Text('Confirm Restock'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationDialog(List<StockItem> updatedItems) {
    return AlertDialog(
      title: Text('Confirm Restock'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You are about to restock $_cartItemCount items:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 12.h),
            ..._restockCart.values.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.productName,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      '${item.quantity} units',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 12.h),
            Divider(),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Cost:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  '৳${_cartTotalValue.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: MyColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onRestockComplete(updatedItems);

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Successfully restocked $_cartItemCount items'),
                backgroundColor: MyColor.success,
              ),
            );

            // Close the screen
            Navigator.pop(context);
          },
          child: Text('Confirm & Restock'),
        ),
      ],
    );
  }

  void _showCartDetails() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Restock Cart',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: _restockCart.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 48.sp,
                            color: MyColor.gray300,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Cart is empty',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      children: _restockCart.values.map((item) {
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.inventory_2,
                              color: MyColor.primary,
                            ),
                            title: Text(item.productName),
                            subtitle: Text('${item.quantity} units'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '৳${(item.quantity! * item.costPerUnit).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: MyColor.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: MyColor.error,
                                  ),
                                  onPressed: () {
                                    _removeFromCart(item.productId);
                                    if (_restockCart.isEmpty) {
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearCart() {
    setState(() {
      _restockCart.clear();
    });
    _updateCartTotals();
  }

  int _getTotalQuantity() {
    return _restockCart.values.fold(
      0,
      (sum, item) => sum + (item.quantity ?? 0),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'out-of-stock':
        return MyColor.error;
      case 'critical':
        return MyColor.error;
      case 'very-low':
        return Color(0xFFF97316); // Orange
      case 'low':
        return MyColor.warning;
      case 'high':
        return Color(0xFF10B981); // Emerald
      case 'overstocked':
        return Color(0xFF0984E3); // Blue
      case 'adequate':
      default:
        return MyColor.success;
    }
  }
}

class RestockItem {
  final String productId;
  final String productName;
  final int? quantity;
  final double costPerUnit;
  final String supplier;

  RestockItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.costPerUnit,
    required this.supplier,
  });

  RestockItem copyWith({
    String? productId,
    String? productName,
    int? quantity,
    double? costPerUnit,
    String? supplier,
  }) {
    return RestockItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      supplier: supplier ?? this.supplier,
    );
  }
}
