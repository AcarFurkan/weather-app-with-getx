import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/model/user.dart';

import '../auth_viewmodel.dart';

class RegisterController extends GetxController {
  UserAuthViewModel _userAuthViewModel = Get.find();

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

  /// BUNU HEM LOGIN HEMDE REGISTER DE KULKLANUIYORSUN SABİT OLARAK DIŞARI ÇIKAR
  final Rx<FormFieldValidator<String?>?> _passwordValidator = ((value) =>
      (value ?? '').length > 6
          ? null
          : 'password 6 karakterden daha uzun olmalıdır.').obs;

  final Rx<FormFieldValidator<String?>?> _nameValidator = ((value) =>
      (value ?? '').length > 2
          ? null
          : 'isim 2 karakterden daha uzun olmalıdır.').obs;

  final Rx<FormFieldValidator<String>?> _emailValidator = ((value) {
    var result = GetUtils.isEmail((value ?? ''));
    return result == true ? null : 'Geçersiz email adresi';
  }).obs;

  Future<MyUser?> createUser() async {
    MyUser? _myUser;
    if (formKey.currentState != null && !formKey.currentState!.validate()) {
      isLoginFail = true;
      print("aaaa");
    } else {
      isLoginFail = false;
      String tempEmail = emailController.text.trim();
      String tempPassword = passwordController.text.trim();

      _myUser = await _userAuthViewModel.createUserWithEmailandPassword(
          tempEmail, tempPassword);

      //MyUser? myUser = await _userRepository.createUserWithEmailAndPassword(tempEmail, tempPassword);

    }

    return _myUser;
  }

  bool get isLoginFail => _isLoginFail.value;

  set isLoginFail(bool value) {
    _isLoginFail.value = value;
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
