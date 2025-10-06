import 'dart:io';
import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/strings.dart';
import 'package:big_cart/presentation/about/about_me_view.dart';
import 'package:big_cart/presentation/address/add_address_view.dart';
import 'package:big_cart/presentation/cart/notifier/cart_notifier.dart';
import 'package:big_cart/presentation/credit_cards/credit_cards_view.dart';
import 'package:big_cart/presentation/login/login_view.dart';
import 'package:big_cart/presentation/notification/notification_view.dart';
import 'package:big_cart/presentation/order/my_orders_view.dart';
import 'package:big_cart/presentation/profile/notifier/profile_notifier.dart';
import 'package:big_cart/presentation/profile/widgets/image_container.dart';
import 'package:big_cart/presentation/transaction/transaction_view.dart';
import 'package:big_cart/utilities/local_storage.dart';
import 'package:big_cart/widgets/custom_button.dart';
import 'package:big_cart/widgets/custom_dialog.dart';
import 'package:big_cart/widgets/custom_image_picker.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends ConsumerStatefulWidget {
  static const String id = '/profile_view';

  const ProfileView({super.key});

  static const double _headerHeight = 145;
  static const double _avatarRadius = 55;

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();

  static Widget _menuTile({
    required String icon,
    required String title,
    VoidCallback? onPressed,
    bool isTrailing = true,
  }) {
    return ListTile(
      leading: SvgPicture.asset(icon, color: Colors.green),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: isTrailing ? SvgPicture.asset(Strings.arrowForwardIos) : null,
      onTap: onPressed,
      contentPadding: const EdgeInsets.symmetric(horizontal: 36),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  File? _selectedImage;
  final ImageStorage _imageStorage = ImageStorage();

  @override
  void initState() {
    Future.microtask(() async {
      final state = await ref.refresh(profileProvider.future);
      state.email;
      state.name;
    });
    _loadStoredImage();
    super.initState();
  }

  Future<void> _loadStoredImage() async {
    final storedImage = await _imageStorage.loadImage();
    setState(() {
      _selectedImage = storedImage;
    });
  }

  Future<void> _pickFromGallery() async {
    final pickedImage = await CustomImagePicker.pickSingleImage(ImageSource.gallery);
    if (pickedImage != null) {
      await _imageStorage.saveImage(pickedImage);
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  Future<void> _pickFromCamera() async {
    final pickedImage = await CustomImagePicker.pickSingleImage(ImageSource.camera);
    if (pickedImage != null) {
      await _imageStorage.saveImage(pickedImage);
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final signOutNotifier = ref.read(userProvider.notifier);
    final state = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.white2,
      body: state.when(
        data: (value) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: ProfileView._headerHeight,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    const SizedBox(height: ProfileView._avatarRadius + 5),

                    Text(value.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 1),
                    Text(value.email, style: TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 29),

                    ProfileView._menuTile(
                      icon: Strings.profile,
                      title: "About us",
                      onPressed: () {
                        Navigator.pushNamed(context, AboutMeView.id);
                      },
                    ),
                    ProfileView._menuTile(
                      icon: Strings.order,
                      title: "My Orders",
                      onPressed: () {
                        Navigator.pushNamed(context, MyOrdersView.id);
                      },
                    ),
                    ProfileView._menuTile(
                      icon: Strings.address,
                      title: "My Address",
                      onPressed: () {
                        Navigator.pushNamed(context, AddAddressView.id);
                      },
                    ),
                    ProfileView._menuTile(
                      icon: Strings.creditCard,
                      title: "Credit Cards",
                      onPressed: () {
                        Navigator.pushNamed(context, CreditCardView.id);
                      },
                    ),
                    ProfileView._menuTile(
                      icon: Strings.transactions,
                      title: "Transactions",
                      onPressed: () {
                        Navigator.pushNamed(context, TransactionView.id);
                      },
                    ),
                    ProfileView._menuTile(
                      icon: Strings.notification,
                      title: "Notifications",
                      onPressed: () {
                        Navigator.pushNamed(context, NotificationView.id);
                      },
                    ),
                    ProfileView._menuTile(
                      icon: Strings.signOut,
                      title: "Sign out",
                      isTrailing: false,
                      onPressed: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return CustomDialog(
                              title: 'Are you sure?',
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      onPressed: () async {
                                        await ref.read(cartProvider.notifier).clear();
                                        bool isLogout = await signOutNotifier.signOut();
                                        if (isLogout) {
                                          Navigator.pushNamedAndRemoveUntil(context, LoginView.id, (Route<dynamic> route)=> false);
                                          CustomSnackBar.successSnackBar(
                                            context: context,
                                            title: 'Success',
                                            message: 'SignOut Successfully',
                                          );
                                        }
                                      },
                                      title: 'Yes',
                                      height: 50,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: PrimaryButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      title: 'No',
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Positioned(
                top: ProfileView._headerHeight - ProfileView._avatarRadius,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: ProfileView._avatarRadius,
                        backgroundColor: AppColors.grey,
                        backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                        child: _selectedImage == null
                            ? Icon(Icons.person, size: 50, color: AppColors.grey3) // default icon if no image
                            : null,
                      ),
                      Positioned(
                        bottom: -2,
                        right: -2,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  title: 'Pick Image From',
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageContainer(
                                        icon: Icons.camera_alt_outlined,
                                        onTap: () {
                                          _pickFromCamera();
                                          Navigator.pop(context);
                                        },
                                        title: 'Camera',
                                      ),
                                      SizedBox(width: 15),
                                      ImageContainer(
                                        icon: Icons.photo,
                                        onTap: () {
                                          _pickFromGallery();
                                          Navigator.pop(context);
                                        },
                                        title: 'Gallery',
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ),
    );
  }
}
