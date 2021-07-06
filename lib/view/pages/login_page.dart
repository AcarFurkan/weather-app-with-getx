import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/utils/components/text_form_field/text_form_field.dart';
import 'package:weather_auth_app_with_bloc/utils/extensions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/login_viewmodel/login_viewmodel.dart';

import 'register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// FORM KEY İ NİN VERDİĞİ HATA BELLİ ONU ÇÖZ ASLANIM NİYE ONU ORDAN ALAMIYORUZ.
  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.put(LoginController());

    return buildLoginPage(context);
  }

  Widget buildLoginPage(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: context.mediumValueHeight,
        ),
        SizedBox(
            height: context.ultraHighValueHeight,
            width: context.ultraHighValueWidth,
            child: Image.asset("assets/weather_logo.png")),
        SizedBox(
          height: context.lowValueHeight,
        ),
        buildForm(),
        SizedBox(
          height: context.lowValueHeight,
        ),
        Padding(
          padding: context.paddingHighHorizontal,
          child: OutlinedButton(
              onPressed: () {
                _login(_formKey);
              },
              child: const Text("Login")),
        ),
        const Align(alignment: Alignment.center, child: Text("New to App?")),
        SizedBox(
          height: context.lowValueHeight,
        ),
        TextButton(
            onPressed: () {
              Get.to(RegisterPage());

              /// BURADA NEDEN LİSTEN TRUE VE WATCH ÇALIŞMIYOR SAEBEİNİ ÖĞREN CANIM BENİM
            },
            child: const Text("Create Account")),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Login Page"),
    );
  }

  Widget buildForm() {
    LoginController _loginController = Get.find();
    return Obx(() {
      return Form(
          autovalidateMode: autoValidateMode(),
          key: _formKey,
          child: Column(
            children: [
              EntranceTextFormField(
                hintText: "Email",
                controller: _loginController.emailController,
                validator: _loginController.emailValidator,
                textInputType: TextInputType.emailAddress,
              ),
              EntranceTextFormField(
                  hintText: "Password",
                  controller: _loginController.passwordController,
                  validator: _loginController.passwordValidator,
                  obscureText: true),
            ],
          ));
    });
  }

  AutovalidateMode autoValidateMode() {
    LoginController _loginController = Get.find();

    return _loginController.isLoginFail == true
        ? AutovalidateMode.always
        : AutovalidateMode.disabled;
  }

  void _login(GlobalKey<FormState> formKey) {
    LoginController _loginController = Get.find();
    _loginController.loginUser(formKey);
  }
}
