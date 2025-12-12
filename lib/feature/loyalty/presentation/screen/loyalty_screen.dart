// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/loyalty/presentation/screen/loyalty_add_screen.dart';

class LoyaltyScreen extends StatelessWidget {
  const LoyaltyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyDimens().getNormalAppBar("Loyalty", [
          IconButton(
            icon: Icon(Icons.add, size: 20.w),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoyaltyAddScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ], context),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20.h,
                children: [
                  // Quick Stats Summary (Compact)
                  _buildQuickSummary(context),

                  // Points Overview Cards (2 cards only)
                  _buildPointsOverview(context),

                  // Recent Transactions List
                  _buildTransactionList(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickSummary(BuildContext context) {
    return Container(
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
            blurRadius: 15.w,
            offset: Offset(0.w, 6.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: MyColor.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium,
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
                  'Total Active Points',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.onPrimary.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '2,450 Points',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: MyColor.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '42 active members',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.onPrimary.withOpacity(0.85),
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
    );
  }

  Widget _buildPointsOverview(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildPointsCard(
            context: context,
            title: 'Points Earned',
            value: '+1,240',
            subtitle: 'Today',
            icon: Icons.arrow_upward,
            color: MyColor.success,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildPointsCard(
            context: context,
            title: 'Points Redeemed',
            value: '-580',
            subtitle: 'Today',
            icon: Icons.arrow_downward,
            color: MyColor.error,
          ),
        ),
      ],
    );
  }

  Widget _buildPointsCard({
    required BuildContext context,
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
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
            offset: const Offset(0, 2),
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
            child: Icon(icon, color: color, size: 20.w),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: color,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: MyColor.gray500,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    final transactions = [
      {
        'customer': 'John Doe',
        'points': '+150',
        'amount': '৳ 2,450',
        'time': '10:30 AM',
        'type': 'earned',
        'icon': Icons.shopping_bag_outlined,
      },
      {
        'customer': 'Jane Smith',
        'points': '-75',
        'amount': '৳ 1,200',
        'time': '11:15 AM',
        'type': 'redeemed',
        'icon': Icons.card_giftcard_outlined,
      },
      {
        'customer': 'Mike Johnson',
        'points': '+200',
        'amount': '৳ 3,000',
        'time': '01:45 PM',
        'type': 'earned',
        'icon': Icons.local_offer_outlined,
      },
      {
        'customer': 'Sarah Wilson',
        'points': '+120',
        'amount': '৳ 1,800',
        'time': '03:20 PM',
        'type': 'earned',
        'icon': Icons.restaurant_outlined,
      },
      {
        'customer': 'Alex Brown',
        'points': '-50',
        'amount': '৳ 850',
        'time': '04:10 PM',
        'type': 'redeemed',
        'icon': Icons.coffee_outlined,
      },
      {
        'customer': 'Emma Davis',
        'points': '+90',
        'amount': '৳ 1,400',
        'time': '05:00 PM',
        'type': 'earned',
        'icon': Icons.shopping_cart_outlined,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
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
        SizedBox(height: 8.h),
        Container(
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
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: transactions.length,
            separatorBuilder: (context, index) => Divider(
              height: 1.h,
              color: MyColor.outlineVariant,
              indent: 16.w,
              endIndent: 16.w,
            ),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return _buildTransactionItem(context, transaction);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    Map<String, dynamic> transaction,
  ) {
    final isEarned = transaction['type'] == 'earned';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: isEarned
                  ? MyColor.success.withOpacity(0.1)
                  : MyColor.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              transaction['icon'],
              color: isEarned ? MyColor.success : MyColor.error,
              size: 22.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['customer'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      transaction['amount'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.gray600,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 3.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: MyColor.gray400,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      transaction['time'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: MyColor.gray500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction['points'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isEarned ? MyColor.success : MyColor.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isEarned
                      ? MyColor.success.withOpacity(0.1)
                      : MyColor.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  isEarned ? 'Earned' : 'Redeemed',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isEarned ? MyColor.success : MyColor.error,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
