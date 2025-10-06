import 'package:big_cart/domain/models/users_model.dart';
import 'package:big_cart/presentation/dashboard/dashboard_view.dart';
import 'package:big_cart/presentation/home/home_view.dart';
import 'package:big_cart/repository/signup_repository.dart';
import 'package:big_cart/repository/users_repository.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupProvider = StateNotifierProvider<SignupNotifier, SignupState>((ref) => SignupNotifier());

class SignupNotifier extends StateNotifier<SignupState> {
  SignupNotifier() : super(SignupState.initialize());

  final SignupRepository _signupRepository = SignupRepository();
  final UsersRepository _usersRepository = UsersRepository();

  bool get isFormValid => state.name.isNotEmpty && state.email.isNotEmpty && state.password.isNotEmpty && state.phone.isNotEmpty;

  setName(String value){
    state = state.copyWith(name: value);
  }

  setEmail(String value) {
    state = state.copyWith(email: value);
  }

  setPassword(String value) {
    state = state.copyWith(password: value);
  }

  setPhone(String value) {
    state = state.copyWith(phone: value);
  }

  Future<void> signup(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true);
      bool  isSignup = await _signupRepository.signup(state.email, state.password);
      if (isSignup) {
        if (context.mounted) {
          await setUser();
          CustomSnackBar.successSnackBar(context: context, title: 'Success', message: 'Signup Successfully');
          Navigator.pushNamedAndRemoveUntil(context, HomeView.id, (Route<dynamic> route) => false);
        }
      }else{
        if (context.mounted) {
          CustomSnackBar.errorSnackBar(context: context, title: 'Error', message: 'Signup Failed');
        }
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.errorSnackBar(context: context, title: 'Error', message: e.toString());
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
  Future<void> setUser() async{
    final String id = FirebaseAuth.instance.currentUser?.uid ?? DateTime.now().millisecondsSinceEpoch.toString();
    final user = UsersModel(id: id, name: state.name, email: state.email, phone: state.phone);
    try{
      await _usersRepository.setUser(user);
    }catch(e){
      debugPrint(e.toString());
    }
  }
}

class SignupState {
  bool isLoading;
  String name;
  String email;
  String password;
  String phone;

  SignupState({required this.isLoading,required this.name, required this.email, required this.password, required this.phone});

  SignupState copyWith({bool? isLoading,String? name, String? email, String? password, String? phone}) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }

  factory SignupState.initialize() {
    return SignupState(isLoading: false, name: '', email: '', password: '', phone: '');
  }
}
