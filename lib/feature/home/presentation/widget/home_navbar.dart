import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/constants/my_constants.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar({
    super.key,
    required this.currentPage,
    required this.onPageChange,
  });
  final int currentPage;
  final Function onPageChange;

  @override
  Widget build(BuildContext context) {
    final itemWidth = 75.w, navBarHeight = 56.h;
    return Container(
      color: MyColor.white,
      height: navBarHeight,
      child: Row(
        mainAxisAlignment: .spaceAround,
        children: [
          //home icon
          _getNavBarItem(index: 0, width: itemWidth),
          // message icon
          _getNavBarItem(index: 1, width: itemWidth),
          // // cart icon button
          // HomeNavbarAddButton(
          //   itemWidth: itemWidth,
          //   bottomHeight: navBarHeight / 2,
          // ),

          // file icon
          _getNavBarItem(index: 2, width: itemWidth),
          // people icon
          _getNavBarItem(index: 3, width: itemWidth),
        ],
      ),
    );
  }

  Widget _getNavBarItem({required int index, required double width}) =>
      GestureDetector(
        onTap: () => onPageChange(index),
        // child: SizedBox(
        //   width: width,
        child: Image.asset(
          currentPage == index
              ? MyConstants.navItemSelectedImages[index]
              : MyConstants.navItemImages[index],
          color: currentPage == index ? MyColor.primary : null,
        ),
        //),
      );
}
