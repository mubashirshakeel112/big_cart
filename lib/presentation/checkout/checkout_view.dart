import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/domain/models/checkout_model.dart';
import 'package:big_cart/presentation/cart/notifier/cart_notifier.dart';
import 'package:big_cart/presentation/checkout/notifier/checkout_notifier.dart';
import 'package:big_cart/presentation/congrats/congrats_view.dart';
import 'package:big_cart/presentation/home/home_view.dart';
import 'package:big_cart/presentation/profile/notifier/profile_notifier.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:big_cart/widgets/custom_loader.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:big_cart/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutView extends ConsumerStatefulWidget {
  static const String id = '/checkout_view';

  const CheckoutView({super.key});

  @override
  ConsumerState<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends ConsumerState<CheckoutView> {
  String orderId = DateTime.now().microsecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      final profile = ref.read(profileProvider).value;
      final checkoutNotifier = ref.read(checkoutProvider.notifier);

      if (profile != null) {
        checkoutNotifier.setName(profile.name);
        checkoutNotifier.setEmail(profile.email);
        checkoutNotifier.setPhone(profile.phone);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final checkoutState = ref.watch(checkoutProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final checkoutNotifier = ref.read(checkoutProvider.notifier);
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: PrimaryAppBar(title: 'Checkout', statusBarHeight: MediaQuery.of(context).viewPadding.top),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 17, right: 17,  top: 44),
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Enter Name',
              initialValue: profileState.value?.name ?? '',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 17, right: 15),
                child: SvgPicture.asset(Strings.profile),
              ),
              onChanged: (value) => checkoutNotifier.setName(value),
            ),
            SizedBox(height: 5,),
            CustomTextField(
              hintText: 'Enter Email',
              initialValue: profileState.value?.email ?? '',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 17, right: 15),
                child: SvgPicture.asset(Strings.email),
              ),
              onChanged: (value) => checkoutNotifier.setEmail(value),
            ),
            SizedBox(height: 5,),
            CustomTextField(
              hintText: 'Enter Phone',
              initialValue: profileState.value?.phone ?? '',
              keyboardType: TextInputType.phone,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 17, right: 15),
                child: SvgPicture.asset(Strings.telephone),
              ),
              onChanged: (value) => checkoutNotifier.setPhone(value),
            ),
            SizedBox(height: 5,),
            CustomTextField(
              hintText: 'Enter Address',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 17, right: 15),
                child: SvgPicture.asset(Strings.address),
              ),
              onChanged: (value) => checkoutNotifier.setAddressLine(value),
            ),
            SizedBox(height: 5,),
            CustomTextField(
              hintText: 'Enter Zip Code',
              keyboardType: TextInputType.number,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 17, right: 15),
                child: SvgPicture.asset(Strings.zipCode),
              ),
              onChanged: (value) => checkoutNotifier.setZipCode(value),
            ),
            SizedBox(height: 5,),
            CustomTextField(
              hintText: 'Enter City',
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 17, right: 15),
                child: SvgPicture.asset(Strings.city),
              ),
              onChanged: (value) => checkoutNotifier.setCity(value),
            ),
            SizedBox(height: 50),
            checkoutState.isLoading
                ? CustomLoader(title: 'Placed your order...')
                : PrimaryButton(
                    onPressed: () async {
                      if (checkoutNotifier.isFormValid) {
                        bool isOrderConfirmed = await checkoutNotifier.postCheckout(
                          orderId,
                          FirebaseAuth.instance.currentUser?.uid ?? '',
                        );
                        if (isOrderConfirmed) {
                          Navigator.pushReplacementNamed(context, CongratsView.id, arguments: orderId);
                          cartNotifier.clear();
                          CustomSnackBar.successSnackBar(
                            context: context,
                            title: 'Success',
                            message: 'Your Order Successfully Placed 🎉',
                          );
                        }
                      } else {
                        CustomSnackBar.missingInfo(
                          context: context,
                          title: 'Missing Info',
                          message: 'Please all the fields',
                        );
                      }
                    },
                    title: 'Confirm Order',
                  ),
          ],
        ),
      ),
    );
  }
}
