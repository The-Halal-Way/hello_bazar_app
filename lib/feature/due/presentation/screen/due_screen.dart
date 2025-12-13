import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/due/data/model/due_user.dart';
import 'package:hello_bazar/feature/due/presentation/screen/due_add_screen.dart';
import 'package:hello_bazar/feature/due/presentation/screen/due_user_details_screen.dart';

class DueScreen extends StatefulWidget {
  const DueScreen({super.key});
  @override
  State<DueScreen> createState() => _DueScreenState();
}

class _DueScreenState extends State<DueScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<DueUser> _dueUsers = [
    DueUser(
      name: 'John Doe',
      phone: '+880 1712-345678',
      dueAmount: 1250.00,
      lastPurchase: '2 days ago',
      totalPurchases: 15,
    ),
    DueUser(
      name: 'Jane Smith',
      phone: '+880 1823-456789',
      dueAmount: 3500.00,
      lastPurchase: '1 week ago',
      totalPurchases: 28,
    ),
    DueUser(
      name: 'Mike Johnson',
      phone: '+880 1934-567890',
      dueAmount: 750.50,
      lastPurchase: '3 days ago',
      totalPurchases: 8,
    ),
    DueUser(
      name: 'Sarah Williams',
      phone: '+880 1645-678901',
      dueAmount: 5200.00,
      lastPurchase: '5 days ago',
      totalPurchases: 42,
    ),
    DueUser(
      name: 'Robert Brown',
      phone: '+880 1756-789012',
      dueAmount: 980.00,
      lastPurchase: '1 day ago',
      totalPurchases: 12,
    ),
  ];

  List<DueUser> get _filteredUsers {
    if (_searchQuery.isEmpty) return _dueUsers;
    return _dueUsers.where((user) {
      return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.phone.contains(_searchQuery);
    }).toList();
  }

  double get _totalDue {
    return _dueUsers.fold(0, (sum, user) => sum + user.dueAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyDimens().getNormalAppBar("Due List", [
          IconButton(
            icon: Icon(Icons.add, color: MyColor.onSurfaceVariant),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DueAddScreen()),
              );
            },
          ),
          SizedBox(width: 8.w),
        ], context),
        // Summary Card
        Container(
          margin: EdgeInsets.all(12.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColor.primary, MyColor.primary.withOpacity(0.85)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: MyColor.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Due Amount',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: MyColor.onPrimary.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '৳${_totalDue.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: MyColor.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: MyColor.onPrimary,
                  size: 32.sp,
                ),
              ),
            ],
          ),
        ),

        // Search Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextField(
            controller: _searchController,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search by name or phone',
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

        // User Count
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_filteredUsers.length} Users',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: MyColor.gray600,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Sort by: Amount',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: MyColor.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Due Users List
        Expanded(
          child: _filteredUsers.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64.sp,
                        color: MyColor.gray300,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No users found',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: MyColor.gray500,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    return _buildDueUserCard(_filteredUsers[index]);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildDueUserCard(DueUser user) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DueUserDetailsScreen(user: user)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
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
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: MyColor.primaryFixed,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      user.name.split(' ').map((e) => e[0]).take(2).join(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: MyColor.primary,
                        fontWeight: FontWeight.bold,
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
                        user.name,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 14.sp,
                            color: MyColor.gray500,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            user.phone,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: MyColor.gray500),
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
                      '৳${user.dueAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: MyColor.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Due',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: MyColor.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(height: 1.h, color: MyColor.outlineVariant),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip(
                  icon: Icons.shopping_cart,
                  label: '${user.totalPurchases} purchases',
                  color: MyColor.primary,
                ),
                _buildInfoChip(
                  icon: Icons.access_time,
                  label: user.lastPurchase,
                  color: MyColor.gray600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: color),
        SizedBox(width: 4.w),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
