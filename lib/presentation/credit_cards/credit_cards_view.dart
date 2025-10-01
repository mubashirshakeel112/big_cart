import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:big_cart/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreditCardView extends StatefulWidget {
  static const String id = '/credit_card_view';

  const CreditCardView({super.key});

  @override
  State<CreditCardView> createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  bool isToggle = false;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.white2,
      body: Column(
        children: [
          PrimaryAppBar(title: 'Add Credit Card', statusBarHeight: statusBarHeight),
          Expanded(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 33),
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [AppColors.primary2, AppColors.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(Strings.masterCard, width: 34, height: 34),
                      SizedBox(height: 11),
                      const Text(
                        'XXXX XXXX XXXX 8790',
                        style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CARD HOLDER', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              Text(
                                'RUSSELL AUSTIN',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('EXPIRES', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              Text(
                                '01 / 22',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                CustomTextField(
                  hintText: 'Name on the card',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: SvgPicture.asset(Strings.profile),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 17),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Card number',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: SvgPicture.asset(Strings.creditCard, color: AppColors.grey),
                  ),
                  keyboardType: TextInputType.number,
                  margin: EdgeInsets.symmetric(horizontal: 17),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Month / Year',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: SvgPicture.asset(Strings.creditCard, color: AppColors.grey),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'CVV',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: SvgPicture.asset(Strings.creditCard, color: AppColors.grey),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9, top: 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isToggle = !isToggle;
                          });
                        },
                        icon: SvgPicture.asset(isToggle ? Strings.toggleFill : Strings.toggleOutline),
                      ),
                      SizedBox(width: 1),
                      const Text('Save this card'),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'Add credit card',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
