import 'package:flutter/material.dart';
import 'package:qii_assignment/helper/api_calls.dart';
import 'package:qii_assignment/helper/auth_service.dart';
import 'package:qii_assignment/helper/helper_function.dart';
import 'package:qii_assignment/src/homepage/homepage.dart';
import 'package:qii_assignment/utils/colors.dart';
import 'package:qii_assignment/utils/images.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _pwdController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showPass = false;
  InkWell logo(String str) {
    return InkWell(
      onTap: () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => Homepage()), (route) => false);
      },
      child: Container(
        height: 40,
        width: 40,
        foregroundDecoration: BoxDecoration(
          border: Border.all(
            color: greyColor,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Image.asset(
          str,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  bool isEnable() {
    return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_emailController.text) &&
        _pwdController.text.length >= 6;
  }

  login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      AuthService()
          .loginWithUserNameAndPassword(
              _emailController.text, _pwdController.text)
          .then((value) {
        if (value == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const Homepage()),
              (route) => false);
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Column(
                        children: [
                          const Text(
                            'SignIn into your\nAccount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: redColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          TextFormField(
                            cursorColor: blackColor,
                            controller: _emailController,
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.email),
                              suffixIconColor: redColor,
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blackColor)),
                              hintText: 'temp@gmail.com',
                              hintStyle:
                                  TextStyle(color: greyColor, fontSize: 16),
                            ),
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val!)
                                  ? null
                                  : "Please enter a valid email";
                            },
                          ),
                          TextFormField(
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {});
                            },
                            controller: _pwdController,
                            cursorColor: blackColor,
                            decoration: InputDecoration(
                              suffixIcon: _pwdController.text.isEmpty
                                  ? const Icon(Icons.lock_outline)
                                  : _showPass
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _showPass = !_showPass;
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.visibility_off),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _showPass = !_showPass;
                                            });
                                          },
                                          icon: const Icon(Icons.visibility),
                                        ),
                              suffixIconColor: redColor,
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: blackColor)),
                              hintText: '123456',
                              hintStyle: const TextStyle(
                                  color: greyColor, fontSize: 16),
                            ),
                            validator: (value) {
                              if (value!.length < 6) {
                                return "Password must be at least 6 charcter";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Text(
                                'Forget Password ?',
                                style: TextStyle(
                                  color: redColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text('Login with'),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SizedBox(),
                              logo(google),
                              logo(fb),
                              const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 30),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don\'t have an Account ? ',
                                  style: TextStyle(color: blackColor),
                                ),
                                TextSpan(
                                  text: 'Register Now',
                                  style: TextStyle(
                                    color: redColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      isEnable() ? login() : () {};
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'LOGIN',
                                style: TextStyle(
                                  letterSpacing: 1.2,
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
