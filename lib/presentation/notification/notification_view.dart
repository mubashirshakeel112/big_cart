import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationView extends StatefulWidget {
  static const String id = '/notification_view';

  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  bool allowNotifications = true;
  bool emailNotifications = false;
  bool orderNotifications = false;
  bool generalNotifications = true;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: PrimaryAppBar(title: 'Notifications', statusBarHeight: statusBarHeight),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 17, right: 17, top: 33),
              children: [
                NotificationTile(
                  title: "Allow Notifications",
                  subtitle: "Lorem ipsum dolor sit amet, consectetur sadi psicing elit, sed diam nonummyn",
                  value: allowNotifications,
                  onChanged: () {
                    setState(() => allowNotifications = !allowNotifications);
                  },
                ),
                NotificationTile(
                  title: "Email Notifications",
                  subtitle: "Lorem ipsum dolor sit amet, consectetur sadi psicing elit, sed diam nonummyn",
                  value: emailNotifications,
                  onChanged: () {
                    setState(() => emailNotifications = !emailNotifications);
                  },
                ),
                NotificationTile(
                  title: "Order Notifications",
                  subtitle: "Lorem ipsum dolor sit amet, consectetur sadi psicing elit, sed diam nonummyn",
                  value: orderNotifications,
                  onChanged: () {
                    setState(() => orderNotifications = !orderNotifications);
                  },
                ),
                NotificationTile(
                  title: "General Notifications",
                  subtitle: "Lorem ipsum dolor sit amet, consectetur sadi psicing elit, sed diam nonummyn",
                  value: generalNotifications,
                  onChanged: () {
                    setState(() => generalNotifications = !generalNotifications);
                  },
                ),
              ],
            ),
          ),

          // Save Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              title: 'Save settings',
            ),
          ),
          SizedBox(height: 36),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final VoidCallback? onChanged;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, top: 19, bottom: 9, right: 4),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(title, style: interSemiBold.copyWith(fontSize: 15, color: AppColors.black)),
        ),
        subtitle: Text(subtitle, style: interMedium.copyWith(fontSize: 12)),
        trailing: IconButton(
          onPressed: onChanged,
          icon: SvgPicture.asset(value ? Strings.toggleFill : Strings.toggleOutline),
        ),
      ),
    );
  }
}
