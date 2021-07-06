import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_auth_app_with_bloc/utils/components/text_form_field/text_form_field.dart';
import 'package:weather_auth_app_with_bloc/utils/extensions/context_extension.dart';
import 'package:weather_auth_app_with_bloc/viewmodel/register_viewmodel/register_viewmodel.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildScaffold(context);
  }

  Scaffold buildScaffold(BuildContext context) {
    RegisterController _registerController = Get.put(RegisterController());
    return Scaffold(
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
            return buildForm();
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

  Form buildForm() {
    RegisterController _registerController = Get.find();

    return Form(
      key: _registerController.formKey,
      autovalidateMode: autoValidateMode(),
      child: Column(
        children: [
          EntranceTextFormField(
              hintText: "Name",
              controller: _registerController.nameController,
              validator: _registerController.nameValidator),
          EntranceTextFormField(
              hintText: "Email",
              controller: _registerController.emailController,
              validator: _registerController.emailValidator,
              textInputType: TextInputType.emailAddress),
          EntranceTextFormField(
              hintText: "Password",
              controller: _registerController.passwordController,
              validator: _registerController.passwordValidator,
              obscureText: true),
        ],
      ),
    );
  }

  AutovalidateMode autoValidateMode() {
    RegisterController _registerController = Get.find();

    return _registerController.isLoginFail == true
        ? AutovalidateMode.always
        : AutovalidateMode.disabled;
  }

  void _register() {
    RegisterController _registerController = Get.find();

    _registerController.createUser();
  }
}
