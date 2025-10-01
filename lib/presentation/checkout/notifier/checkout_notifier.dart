import 'package:big_cart/domain/models/checkout_model.dart';
import 'package:big_cart/repository/checkout_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkoutProvider = StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier();
});

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier() : super(CheckoutState.initialize());

  final CheckoutRepository _checkoutRepository = CheckoutRepository();

  bool get isFormValid =>
      state.name.isNotEmpty &&
      state.phone.isNotEmpty &&
      state.email.isNotEmpty &&
      state.addressLine.isNotEmpty &&
      state.postalCode.isNotEmpty &&
      state.city.isNotEmpty;

  setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  setName(String value) {
    state = state.copyWith(name: value);
  }

  setPhone(String value) {
    state = state.copyWith(phone: value);
  }

  setEmail(String value) {
    state = state.copyWith(email: value);
  }

  setAddressLine(String value) {
    state = state.copyWith(addressLine: value);
  }

  setCity(String value) {
    state = state.copyWith(city: value);
  }

  setZipCode(String value) {
    state = state.copyWith(postalCode: value);
  }

  setItems(List<Items> value) {
    state = state.copyWith(items: value);
  }

  setTotalPrice(double value) {
    state = state.copyWith(totalPrice: value);
  }

  clear(){
    state = state.copyWith(
      name: '',
      email: '',
      phone: '',
      addressLine: '',
      postalCode: '',
      city: '',
      totalPrice: 0,
      items: []
    );
  }

  Future<bool> postCheckout(String id, String userId) async {
    setLoading(true);
    List<Items> items = [];
    // final item = Items(id: cartItem.id, title: cartItem.title, subtitle: cartItem.subtitle, quantity: cartItem.quantity, price: cartItem.price);
    // items.add(item);
    final order = OrderModel(
      id: id,
      userId: userId,
      userName: state.name,
      phoneNumber: state.phone,
      email: state.email,
      address: {'addressLine': state.addressLine, 'city': state.city, 'postal code': state.postalCode},
      items: state.items,
      totalPrice: state.totalPrice,
      paymentMethod: 'Cash on delivery',
      createdAt: DateTime.now(),
    );
    try {
      await _checkoutRepository.postCheckout(order);
      clear();
      return true;
    } catch (e) {
      throw Exception(e.toString());
    }finally{
      setLoading(false);
    }
  }
}

class CheckoutState {
  bool isLoading;
  String name;
  String phone;
  String email;
  String addressLine;
  String city;
  String postalCode;
  List<Items> items;
  double totalPrice;

  CheckoutState({
    required this.isLoading,
    required this.name,
    required this.phone,
    required this.email,
    required this.addressLine,
    required this.city,
    required this.postalCode,
    required this.items,
    required this.totalPrice,
  });

  CheckoutState copyWith({
    bool? isLoading,
    String? name,
    String? phone,
    String? email,
    String? addressLine,
    String? city,
    String? postalCode,
    List<Items>? items,
    double? totalPrice,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      addressLine: addressLine ?? this.addressLine,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory CheckoutState.initialize() {
    return CheckoutState(
      isLoading: false,
      name: '',
      phone: '',
      email: '',
      addressLine: '',
      city: '',
      postalCode: '',
      items: [],
      totalPrice: 0,
    );
  }
}
