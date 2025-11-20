import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';

class MyDimens {
  Center getDemoPage(String title) => Center(child: Text(title));

  static List<BoxShadow> get getShadow => [
    BoxShadow(
      offset: Offset(3.w, 3.h),
      blurRadius: 5.r,
      color: MyColor.gray200,
    ),
  ];

  static const cmDivider = Divider(color: MyColor.gray300, thickness: .5);

  AppBar getNormalAppBar(
    String title,
    List<Widget> actions,
    BuildContext ctx, [
    bool backButton = false,
  ]) => AppBar(
    leading: backButton
        ? IconButton(
            onPressed: () => Navigator.pop(ctx),
            icon: const Icon(Icons.arrow_back_ios_new),
          )
        : const SizedBox(),
    title: Text(title),
    centerTitle: true,
    actions: actions,
    backgroundColor: MyColor.primary,
  );

  SliverAppBar getSliverAppbar(
    String title,
    List<Widget> actions,
    BuildContext ctx, [
    bool backButton = false,
  ]) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: backButton
          ? IconButton(
              onPressed: () => Navigator.pop(ctx),
              icon: const Icon(Icons.arrow_back_ios_new),
            )
          : const SizedBox(),
      title: Text(title),
      actions: actions,
    );
  }

  Padding getTitleAndViewAll(String title, BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 12.w, right: 12.w, bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w900,
              color: MyColor.gray900,
            ),
          ),
          Text(
            "View All",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: MyColor.success,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  static Center get getLoadingIndication =>
      const Center(child: CircularProgressIndicator());

  static Center get getNoItemText => const Center(
    child: SizedBox(
      height: 800,
      width: 80,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No data found..',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    ),
  );
}
