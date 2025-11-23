// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/feature/dashboard/presentation/widget/dashboard_all_user_list.dart';
import 'package:hello_bazar/feature/dashboard/presentation/widget/dashboard_appbar.dart';
import 'package:hello_bazar/feature/dashboard/presentation/widget/dashboard_recent_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DashboardAppbar(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(12.h),
              child: Column(
                children: [
                  DashboardRecentList(),
                  SizedBox(height: 16.0),
                  DashboardAllUserList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
