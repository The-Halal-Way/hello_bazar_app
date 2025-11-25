import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/constants/my_icon.dart';
import 'package:hello_bazar/core/constants/my_image.dart';
import 'package:hello_bazar/feature/common/presentation/widget/textfield_widgets/cm_name_email_field.dart';

class DashboardAppbar extends StatelessWidget {
  const DashboardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 20.h, 16.0, 16.0),
      color: MyColor.primary,
      child: SafeArea(
        child: Form(
          child: Column(
            spacing: 20.h,
            children: [
              Row(
                spacing: 10.w,
                crossAxisAlignment: .center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(MyImage.profilePic),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        // top texts
                        Text(
                          "Hello Jb",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Mobile App Developer",
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10.w,
                crossAxisAlignment: .center,
                children: [
                  Expanded(
                    child: CmNameEmailField(
                      controller: TextEditingController(),
                      label: "Search..",
                      readOnly: false,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(11.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: MyColor.white,
                    ),
                    child: Image.asset(MyIcon.settings),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
