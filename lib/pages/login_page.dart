import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minimal_chat_app/components/widgets/widgets.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/components/custom_button.dart';
import 'package:minimal_chat_app/components/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      final authService = AuthService();
      try {
        await authService.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (error) {
        showSnackBar(context, Colors.red, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // welcome back message
          Text(
            "Welcome back, you,ve been missed!",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 26),
          ),

          const SizedBox(
            height: 25,
          ),

          // logo
          Icon(
            Icons.message_outlined,
            size: 60,
          ),
          //SvgPicture.asset('assets/undraw_chatting_re_j55r.svg',),

          const SizedBox(
            height: 25,
          ),

          // textfields
          Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFiled(
                  hintText: "Email",
                  obscureText: false,
                  controller: _emailController,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)
                        ? null
                        : "Enter valid email";
                  },
                ),

                const SizedBox(
                  height: 10,
                ),

                CustomTextFiled(
                  hintText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.lock_outline),
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Password must be at least 6 characters";
                    }

                    return null;
                  },
                ),

                const SizedBox(
                  height: 25,
                ),

                // login button

                CustomButton(
                  text: "Sign in",
                  onTap: () => login(context),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 25,
          ),
          Center(
            child: Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Create account here",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = onTap,
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
