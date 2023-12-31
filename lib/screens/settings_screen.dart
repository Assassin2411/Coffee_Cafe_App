import 'package:coffee_cafe_app/constants/styling.dart';
import 'package:coffee_cafe_app/screens/welcome_screen.dart';
import 'package:coffee_cafe_app/widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../providers/theme_notifier.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  DateTime timeBackPressed = DateTime.now();
  bool isDark = false;
  bool isShowSpinner = false;

  void _signOut() async {
    final difference = DateTime.now().difference(timeBackPressed);
    final isExitWarning = difference >= const Duration(seconds: 2);
    timeBackPressed = DateTime.now();
    if (isExitWarning) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              height: 90,
              decoration: const BoxDecoration(
                  color: Colors.lightGreenAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Row(
                children: [
                  const SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Do you really want to Leave me 😢",
                          style: kWelcomeScreenTextStyle.copyWith(
                              fontSize: 16, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          "Press again to leave... Byy 😊",
                          style: kWelcomeScreenTextStyle.copyWith(
                              fontSize: 14, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(20.0)),
                child: SvgPicture.asset(
                  'assets/images/bubbles.svg',
                  height: 48,
                  width: 40,
                  color: greenColor,
                ),
              ),
            ),
            Positioned(
              top: -20.0,
              left: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/fail.svg',
                    height: 40,
                  ),
                  Positioned(
                    top: 10.0,
                    child: SvgPicture.asset(
                      'assets/images/close.svg',
                      height: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    } else {
      setState(() {
        isShowSpinner = true;
      });
      try {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const WelcomeScreen(),
          ),
        );
      } on FirebaseAuthException {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                height: 90,
                decoration: const BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 48,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Some Error Occurred!",
                            style: kWelcomeScreenTextStyle.copyWith(
                                fontSize: 16, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Text(
                            "Failed to signOut",
                            style: kWelcomeScreenTextStyle.copyWith(
                                fontSize: 14, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20.0)),
                  child: SvgPicture.asset(
                    'assets/images/bubbles.svg',
                    height: 48,
                    width: 40,
                    color: greenColor,
                  ),
                ),
              ),
              Positioned(
                top: -20.0,
                left: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/fail.svg',
                      height: 40,
                    ),
                    Positioned(
                      top: 10.0,
                      child: SvgPicture.asset(
                        'assets/images/close.svg',
                        height: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      }
    }
    setState(() {
      isShowSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        rightIconData: Icons.person_2_outlined,
        rightIconFunction: () {},
        leftIconFunction: () {
          Navigator.of(context).pop();
        },
        leftIconData: Icons.arrow_back_ios_new,
      ),
      body: ModalProgressHUD(
        inAsyncCall: isShowSpinner,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.menu,
                color: iconColor,
              ),
              title: const Text(
                'General',
                style: kNavBarTextStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.language_outlined,
                color: iconColor,
              ),
              title: const Text(
                'Languages',
                style: kNavBarTextStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
              ),
              onTap: () {},
            ),
            SwitchListTile(
              activeColor: greenColor,
              inactiveThumbColor: brownColor,
              secondary: isDark
                  ? const Icon(
                      Icons.dark_mode,
                      color: iconColor,
                    )
                  : const Icon(
                      Icons.light_mode,
                      color: iconColor,
                    ),
              title: const Text(
                'Appearance',
                style: kNavBarTextStyle
              ),
              value: themeNotifier.getTheme() == darkTheme,
              onChanged: (bool value) {
                themeNotifier.setTheme(value ? darkTheme : lightTheme);
                setState(() {
                  isDark = !isDark;
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.password_outlined,
                color: iconColor,
              ),
              title: const Text(
                'Change Password',
                style: kNavBarTextStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: iconColor,
              ),
              title: const Text(
                'Sign Out',
                style: kNavBarTextStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: iconColor,
              ),
              onTap: _signOut,
            ),
          ],
        ),
      ),
    );
  }
}
