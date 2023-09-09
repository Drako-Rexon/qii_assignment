import 'package:flutter/material.dart';
import 'package:qii_assignment/src/auth/login_page.dart';
import 'package:qii_assignment/src/auth/registration.dart';
import 'package:qii_assignment/utils/colors.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: greyColor,
        appBar: AppBar(
          elevation: 0,
          title: const Text('SocialX'),
          backgroundColor: redColor,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: redColor, width: 2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: TabBar(
                unselectedLabelColor: greyColor,
                dividerColor: redColor,
                indicator: const BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                overlayColor: MaterialStateProperty.all(redColor),
                tabs: const [
                  Tab(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(letterSpacing: 1.2),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(letterSpacing: 1.2),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Loginpage(),
                  Registrationpage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
