import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:ahmoma_app/utils/constants/enums.dart';
import 'package:ahmoma_app/utils/constants/image_string.dart';
import 'package:ahmoma_app/utils/widgets/elevated_button_widget.dart';
import 'package:ahmoma_app/utils/widgets/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension MediaQueryValues on BuildContext {
  double get statusBarHeight => MediaQuery.of(this).viewPadding.top;

  double get navigationBarHeight => MediaQuery.of(this).viewPadding.bottom;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  void showCustomToast(
    BuildContext context, {
    required String title,
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(milliseconds: 2000),
    Widget? avatar,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry; // Declare first

    overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: ToastWidget(
              title: title,
              message: message,
              type: type,
              avatar: avatar,
              onClose: () {
                if (overlayEntry.mounted) {
                  overlayEntry.remove();
                }
              },
            ),
          ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  void showToast(
    String message, {
    Duration? duration,
    double? marginBottom,
    Color? backgroundColor,
    bool isSnackBar = false,
  }) {
    // ScaffoldMessenger.of(this).showSnackBar(SnackBar(
    //   content: Text(
    //     message,
    //     style: const TextStyle(fontWeight: FontWeight.w500),
    //     textAlign: TextAlign.center,
    //   ),
    //   duration: duration ?? const Duration(milliseconds: 1000),
    //   margin: isSnackBar
    //       ? null
    //       : EdgeInsets.symmetric(horizontal: 64, vertical: marginBottom ?? 24),
    //   backgroundColor: backgroundColor ?? Colors.grey,
    //   behavior: isSnackBar ? null : SnackBarBehavior.floating,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    // ));1
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showError([String message = 'Có lỗi xảy ra!']) {
    showToast(message, backgroundColor: const Color(0xffff5722));
  }

  void showSnackBarError([String message = 'Có lỗi xảy ra!']) {
    showToast(
      message,
      backgroundColor: const Color(0xffff5722),
      isSnackBar: true,
    );
  }

  void showSuccess(String message, {bool isSnackBar = false}) {
    showToast(message, backgroundColor: Colors.green, isSnackBar: isSnackBar);
  }

  void showSnackBarSuccess(String msg) {
    final dynamic scf = ScaffoldMessenger.of(this);
    scf.hideCurrentSnackBar();
    scf.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        content: Text(msg),
      ),
    );
  }

  Future showAlertDialog({
    required String title,
    required String content,
    String leftText = "Back",
    String rightText = "Yes",
    required Function() onOk,
  }) async {
    await showDialog(
      context: this,
      builder:
          (_) => AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        SvgPicture.asset(AppImageStrings.successIcon),
                        SizedBox(height: AppSizes.spaceBtwItems,),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(this).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: AppSizes.fontSizeLg + 6,
                          ),
                        ),
                        Text(
                          content,
                          textAlign: TextAlign.center,
                          style: Theme.of(this).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizes.fontSizeMd,
                            color: AppColors.textDialog,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceBtwSections,),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                          ),
                          onTap: onOk,
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32.0),
                              ),
                              gradient: LinearGradient(
                                colors: [AppColors.primary, AppColors.primary1],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Text(
                              rightText,
                              style: Theme.of(this).textTheme.titleLarge?.copyWith(
                                color: AppColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(32.0),
                          ),
                          onTap: () => Navigator.of(this).pop(),
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(32.0),
                              ),
                              color: AppColors.bgCancel,
                            ),
                            child: Text(
                              leftText,
                              style: Theme.of(this).textTheme.titleLarge?.copyWith(
                                color: AppColors.textDialog,
                                fontWeight: FontWeight.w500,
                                fontSize: AppSizes.fontSizeMd,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
    );
  }

  Future showConfirmDialog({
    required String title,
    required String content,
    String leftText = "Back",
    String rightText = "Yes",
    required Function() onOk,
  }) async {
    await showDialog(
      context: this,
      builder:
          (_) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SvgPicture.asset(AppImageStrings.successIcon),
                    SizedBox(height: AppSizes.spaceBtwItems,),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(this).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: AppSizes.fontSizeLg + 6,
                      ),
                    ),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: Theme.of(this).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: AppSizes.fontSizeMd,
                        color: AppColors.textDialog,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.spaceBtwSections,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                      ),
                      onTap: () => Navigator.of(this).pop(),
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                          ),
                          color: AppColors.bgCancel,
                        ),
                        child: Text(
                          leftText,
                          style: Theme.of(this).textTheme.titleLarge?.copyWith(
                            color: AppColors.textDialog,
                            fontWeight: FontWeight.w500,
                            fontSize: AppSizes.fontSizeMd,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(32.0),
                      ),
                      onTap: onOk,
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(32.0),
                          ),
                          gradient: LinearGradient(colors: [
                            AppColors.primary1,
                            AppColors.primary,
                          ])
                        ),
                        child: Text(
                          rightText,
                          style: Theme.of(this).textTheme.titleLarge?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showDialogWidget({required String title, required Widget builderWidget}) {
    showDialog(context: this, builder: (_) => builderWidget);
  }

  showActionSheet({String? title, String? message, List<Widget>? actions}) {
    showCupertinoModalPopup<void>(
      context: this,
      builder:
          (BuildContext context) => CupertinoActionSheet(
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(this);
              },
              child: Text(
                'context.locale.cancel',
                style: Theme.of(this).textTheme.bodyMedium?.copyWith(
                  color: CupertinoColors.systemRed,
                ),
              ),
            ),
          ),
    );
  }

  showAlertNotify(
    BuildContext context,
    String message, {
    Color? bgColor,
    bool? isSuccess = true,
  }) {
    showDialog(
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsetsDirectional.all(10),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 100.0,
            vertical: 100.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor:
              bgColor ??
              (isSuccess == true
                  ? Colors.green.withOpacity(0.85)
                  : Colors.red.withOpacity(0.85)),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSuccess == true
                    ? Icons.done_rounded
                    : CupertinoIcons.clear_thick,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );

    // Đóng AlertDialog sau 2 giây
    Future.delayed(const Duration(milliseconds: 450), () {
      Navigator.of(context).pop(); // Đóng hộp thoại
    });
  }

  showDialogSuccessfully({
    required BuildContext context,
    String? title,
    String? message,
    String? btnLabel,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(AppImageStrings.notifySuccessIcon),
                      SizedBox(height: AppSizes.spaceBtwItems,),
                      Text(
                        "Password Changed",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppSizes.fontSizeLg + 6,
                        ),
                      ),
                      SizedBox(height: AppSizes.spaceBtwItems/2,),
                      Text(
                        'Successfully',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: AppSizes.fontSizeMd,
                        ),
                      ),
                      SizedBox(height: AppSizes.spaceBtwItems,),
                      Text(
                        ' You can now login to the app.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: AppSizes.fontSizeMd,
                          color: AppColors.textDialog,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.spaceBtwSections,),
                InkWell(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0),
                  ),
                  onTap: onPressed,
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                        bottomRight: Radius.circular(32.0),
                      ),
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.primary1],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      btnLabel ?? 'OK',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
