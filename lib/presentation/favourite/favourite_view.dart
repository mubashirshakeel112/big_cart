import 'package:big_cart/constants/app_colors.dart';
import 'package:big_cart/constants/typography.dart';
import 'package:big_cart/presentation/cart/widgets/cart_loader.dart';
import 'package:big_cart/presentation/favourite/notifier/favourite_notifier.dart';
import 'package:big_cart/presentation/product_detail/product_detail_view.dart';
import 'package:big_cart/widgets/custom_app_bar.dart';
import 'package:big_cart/widgets/custom_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteView extends ConsumerStatefulWidget {
  static const String id = '/favourite_view';

  const FavouriteView({super.key});

  @override
  ConsumerState<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends ConsumerState<FavouriteView> {
  @override
  void initState() {
    Future.microtask(() {
      final notifier = ref.read(favouriteProvider.notifier);
      notifier.getFavourites();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(favouriteProvider);
    final notifier = ref.read(favouriteProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.white2,
      appBar: PrimaryAppBar(
        title: 'Favourites',
        isLeadingIconShow: false,
        statusBarHeight: MediaQuery.of(context).viewPadding.top,
      ),
      body: state.favourites.isEmpty
          ? Center(
              child: Text('No favourites yet!', style: interSemiBold.copyWith(fontSize: 20, color: AppColors.black)),
            )
          : Column(
              children: [
                Expanded(
                  child: state.isLoading
                      ? CartLoader()
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 26),
                          itemCount: state.favourites.length,
                          itemBuilder: (context, index) {
                            final favourites = state.favourites[index];
                            return SecondaryCard(
                              title: favourites.title,
                              subtitle: favourites.subtitle,
                              price: favourites.price,
                              quantity: 1,
                              productBgColor: Color(int.parse(favourites.bgColor.replaceFirst('#', '0xFF'))),
                              image: favourites.image,
                              isTrailing: false,
                              onTap: () {
                                Navigator.pushNamed(context, ProductDetailView.id, arguments: favourites.id);
                              },
                              onDelete: () {
                                notifier.deleteFavourite(favourites.id);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
