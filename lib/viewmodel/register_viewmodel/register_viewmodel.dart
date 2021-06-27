import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/user.dart';
import 'package:weather_auth_app_with_bloc/repository/user_repository.dart';
import 'package:weather_auth_app_with_bloc/utils/locator/locator.dart';
import 'package:weather_auth_app_with_bloc/view/pages/initial_page.dart';

class RegisterController extends GetxController {
  UserRepository _userRepository = getIt<UserRepository>();

  /// geçiçi olarak user kontrolleri burada kullanıyorum sonra onu streeam kullanarak düzelticem

  @override
  void onInit() {
    super.onInit();

    /// passwordController.text = "123123123";
    /// emailController.text = "furkanacar911@gmail.com";
    /// nameController.text = "furkan";
  }

  Rx<bool> _isLoginFail = false.obs;

  Rx<TextEditingController> _emailController = TextEditingController().obs;
  Rx<TextEditingController> _passwordController = TextEditingController().obs;
  Rx<TextEditingController> _nameController = TextEditingController().obs;
  Rx<GlobalKey<FormState>> _formKey = GlobalKey<FormState>().obs;

  Rx<FormFieldValidator<String>?> _emailValidator = ((value) {
    var result = GetUtils.isEmail((value ?? ''));
    return result == true ? null : 'Geçersiz email adresi';
  }).obs;

  /// BUNU HEM LOGIN HEMDE REGISTER DE KULKLANUIYORSUN SABİT OLARAK DIŞARI ÇIKAR
  final Rx<FormFieldValidator<String?>?> _passwordValidator = ((value) =>
      (value ?? '').length > 6
          ? null
          : 'password 6 karakterden daha uzun olmalıdır.').obs;

  final Rx<FormFieldValidator<String?>?> _nameValidator = ((value) =>
      (value ?? '').length > 2
          ? null
          : 'isim 2 karakterden daha uzun olmalıdır.').obs;

  bool get isLoginFail => _isLoginFail.value;

  set isLoginFail(bool value) {
    _isLoginFail.value = value;
  }

  Future<MyUser> createUser() async {
    if (formKey.currentState != null && !formKey.currentState!.validate()) {
      isLoginFail = true;
      print("aaaa");
    } else {
      isLoginFail = false;
      String tempEmail = emailController.text.trim();
      String tempPassword = passwordController.text.trim();

      try {
        MyUser? myUser = await _userRepository.createUserWithEmailAndPassword(
            tempEmail, tempPassword);
        print("Emait from create user dan " + myUser!.email!);
        print("bbb");
        Get.offAll(Root());
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "email-already-in-use":
            Get.snackbar("Kayıt hata", "Email zaten kullanımda.");
        }
      } catch (e) {
        print("HATAAAAAAAAAAAAAAAAA0");
      }
    }

    return MyUser();
  }

  GlobalKey<FormState> get formKey => _formKey.value;

  set formKey(GlobalKey<FormState> value) {
    _formKey.value = value;
  }

  TextEditingController get emailController => _emailController.value;

  set emailController(TextEditingController value) {
    _emailController.value = value;
  }

  TextEditingController get passwordController => _passwordController.value;

  set passwordController(TextEditingController value) {
    _passwordController.value = value;
  }

  TextEditingController get nameController => _nameController.value;

  set nameController(TextEditingController value) {
    _nameController.value = value;
  }

  FormFieldValidator<String> get passwordValidator => _passwordValidator.value!;

  set passwordValidator(FormFieldValidator<String> value) {
    _passwordValidator.value = value;
  }

  FormFieldValidator<String> get emailValidator => _emailValidator.value!;

  set emailValidator(FormFieldValidator<String> value) {
    _emailValidator.value = value;
  }

  FormFieldValidator<String> get nameValidator => _nameValidator.value!;

  set nameValidator(FormFieldValidator<String> value) {
    _nameValidator.value = value;
  }
}
