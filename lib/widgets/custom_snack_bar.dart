import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:flutter/material.dart';


class CustomSnackBar {

  static successSnackBar({required BuildContext context,required String title,required String message}){
    return _show(context, title: title, message: message, icon: Icons.check_circle, iconColor: Colors.green);
  }

  static errorSnackBar({required BuildContext context,required String title,required String message}){
    return _show(context, title: title, message: message, icon: Icons.cancel, iconColor: AppColors.red);
  }

  static missingInfo({required BuildContext context,required String title,required String message}){
    return _show(context, title: title, message: message, icon: Icons.warning_amber, iconColor: AppColors.yellow);
  }


  static void _show(
      BuildContext context, {
        required String title,
        required String message,
        IconData? icon,
        Duration duration = const Duration(seconds: 3),
        Color backgroundColor = AppColors.white,
        Color textColor = AppColors.black,
        Color iconColor = Colors.white,
      }) {
    final overlay = Overlay.of(context);

    final key = GlobalKey<_TopSnackBarContentState>();
    final overlayEntry = OverlayEntry(
      builder: (_) => _TopSnackBarContent(
        key: key,
        title: title,
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
        textColor: textColor,
        iconColor: iconColor,
      ),
    );

    // Insert immediately without waiting for post-frame callback
    overlay.insert(overlayEntry);

    // Reverse animation & remove
    Future.delayed(duration, () async {
      await key.currentState?.hide();
      overlayEntry.remove();
    });
  }
}

class _TopSnackBarContent extends StatefulWidget {
  final String title;
  final String message;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const _TopSnackBarContent({
    Key? key,
    required this.title,
    required this.message,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  State<_TopSnackBarContent> createState() => _TopSnackBarContentState();
}

class _TopSnackBarContentState extends State<_TopSnackBarContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Reduced duration
    );

    // Use a faster curve for snappier animation
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0), // Less dramatic slide
      end: Offset.zero,
    ).animate(curvedAnimation);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);

    // Start animation immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  Future<void> hide() async {
    if (mounted) {
      await _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor,
                        size: 24,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            widget.title,
                            style: interBold.copyWith(fontSize: 16, color: widget.textColor, decoration: TextDecoration.none)
                        ),
                        const SizedBox(height: 4),
                        Text(
                            widget.message,
                            style: interRegular.copyWith(fontSize: 14, color: widget.textColor, decoration: TextDecoration.none)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}