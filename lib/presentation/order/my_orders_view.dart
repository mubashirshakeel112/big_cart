import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOrdersView extends StatelessWidget {
  static const String id = '/my_order_view';

  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: PrimaryAppBar(title: 'My Order', statusBarHeight: statusBarHeight),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          OrderCard(
            orderId: "#90897",
            date: "October 19 2021",
            items: 10,
            price: 16.90,
            statuses: const [
              OrderStatus("Order placed", "Oct 19 2021", true),
              OrderStatus("Order confirmed", "Oct 20 2021", true),
              OrderStatus("Order shipped", "Oct 20 2021", true),
              OrderStatus("Out for delivery", "pending", false),
              OrderStatus("Order delivered", "pending", false),
            ],
          ),
          const SizedBox(height: 12),
          OrderCard(orderId: "#90897", date: "October 18 2021", items: 10, price: 16.90, deliveredDate: "Aug 29 2021"),
        ],
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  final String orderId;
  final String date;
  final int items;
  final double price;
  final String? deliveredDate;
  final List<OrderStatus>? statuses;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.items,
    required this.price,
    this.deliveredDate,
    this.statuses,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 21, bottom: 21, left: 19, right: 16),
              child: Row(
                children: [
                   Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      color: AppColors.green3,
                      shape: BoxShape.circle
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(Strings.orderBox),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Order ${widget.orderId}",
                            style: interSemiBold.copyWith(fontSize: 15, color: AppColors.black)),
                        Text("Placed on ${widget.date}",
                            style: interMedium.copyWith(fontSize: 10)),
                        SizedBox(height: 5,),
                        Text("Items: ${widget.items}   Total: \$${widget.price}",
                            style: interMedium.copyWith(fontSize: 10, color: AppColors.black)),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: SvgPicture.asset(Strings.arrowDownwardCircular,),
                  )
                ],
              ),
            ),
          ),

          // Animated Expandable Section
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            height: _expanded ? (widget.statuses?.length ?? 0) * 45 + (widget.deliveredDate != null ? 55 : 0) : 0,
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Divider(
                    height: 0,
                    color: AppColors.grey3,
                  ),
                  SizedBox(height: 20,),
                  if (widget.statuses != null)
                    Padding(
                      padding: EdgeInsets.only(left: 19, right: 25),
                      child: Column(children: widget.statuses!.map((s) => OrderTimelineTile(status: s)).toList()),
                    ),
                  if (widget.deliveredDate != null)
                    Padding(
                      padding: EdgeInsets.only(left: 19, right: 25),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColors.grey3,
                              shape: BoxShape.circle
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Text(
                              "Order Delivered",
                              style: interSemiBold.copyWith(fontSize: 12),
                            ),
                          ),
                          Text(
                            "${widget.deliveredDate}",
                            style: interSemiBold.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderTimelineTile extends StatelessWidget {
  final OrderStatus status;

  const OrderTimelineTile({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.circle, size: 12, color: status.isDone ? AppColors.primary : AppColors.grey3),
            Container(width: 2, height: 25, color: AppColors.grey2),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status.title,
                  style: interSemiBold.copyWith(fontSize: 12, color: status.isDone ? AppColors.black : AppColors.grey),
                ),
                Text(status.date, style: interRegular.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OrderStatus {
  final String title;
  final String date;
  final bool isDone;

  const OrderStatus(this.title, this.date, this.isDone);
}
