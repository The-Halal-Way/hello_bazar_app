import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/feature/common/data/model/cm_user.dart';
import 'package:hello_bazar/feature/customer/presentation/screen/customer_add_screen.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});
  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'all'; // 'all', 'active', 'inactive', 'verified'

  final List<CmUser> _customers = [
    CmUser(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      image: '',
      gender: 'Male',
      mobileNo: '+880 1712-345678',
      isVerified: true,
      joinDate: DateTime(2024, 1, 15),
      userType: 'customer',
      isActive: true,
      totalSpent: 15420.00,
      loyaltyPoints: 1542,
      lastPurchaseDate: DateTime(2024, 12, 18),
    ),
    CmUser(
      id: '2',
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      image: '',
      gender: 'Female',
      mobileNo: '+880 1823-456789',
      isVerified: true,
      joinDate: DateTime(2024, 2, 20),
      userType: 'customer',
      isActive: true,
      totalSpent: 28500.00,
      loyaltyPoints: 2850,
      lastPurchaseDate: DateTime(2024, 12, 17),
    ),
    CmUser(
      id: '3',
      name: 'Mike Johnson',
      email: 'mike.j@example.com',
      image: '',
      gender: 'Male',
      mobileNo: '+880 1934-567890',
      isVerified: false,
      joinDate: DateTime(2024, 3, 10),
      userType: 'customer',
      isActive: true,
      totalSpent: 8900.00,
      loyaltyPoints: 890,
      lastPurchaseDate: DateTime(2024, 12, 15),
    ),
    CmUser(
      id: '4',
      name: 'Sarah Williams',
      email: 'sarah.w@example.com',
      image: '',
      gender: 'Female',
      mobileNo: '+880 1645-678901',
      isVerified: true,
      joinDate: DateTime(2024, 4, 5),
      userType: 'customer',
      isActive: false,
      totalSpent: 42300.00,
      loyaltyPoints: 4230,
      lastPurchaseDate: DateTime(2024, 11, 28),
    ),
    CmUser(
      id: '5',
      name: 'Robert Brown',
      email: 'robert.b@example.com',
      image: '',
      gender: 'Male',
      mobileNo: '+880 1756-789012',
      isVerified: true,
      joinDate: DateTime(2024, 5, 12),
      userType: 'customer',
      isActive: true,
      totalSpent: 12800.00,
      loyaltyPoints: 1280,
      lastPurchaseDate: DateTime(2024, 12, 16),
    ),
  ];

  List<CmUser> get _filteredCustomers {
    var filtered = _customers.where((customer) {
      final matchesSearch =
          customer.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          customer.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          customer.mobileNo.contains(_searchQuery);

      if (!matchesSearch) return false;

      switch (_selectedFilter) {
        case 'active':
          return customer.isActive;
        case 'inactive':
          return !customer.isActive;
        case 'verified':
          return customer.isVerified;
        default:
          return true;
      }
    }).toList();

    // Sort by last purchase date (most recent first)
    filtered.sort(
      (a, b) => (b.lastPurchaseDate ?? DateTime(2000)).compareTo(
        a.lastPurchaseDate ?? DateTime(2000),
      ),
    );

    return filtered;
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
        title: Text('Customers', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: MyColor.onSurfaceVariant),
            onPressed: _showFilterOptions,
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
                hintText: 'Search by name, email or phone',
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

          // Customer Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredCustomers.length} Customers',
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

          // Customer List
          Expanded(
            child: _filteredCustomers.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _filteredCustomers.length,
                    itemBuilder: (context, index) {
                      return _buildCustomerCard(_filteredCustomers[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomerAddScreen()),
          );
        },
        backgroundColor: MyColor.primary,
        icon: Icon(Icons.add, color: MyColor.onPrimary),
        label: Text(
          'Add Customer',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: MyColor.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryBanner() {
    final totalCustomers = _customers.length;
    final activeCustomers = _customers.where((c) => c.isActive).length;
    final totalSpent = _customers.fold<double>(
      0,
      (sum, c) => sum + c.totalSpent,
    );

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
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: MyColor.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.people, color: MyColor.white, size: 32.w),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Customers',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.onPrimary.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '$totalCustomers',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: MyColor.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$activeCustomers active • ৳${totalSpent.toStringAsFixed(0)} total spent',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: MyColor.onPrimary.withOpacity(0.85),
                  ),
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
          _buildFilterChip('All', 'all', _customers.length),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Active',
            'active',
            _customers.where((c) => c.isActive).length,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Inactive',
            'inactive',
            _customers.where((c) => !c.isActive).length,
          ),
          SizedBox(width: 8.w),
          _buildFilterChip(
            'Verified',
            'verified',
            _customers.where((c) => c.isVerified).length,
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

  Widget _buildCustomerCard(CmUser customer) {
    final daysSinceJoin = DateTime.now().difference(customer.joinDate).inDays;
    final lastPurchase = customer.lastPurchaseDate != null
        ? DateTime.now().difference(customer.lastPurchaseDate!).inDays
        : null;

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
            // Navigate to customer detail page
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    // Avatar
                    Container(
                      width: 56.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: MyColor.primaryFixed,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          customer.name
                              .split(' ')
                              .map((e) => e[0])
                              .take(2)
                              .join(),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: MyColor.primary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  customer.name,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (customer.isVerified)
                                Container(
                                  margin: EdgeInsets.only(left: 6.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColor.success.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        color: MyColor.success,
                                        size: 12.sp,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 12.sp,
                                color: MyColor.gray500,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                customer.mobileNo,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: MyColor.gray500),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 12.sp,
                                color: MyColor.gray500,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  customer.email,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: MyColor.gray500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                        color: customer.isActive
                            ? MyColor.success.withOpacity(0.1)
                            : MyColor.gray200,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        customer.isActive ? 'Active' : 'Inactive',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: customer.isActive
                              ? MyColor.success
                              : MyColor.gray600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Divider(height: 1.h, color: MyColor.outlineVariant),
                SizedBox(height: 12.h),
                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.shopping_bag_outlined,
                        label: 'Spent',
                        value: '৳${customer.totalSpent.toStringAsFixed(0)}',
                        color: MyColor.success,
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 32.h,
                      color: MyColor.outlineVariant,
                    ),
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.stars_outlined,
                        label: 'Points',
                        value: '${customer.loyaltyPoints}',
                        color: MyColor.warning,
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 32.h,
                      color: MyColor.outlineVariant,
                    ),
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.access_time,
                        label: 'Last Buy',
                        value: lastPurchase != null
                            ? lastPurchase == 0
                                  ? 'Today'
                                  : '${lastPurchase}d ago'
                            : 'Never',
                        color: MyColor.primary,
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

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 18.sp, color: color),
        SizedBox(height: 4.h),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: MyColor.gray500,
            fontSize: 10.sp,
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
          Icon(Icons.person_search, size: 80.sp, color: MyColor.gray300),
          SizedBox(height: 16.h),
          Text(
            'No customers found',
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

  void _showFilterOptions() {
    // Show additional filter options in a bottom sheet
  }
}
