// ignore_for_file: use_build_context_synchronously
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';

class MyDialog {
  void showSuccessToast({
    required String msg,
    String title = "Successful",
    required BuildContext context,
  }) {
    ElegantNotification.success(
      isDismissable: false,
      position: Alignment.topCenter,
      toastDuration: const Duration(milliseconds: 2300),
      animation: AnimationType.fromTop,
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      description: Text(
        msg,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyLarge!,
      ),
      shadow: BoxShadow(
        color: Colors.green.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 4),
      ),
    ).show(context);
  }

  void showInfoToast({
    required String msg,
    String title = "Opps !!",
    required BuildContext context,
  }) {
    ElegantNotification.info(
      isDismissable: false,
      position: Alignment.topCenter,
      toastDuration: const Duration(milliseconds: 2300),
      animation: AnimationType.fromTop,
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      description: Text(
        msg,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyLarge!,
      ),
      shadow: BoxShadow(
        color: Color(0xFF01204E).withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 4),
      ),
    ).show(context);
  }

  void showFailedToast({
    required String msg,
    String title = "Failed",
    required BuildContext context,
  }) {
    ElegantNotification.error(
      stackedOptions: StackedOptions(
        key: 'topRight',
        type: StackedType.below,
        itemOffset: const Offset(0, 5),
      ),
      position: Alignment.topRight,
      toastDuration: const Duration(milliseconds: 2300),
      animation: AnimationType.fromRight,
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      description: Text(
        msg,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyLarge!,
      ),
    ).show(context);
  }
}
