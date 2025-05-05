import 'package:ahmoma_app/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class ToastWidget extends StatefulWidget {
  const ToastWidget({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    required this.onClose,
    this.customIcon,
    this.avatar,
  });

  final String title;
  final String message;
  final ToastType type;
  final VoidCallback onClose;
  final Widget? customIcon;
  final Widget? avatar;

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ));

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 1500), () {
      dismiss();
    });
  }

  Future<void> dismiss() async {
    if (mounted && !_controller.isDismissed) {
      await _controller.reverse();
      if (mounted) {
        widget.onClose();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getColor() {
    switch (widget.type) {
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.red;
      case ToastType.warning:
        return Colors.orange;
      case ToastType.info:
        return Colors.blue;
      case ToastType.custom:
        return Colors.grey.shade800;
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(left: BorderSide(color: _getColor(), width: 5)),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(blurRadius: 6, color: Colors.black12),
              ],
            ),
            child: Row(
              children: [
                if (widget.avatar != null)
                  ClipOval(child: widget.avatar)
                else
                  Icon(
                    widget.customIcon != null ? null : _getIcon(),
                    color: _getColor(),
                  ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onClose,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
