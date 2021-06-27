import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/utils/extentions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/register_viewmodel/register_viewmodel.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  bool loginCheck = true;

  /// if loginCheck is true then  login page is displayed otherwise register page is displayed

  @override
  Widget build(BuildContext context) {
    //final myAuth = Provider.of<UserAuthViewModel>(context, listen: true);
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    RegisterController _registerController = Get.put(RegisterController());

    return Scaffold(
      ///resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: context.mediumValueHeight,
          ),
          SizedBox(
              height: context.ultraHighValueHeight,
              width: context.ultraHighValueWidth,
              child: Image.asset("assets/weather_logo.png")),
          Obx(() {
            return Form(
              key: _registerController.formKey,
              autovalidateMode:
                  autoValidateMode(_registerController.isLoginFail),
              child: Column(
                children: [
                  buildTextForm(
                      hintText: "Name",
                      controller: _registerController.nameController,
                      validator: _registerController.nameValidator),
                  buildTextForm(
                      hintText: "Email",
                      controller: _registerController.emailController,
                      validator: _registerController.emailValidator,
                      textInputType: TextInputType.emailAddress),
                  buildTextForm(
                      hintText: "Password",
                      controller: _registerController.passwordController,
                      validator: _registerController.passwordValidator,
                      obscureText: true),
                ],
              ),
            );
          }),
          SizedBox(
            height: context.lowValueHeight,
          ),
          Padding(
            padding: context.paddingHighHorizontal,
            child: OutlinedButton(
                onPressed: _register, child: const Text("Register")),
          ),
          const Align(
              alignment: Alignment.center,
              child: Text("Do you have a account?")),
          TextButton(
              onPressed: () {
                //Get.off(const LoginPage());
                Get.back();
                // final myAuth =Provider.of<UserAuthViewModel>(context, listen: false);
                //context.watch<UserAuthViewModel>();
                /// BURADA NEDEN LİSTEN TRUE VE WATCH ÇALIŞMIYOR SAEBEİNİ ÖĞREN CANIM BENİM
                //myAuth.userState = UserState.loginPage;
                //Navigator.of(context)
                // .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text("Login")),
        ],
      ),
    );
  }

  AutovalidateMode autoValidateMode(bool isLoadingFail) {
    return isLoadingFail == true
        ? AutovalidateMode.always
        : AutovalidateMode.disabled;
  }

  Padding buildTextForm(
      {required String hintText,
      required TextEditingController controller,
      FormFieldValidator<String>? validator,
      TextInputType? textInputType,
      bool? obscureText}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText ?? false,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: hintText,
            border: const OutlineInputBorder()),
      ),
    );
  }

  void _register() {
    RegisterController _registerController = Get.find();

    _registerController.createUser();
  }
}
