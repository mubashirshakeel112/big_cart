import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:big_cart/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddAddressView extends StatefulWidget {
  static const String id = '/add_address_view';

  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  bool isToggle = false;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.white2,
      body: Column(
        children: [
          PrimaryAppBar(title: 'Add Address', statusBarHeight: statusBarHeight),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 36),
              children: [
                CustomTextField(
                  hintText: 'Name',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: SvgPicture.asset(Strings.profile),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 17),
                ),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Email address',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: SvgPicture.asset(Strings.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  margin: EdgeInsets.symmetric(horizontal: 17),
                ),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Phone number',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: SvgPicture.asset(Strings.telephone),
                  ),
                  keyboardType: TextInputType.phone,
                  margin: EdgeInsets.symmetric(horizontal: 17),
                ),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Address',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: SvgPicture.asset(Strings.address),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 17),
                ),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: 'Zip code',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: SvgPicture.asset(Strings.zipCode),
                  ),
                  keyboardType: TextInputType.number,
                  margin: EdgeInsets.symmetric(horizontal: 17),
                ),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: 'City',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: SvgPicture.asset(Strings.city),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 17),
                ),
                // SizedBox(height: 20,),
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
                        icon: SvgPicture.asset(!isToggle ? Strings.toggleOutline : Strings.toggleFill),
                      ),
                      SizedBox(width: 1),
                      const Text('Save this card'),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  child: PrimaryButton(onPressed: () {
                    Navigator.pop(context);
                  }, title: 'Add address'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
