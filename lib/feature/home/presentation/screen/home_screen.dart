import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/config/theme/app_theme.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/customer/presentation/screen/customer_screen.dart';
import 'package:hello_bazar/feature/due/presentation/screen/due_screen.dart';
import 'package:hello_bazar/feature/ledger/presentation/screen/ledger_screen.dart';
import 'package:hello_bazar/feature/product/presentation/screen/product_screen.dart';
import 'package:hello_bazar/feature/profit_loss/presentation/screen/profit_loss_screen.dart';
import 'package:hello_bazar/feature/purchase/presentation/screen/purchase_screen.dart';
import 'package:hello_bazar/feature/sales/presentation/screen/sales_screen.dart';
import 'package:hello_bazar/feature/stock/presentation/screen/stock_screen.dart';
import 'package:hello_bazar/feature/warehouse/presentation/screen/warehouse_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyDimens().getNormalAppBar("Dashboard", [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF2D3142),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ], context),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(11.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24.h,
                children: [
                  // Welcome Banner
                  _buildBanner(context),
                  // Statistics Overview
                  _buildStatisticsOverview(context),
                  // Quick Access Categories
                  _buildCategoriesGrid(context),
                  // Recent Activity
                  _buildRecentActivity(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBanner(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColor.primary, MyColor.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.primary.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30.w,
            top: -30.h,
            child: Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -20.w,
            bottom: -20.h,
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? 24.w : .13.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back! 👋',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: MyColor.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Track your daily store performance',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: MyColor.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: MyColor.onPrimary,
                        size: 16.w,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '+12.5% from yesterday',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: MyColor.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsOverview(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Overview',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 10.h),
        GridView.count(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: isMobile ? 1.4 : 1.8,
          children: [
            _buildStatCard(
              context: context,
              title: 'Today\'s Sales',
              value: '৳ 12,458',
              icon: Icons.shopping_cart_outlined,
              color: MyColor.success,
              trend: '+8.2%',
              isPositive: true,
            ),
            _buildStatCard(
              context: context,
              title: 'Daily Profit',
              value: '৳ 3,245',
              icon: Icons.attach_money_outlined,
              color: const Color(0xFF10B981),
              trend: '+5.1%',
              isPositive: true,
            ),
            _buildStatCard(
              context: context,
              title: 'Total Due',
              value: '৳ 8,520',
              icon: Icons.credit_card_outlined,
              color: MyColor.warning,
              trend: '-2.4%',
              isPositive: false,
            ),
            _buildStatCard(
              context: context,
              title: 'Customers Today',
              value: '48',
              icon: Icons.people_outline,
              color: MyColor.primary,
              trend: '+12.3%',
              isPositive: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    final isMobile = AppTheme.isMobile(context);
    final categories = [
      {
        'title': 'Product',
        'icon': Icons.inventory_2_outlined,
        'color': MyColor.primary,
        'screen': ProductScreen(),
      },
      {
        'title': 'Customer',
        'icon': Icons.people_outlined,
        'color': const Color(0xFF10B981),
        'screen': CustomerScreen(),
      },
      {
        'title': 'Due',
        'icon': Icons.credit_card_outlined,
        'color': MyColor.warning,
        'screen': DueScreen(),
      },
      {
        'title': 'Ledger',
        'icon': Icons.book_outlined,
        'color': const Color(0xFF6366F1),
        'screen': LedgerScreen(),
      },
      {
        'title': 'Profit / Loss',
        'icon': Icons.bar_chart_outlined,
        'color': const Color(0xFF059669),
        'screen': ProfitLossScreen(),
      },
      {
        'title': 'Purchase',
        'icon': Icons.shopping_bag_outlined,
        'color': const Color(0xFF8B5CF6),
        'screen': PurchaseScreen(),
      },
      {
        'title': 'Sales',
        'icon': Icons.point_of_sale_outlined,
        'color': MyColor.success,
        'screen': SalesScreen(),
      },
      {
        'title': 'Stock',
        'icon': Icons.warehouse_outlined,
        'color': const Color(0xFF0EA5E9),
        'screen': StockScreen(),
      },
      {
        'title': 'Warehouse',
        'icon': Icons.store_outlined,
        'color': const Color(0xFFF97316),
        'screen': WarehouseScreen(),
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quick Access', style: Theme.of(context).textTheme.titleLarge),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: MyColor.primary),
              ),
            ),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 3 : 4,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 0.9,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(
              context: context,
              title: category['title'] as String,
              icon: category['icon'] as IconData,
              color: category['color'] as Color,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => category['screen'] as Widget,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String trend,
    required bool isPositive,
  }) {
    final isMobile = AppTheme.isMobile(context);
    return Container(
      padding: EdgeInsets.all(isMobile ? 16.w : 12.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: MyColor.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: color, size: 20.w),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPositive
                      ? MyColor.success.withOpacity(0.1)
                      : MyColor.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 12.w,
                      color: isPositive ? MyColor.success : MyColor.error,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      trend,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isPositive ? MyColor.success : MyColor.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.w),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: MyColor.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: MyColor.outlineVariant, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: MyColor.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activity',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          _buildActivityItem(
            context: context,
            icon: Icons.check_circle_outline,
            title: 'New order received',
            subtitle: '2 minutes ago',
            color: MyColor.success,
          ),
          Divider(height: 24.h, color: MyColor.outlineVariant),
          _buildActivityItem(
            context: context,
            icon: Icons.person_add_outlined,
            title: 'New customer registered',
            subtitle: '15 minutes ago',
            color: const Color(0xFF0984E3),
          ),
          Divider(height: 24.h, color: MyColor.outlineVariant),
          _buildActivityItem(
            context: context,
            icon: Icons.inventory_2_outlined,
            title: 'Low stock alert',
            subtitle: '1 hour ago',
            color: MyColor.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
