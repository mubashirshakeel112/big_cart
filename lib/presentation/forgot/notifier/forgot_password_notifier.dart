import 'package:big_cart/presentation/login/login_view.dart';
import 'package:big_cart/repository/forgot_password_repository.dart';
import 'package:big_cart/widgets/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordProvider = StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref)=> ForgotPasswordNotifier());

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState>{
  ForgotPasswordNotifier() : super(ForgotPasswordState.initialize());

  final ForgotPasswordRepository _forgotPasswordRepository = ForgotPasswordRepository();

  setLoading(bool value){
    state = state.copyWith(isLoading: value);
  }

  setEmail(String value){
    state = state.copyWith(email: value);
  }

  Future<void> forgotPassword(BuildContext context) async{
    try{
      setLoading(true);
      bool isPasswordForgot = await _forgotPasswordRepository.forgotPassword(state.email);
      if(isPasswordForgot){
       if(context.mounted){
         CustomSnackBar.successSnackBar(context: context, title: 'Success', message: 'Check your email');
         Navigator.pushNamed(context, LoginView.id);
       }
      }else{
        CustomSnackBar.errorSnackBar(context: context, title: 'Error', message: 'Forgot Password Failed');
      }
    }catch(e){
      CustomSnackBar.errorSnackBar(context: context, title: 'Error', message: e.toString());
    }finally{
      setLoading(false);
    }
  }

}

class ForgotPasswordState{
  bool isLoading;
  String email;

  ForgotPasswordState({required this.email, required this.isLoading});

  ForgotPasswordState copyWith({bool? isLoading, String? email}){
    return ForgotPasswordState(email: email ?? this.email, isLoading: isLoading ?? this.isLoading);
  }

  factory ForgotPasswordState.initialize(){
    return ForgotPasswordState(email: '', isLoading: false);
  }
}