import 'package:big_cart/presentation/dashboard/dashboard_view.dart';
import 'package:big_cart/presentation/home/home_view.dart';
import 'package:big_cart/repository/login_repository.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref)=> LoginNotifier());

class LoginNotifier extends StateNotifier<LoginState>{
  final LoginRepository _loginRepository = LoginRepository();
  LoginNotifier() : super(LoginState.initial());

  bool get isFormValid => state.email.isNotEmpty && state.password.isNotEmpty;

  setEmail(String value){
    state = state.copyWith(email: value);
  }

  setPassword(String value){
    state = state.copyWith(password: value);
  }

  Future<void> login(BuildContext context) async{
    try{
      state = state.copyWith(isLoading: true);
      bool isLogin = await _loginRepository.login(state.email, state.password);
      if(isLogin){
        if(context.mounted){
          CustomSnackBar.successSnackBar(context: context, title: 'Success', message: 'LoginSuccessfully');
          Navigator.pushReplacementNamed(context, HomeView.id);
        }
      }else{
        CustomSnackBar.errorSnackBar(context: context, title: 'Error', message: 'Login Failed');
      }
    }catch(e){
      CustomSnackBar.errorSnackBar(context: context, title: 'Error', message: e.toString());
    }finally{
      state = state.copyWith(isLoading: false);
    }
  }
}

class LoginState{
  bool isLoading;
  String email;
  String password;

  LoginState({required this.email, required this.password, required this.isLoading});

  LoginState copyWith({String? email, String? password, bool? isLoading}){
    return LoginState(email: email ?? this.email, password: password ?? this.password, isLoading: isLoading ?? this.isLoading);
  }

  factory LoginState.initial() {
    return LoginState(email: '', password: '', isLoading: false);
  }
}
