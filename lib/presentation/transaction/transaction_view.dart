import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionView extends StatelessWidget {
  static const String id = '/transaction_view';

  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    List<Map<String, dynamic>> items = [
      {'image': Strings.masterCard,'title': 'Master Card', 'subtitle': 'Dec 12 2021 at 10:00 pm', 'price': 89},
      {'image': Strings.visa,'title': 'Master Card', 'subtitle': 'Dec 12 2021 at 10:00 pm', 'price': 109},
      {'image': Strings.paypal,'title': 'Paypal', 'subtitle': 'Dec 12 2021 at 10:00 pm', 'price': 567},
      {'image': Strings.paypal,'title': 'Paypal', 'subtitle': 'Dec 12 2021 at 10:00 pm', 'price': 567},
      {'image': Strings.visa,'title': 'Master Card', 'subtitle': 'Dec 12 2021 at 10:00 pm', 'price': 109},
      {'image': Strings.masterCard,'title': 'Master Card', 'subtitle': 'Dec 12 2021 at 10:00 pm', 'price': 89},
    ];
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: PrimaryAppBar(title: 'Transaction', statusBarHeight: statusBarHeight),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 25),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            color: AppColors.white,
            shape: RoundedRectangleBorder(),
            margin: EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () {
                // same as ListTile onTap
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.white3,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(items[index]['image']),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items[index]['title'],
                              style: interSemiBold.copyWith(
                                  fontSize: 15, color: AppColors.black)),
                          SizedBox(height: 3,),
                          Text(items[index]['subtitle'],
                              style: interRegular.copyWith(
                                  fontSize: 10, color: AppColors.black)),
                        ],
                      ),
                    ),
                    Text(
                      '\$${items[index]['price']}',
                      style: interSemiBold.copyWith(
                          fontSize: 15, color: AppColors.green),
                    ),
                  ],
                ),
              ),
            ),
          );
          // return Card(
          //     elevation: 0,
          //     color: AppColors.white,
          //     shape: RoundedRectangleBorder(),
          //     margin: EdgeInsets.only(bottom: 10),
          //     child: ListTile(
          //       contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
          //       dense: true,
          //       onTap: (){},
          //       leading: SizedBox(
          //         width: 72,
          //         height: 72,
          //         child: Container(
          //           decoration: BoxDecoration(
          //               color: AppColors.white3,
          //               shape: BoxShape.circle
          //           ),
          //           alignment: Alignment.center,
          //           child: SvgPicture.asset(items[index]['image']),
          //         ),
          //       ),
          //       title: Text(items[index]['title'], style: interSemiBold.copyWith(fontSize: 15, color: AppColors.black),),
          //       subtitle: Text(items[index]['subtitle'], style: interRegular.copyWith(fontSize: 10, color: AppColors.black),),
          //       trailing: Text('\$${items[index]['price']}', style: interSemiBold.copyWith(fontSize: 15, color: AppColors.green),),
          //     )
          // );
        },
      ),
    );
  }
}
