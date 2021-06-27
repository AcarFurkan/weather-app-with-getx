import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/user.dart';
import 'package:weather_auth_app_with_bloc/repository/user_repository.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';

class LoginController extends GetxController {
  UserRepository _userRepository = getIt<UserRepository>();

  @override
  void onInit() {
    super.onInit();
    // emailController.text = "furkanacar911@gmail.com";
    // passwordController.text = "123123123";
  }

  @override
  void onClose() {
    super.onClose();
  }

  Rx<bool> _isLoginFail = false.obs;

  Rx<TextEditingController> _emailController = TextEditingController().obs;

  Rx<TextEditingController> _passwordController = TextEditingController().obs;

  //late Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;

  Rx<FormFieldValidator<String>?> _emailValidator = ((value) {
    var result = GetUtils.isEmail((value ?? ''));
    return result == true ? null : 'Geçersiz email adresi';
  }).obs;

  /// BUNU HEM LOGIN HEMDE REGISTER DE KULKLANUIYORSUN SABİT OLARAK DIŞARI ÇIKAR
  Rx<FormFieldValidator<String?>?> _passwordValidator = ((value) =>
      (value ?? '').length > 6
          ? null
          : '6 karakterden daha uzun olmalıdır.').obs;

  bool get isLoginFail => _isLoginFail.value;

  set isLoginFail(bool value) {
    _isLoginFail.value = value;
  }

  FormFieldValidator<String> get emailValidator => _emailValidator.value!;

  set emailValidator(FormFieldValidator<String> value) {
    _emailValidator.value = value;
  }

  FormFieldValidator<String> get passwordValidator => _passwordValidator.value!;

  set passwordValidator(FormFieldValidator<String> value) {
    _passwordValidator.value = value;
  }

  TextEditingController get emailController => _emailController.value;

  set emailController(TextEditingController value) {
    _emailController.value = value;
  }

  Future<MyUser> loginUser(GlobalKey<FormState> formKey) async {
    if (formKey.currentState != null && !formKey.currentState!.validate()) {
      print("aaaa");
      isLoginFail = true;
    } else {
      isLoginFail = false;
      String tempEmail = emailController.text.trim();
      String tempPassword = passwordController.text.trim();

      try {
        MyUser? myUser = await _userRepository.signInWithEmailAndPassword(
            tempEmail, tempPassword);
        print(myUser == null ? " null user" : myUser.email);

        print("bbb");
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "user-not-found":
            Get.snackbar("Giriş hata ", "Kayıtlı kullanıcı bulunamadı.");
        }
      }
    }
    return MyUser();
  }

  TextEditingController get passwordController => _passwordController.value;

  set passwordController(TextEditingController value) {
    _passwordController.value = value;
  }
/*
  GlobalKey<FormState> get formKey => _formKey.value;

  set formKey(GlobalKey<FormState> value) {
    _formKey.value = value;
  }*/
}
