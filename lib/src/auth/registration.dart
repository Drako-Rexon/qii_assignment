import 'package:flutter/material.dart';
import 'package:qii_assignment/helper/api_calls.dart';
import 'package:qii_assignment/helper/auth_service.dart';
import 'package:qii_assignment/helper/helper_function.dart';
import 'package:qii_assignment/src/homepage/homepage.dart';
import 'package:qii_assignment/utils/colors.dart';
import 'package:qii_assignment/utils/images.dart';

class Registrationpage extends StatefulWidget {
  const Registrationpage({super.key});

  @override
  State<Registrationpage> createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {
  bool _showPass = false;
  bool _checkValue = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();

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
        _pwdController.text.length >= 6 &&
        _nameController.text.isNotEmpty &&
        _phoneNumberController.text.length == 10 &&
        _checkValue;
  }

  register() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      AuthService()
          .registerUserWithEmailandPassword(
              _nameController.text, _emailController.text, _pwdController.text)
          .then((value) {
        if (value == true) {
          showSnackbar(context, Colors.green, 'Now go to login page and login');
          setState(() {
            _isLoading = false;
          });
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
                          'Create an\nAccount',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: redColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        TextFormField(
                          cursorColor: blackColor,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.person),
                            suffixIconColor: redColor,
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: blackColor)),
                            hintText: 'John Doe',
                            hintStyle:
                                TextStyle(color: greyColor, fontSize: 16),
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
                            hintText: 'johndoe@gmail.com',
                            hintStyle:
                                TextStyle(color: greyColor, fontSize: 16),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Contact no',
                              style: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                DropdownButton(
                                    underline: const SizedBox(),
                                    items: [
                                      DropdownMenuItem(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                                height: 20,
                                                child: Image.asset(india)),
                                            const SizedBox(width: 10),
                                            const Text('IN +91'),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ],
                                    onChanged: (vale) {}),
                                Flexible(
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    cursorColor: blackColor,
                                    controller: _phoneNumberController,
                                    decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.call),
                                      suffixIconColor: redColor,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: blackColor)),
                                      hintText: '9876543210',
                                      hintStyle: TextStyle(
                                          color: greyColor, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextFormField(
                          obscureText: !_showPass,
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
                                        icon: const Icon(Icons.visibility_off),
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
                            hintText: 'Password',
                            hintStyle:
                                const TextStyle(color: greyColor, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                                fillColor: MaterialStateProperty.all(redColor),
                                value: _checkValue,
                                onChanged: (val) {
                                  setState(() {
                                    _checkValue = val!;
                                  });
                                }),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'I agree with ',
                                    style: TextStyle(color: blackColor),
                                  ),
                                  TextSpan(
                                    text: 'term & condition',
                                    style: TextStyle(
                                      color: redColor,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an Account ? ',
                                style: TextStyle(color: blackColor),
                              ),
                              TextSpan(
                                text: 'Sign In!',
                                style: TextStyle(
                                  color: redColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    isEnable() ? register() : () {};
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
                          : Text(
                              'Register'.toUpperCase(),
                              style: const TextStyle(
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
    );
  }
}
