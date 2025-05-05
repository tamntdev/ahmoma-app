import 'package:ahmoma_app/utils/constants/enums.dart';
import 'package:ahmoma_app/utils/widgets/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      builder: (context) => Positioned(
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
        fontSize: 16.0
    );
  }

  void showError([String message = 'Có lỗi xảy ra!']) {
    showToast(message, backgroundColor: const Color(0xffff5722));
  }

  void showSnackBarError([String message = 'Có lỗi xảy ra!']) {
    showToast(message, backgroundColor: const Color(0xffff5722), isSnackBar: true);
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
    String leftText = "No",
    String rightText = "Yes",
    required Function() onOk,
  }) async{
    await showDialog(
      context: this,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(this),
            child: Text(leftText),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onOk,
            child: Text(rightText),
          )
        ],
      ),
    );
  }

  showDialogWidget({
    required String title,
    required Widget builderWidget
  }) {
    showDialog(
      context: this,
      builder: (_) => builderWidget,
    );
  }

  showActionSheet({String? title, String? message, List<Widget>? actions}) {
    showCupertinoModalPopup<void>(
      context: this,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: actions,
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(this);
          },
          child: Text(
            'context.locale.cancel',
            style: Theme.of(this).textTheme.bodyMedium?.copyWith(color: CupertinoColors.systemRed),
          ),
        ),
      ),
    );
  }

  showAlertNotify(BuildContext context, String message, {Color? bgColor, bool? isSuccess = true}) {
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
          backgroundColor: bgColor ?? (isSuccess == true ? Colors.green.withOpacity(0.85) : Colors.red.withOpacity(0.85)),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isSuccess == true? Icons.done_rounded : CupertinoIcons.clear_thick, color: Colors.white , size: 48,),
              const SizedBox(height: 10,),
              Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),
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
}

