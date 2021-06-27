import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/utils/extentions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/login_viewmodel/login_viewmodel.dart';

import 'register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// FORM KEY İ NİN VERDİĞİ HATA BELLİ ONU ÇÖZ ASLANIM NİYE ONU ORDAN ALAMIYORUZ.
  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.put(LoginController());
    //final myAuth = Provider.of<UserAuthViewModel>(context, listen: true);

    return buildLoginPage(context);
  }

  Widget buildLoginPage(BuildContext context) {
    LoginController _loginController = Get.find();
    //AuthController _authController = Get.put(AuthController());
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login Page"),
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
          SizedBox(
            height: context.lowValueHeight,
          ),
          buildForm(_loginController),
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
                // final myAuth =
                //Provider.of<UserAuthViewModel>(context, listen: false);
                //context.watch<UserAuthViewModel>();
                /// BURADA NEDEN LİSTEN TRUE VE WATCH ÇALIŞMIYOR SAEBEİNİ ÖĞREN CANIM BENİM
                //myAuth.userState = UserState.signInPage;

                // Navigator.of(context).push(
                //  MaterialPageRoute(builder: (context) => RegisterPage()));
                //Navigator.push(context,
                //  MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: const Text("Create Account")),
        ],
      ),
    );
  }

  Widget buildForm(LoginController _loginController) {
    return Obx(() {
      return Form(
          autovalidateMode: autoValidateMode(_loginController.isLoginFail),
          key: _formKey,
          child: Column(
            children: [
              buildTextForm(
                hintText: "Email",
                controller: _loginController.emailController,
                validator: _loginController.emailValidator,
                textInputType: TextInputType.emailAddress,
              ),
              buildTextForm(
                  hintText: "Password",
                  controller: _loginController.passwordController,
                  validator: _loginController.passwordValidator,
                  obscureText: true),
            ],
          ));
    });
  }

  AutovalidateMode autoValidateMode(bool isLoadingFail) {
    return isLoadingFail == true
        ? AutovalidateMode.always
        : AutovalidateMode.disabled;
  }

  Padding buildTextForm({
    required String hintText,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
    TextInputType? textInputType,
    bool? obscureText,
  }) {
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

  void _login(GlobalKey<FormState> formKey) {
    LoginController _loginController = Get.find();
    _loginController.loginUser(formKey);
  }
}
