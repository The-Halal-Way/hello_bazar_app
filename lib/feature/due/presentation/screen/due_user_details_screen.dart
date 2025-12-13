import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/due/data/model/due_purchase.dart';
import 'package:hello_bazar/feature/due/data/model/due_user.dart';

class DueUserDetailsScreen extends StatefulWidget {
  final DueUser user;
  const DueUserDetailsScreen({super.key, required this.user});

  @override
  State<DueUserDetailsScreen> createState() => _DueUserDetailsScreenState();
}

class _DueUserDetailsScreenState extends State<DueUserDetailsScreen> {
  final List<DuePurchase> _purchases = [
    DuePurchase(
      id: 'PUR001',
      date: '2024-12-10',
      time: '02:30 PM',
      items: ['Rice 5kg', 'Oil 2L', 'Sugar 1kg'],
      totalAmount: 1250.00,
      paidAmount: 800.00,
      dueAmount: 450.00,
      status: 'partial',
    ),
    DuePurchase(
      id: 'PUR002',
      date: '2024-12-08',
      time: '11:15 AM',
      items: ['Flour 2kg', 'Salt 1kg'],
      totalAmount: 450.00,
      paidAmount: 450.00,
      dueAmount: 0.00,
      status: 'paid',
    ),
    DuePurchase(
      id: 'PUR003',
      date: '2024-12-05',
      time: '04:45 PM',
      items: ['Milk 1L', 'Bread 2pcs', 'Eggs 12pcs'],
      totalAmount: 350.00,
      paidAmount: 0.00,
      dueAmount: 350.00,
      status: 'unpaid',
    ),
    DuePurchase(
      id: 'PUR004',
      date: '2024-12-01',
      time: '10:20 AM',
      items: ['Tea 200g', 'Biscuits 3packs'],
      totalAmount: 450.00,
      paidAmount: 450.00,
      dueAmount: 0.00,
      status: 'paid',
    ),
  ];

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
          'Customer Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: MyColor.onSurfaceVariant),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Info Header
            _buildUserHeader(),

            SizedBox(height: 16.h),

            // Stats Cards
            _buildStatsCards(),

            SizedBox(height: 24.h),

            // Purchase History
            _buildPurchaseHistory(),

            SizedBox(height: 16.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [MyColor.primary, MyColor.primary.withOpacity(0.85)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                // Avatar with initials
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: MyColor.primaryFixed,
                    shape: BoxShape.circle,
                    border: Border.all(color: MyColor.white, width: 3.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.user.name
                          .split(' ')
                          .map((e) => e[0])
                          .take(2)
                          .join(),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: MyColor.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Name
                Text(
                  widget.user.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: MyColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),

                SizedBox(height: 8.h),

                // Phone
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone, color: MyColor.white, size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(
                      widget.user.phone,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: MyColor.white.withOpacity(0.95),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Status badges
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildBadge(
                      icon: Icons.shopping_cart,
                      label: '${widget.user.totalPurchases} Purchases',
                    ),
                    SizedBox(width: 12.w),
                    _buildBadge(
                      icon: Icons.access_time,
                      label: widget.user.lastPurchase,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({required IconData icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: MyColor.white, size: 14.sp),
          SizedBox(width: 6.w),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: MyColor.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Total Due',
              value: '৳${widget.user.dueAmount.toStringAsFixed(2)}',
              color: MyColor.error,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildStatCard(
              icon: Icons.shopping_bag_outlined,
              title: 'Total Spent',
              value: '৳5,280.00',
              color: MyColor.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: MyColor.gray500,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseHistory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Purchase History',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _purchases.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              return _buildPurchaseCard(_purchases[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseCard(DuePurchase purchase) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (purchase.status) {
      case 'paid':
        statusColor = MyColor.success;
        statusText = 'Paid';
        statusIcon = Icons.check_circle;
        break;
      case 'partial':
        statusColor = MyColor.warning;
        statusText = 'Partial';
        statusIcon = Icons.warning;
        break;
      default:
        statusColor = MyColor.error;
        statusText = 'Unpaid';
        statusIcon = Icons.cancel;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
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
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: MyColor.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.receipt_long,
                      color: MyColor.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        purchase.id,
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
                            '${purchase.date} • ${purchase.time}',
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

          SizedBox(height: 12.h),
          Divider(height: 1.h, color: MyColor.outlineVariant),
          SizedBox(height: 12.h),

          // Items
          Text(
            'Items:',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: MyColor.gray600,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            children: purchase.items.map((item) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: MyColor.gray100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  item,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontSize: 11.sp),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 12.h),

          // Amounts
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: MyColor.gray50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                _buildAmountRow(
                  'Total Amount:',
                  '৳${purchase.totalAmount.toStringAsFixed(2)}',
                ),
                if (purchase.paidAmount > 0) ...[
                  SizedBox(height: 6.h),
                  _buildAmountRow(
                    'Paid:',
                    '৳${purchase.paidAmount.toStringAsFixed(2)}',
                    color: MyColor.success,
                  ),
                ],
                if (purchase.dueAmount > 0) ...[
                  SizedBox(height: 6.h),
                  Divider(height: 1.h, color: MyColor.outlineVariant),
                  SizedBox(height: 6.h),
                  _buildAmountRow(
                    'Due:',
                    '৳${purchase.dueAmount.toStringAsFixed(2)}',
                    color: MyColor.error,
                    isBold: true,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(
    String label,
    String amount, {
    Color? color,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color ?? MyColor.gray600,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color ?? MyColor.onSurface,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: MyColor.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.phone, size: 18.sp),
              label: Text('Call'),
              style: OutlinedButton.styleFrom(
                foregroundColor: MyColor.primary,
                side: BorderSide(color: MyColor.primary),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.payment, color: MyColor.onPrimary, size: 18.sp),
              label: Text('Collect Payment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColor.primary,
                foregroundColor: MyColor.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
