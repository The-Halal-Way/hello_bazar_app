import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/customer/presentation/screen/customer_screen.dart';
import 'package:hello_bazar/feature/ledger/presentation/screen/ledger_screen.dart';
import 'package:hello_bazar/feature/profit_loss/presentation/screen/profit_loss_screen.dart';
import 'package:hello_bazar/feature/sales/presentation/screen/sales_screen.dart';

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
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBanner(context),
                  SizedBox(height: 30.h),
                  Text(
                    'Today\'s Overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10.h),

                  _buildStatsGrid(context),

                  SizedBox(height: 24.h),

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
    return Container(
      //   height: 160.h,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColor.primary, MyColor.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: MyColor.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back! 👋',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: MyColor.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your Store is Performing Great!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: MyColor.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '📈 +12.5% from yesterday',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: MyColor.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1.4,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SalesScreen()),
                );
              },
              child: _buildStatCard(
                context: context,
                title: 'Total Sales',
                value: '৳ 12,458',
                icon: Icons.shopping_bag_outlined,
                color: MyColor.success,
                percentage: '+8.2%',
                isPositive: true,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfitLossScreen()),
                );
              },
              child: _buildStatCard(
                context: context,
                title: 'Orders',
                value: '342',
                icon: Icons.receipt_long_outlined,
                color: const Color(0xFF0984E3),
                percentage: '+5.1%',
                isPositive: true,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CustomerScreen()),
                );
              },
              child: _buildStatCard(
                context: context,
                title: 'Customers',
                value: '1,256',
                icon: Icons.people_outline,
                color: MyColor.warning,
                percentage: '+12.3%',
                isPositive: true,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LedgerScreen()),
                );
              },
              child: _buildStatCard(
                context: context,
                title: 'Revenue',
                value: '৳ 8,942',
                icon: Icons.trending_up_outlined,
                color: MyColor.error,
                percentage: '-2.4%',
                isPositive: false,
              ),
            ),
          ],
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
    required String percentage,
    required bool isPositive,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                  child: Icon(icon, color: color, size: 20.sp),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? MyColor.success.withOpacity(0.1)
                        : MyColor.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    percentage,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isPositive ? MyColor.success : MyColor.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: MyColor.gray500),
                ),
              ],
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
