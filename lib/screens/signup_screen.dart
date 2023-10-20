///
/// This is the signup screen widget
///

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/widgets/signup_form_widget.dart';
import 'package:flutter_app/widgets/social_buttons_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(signupScreenColor),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Allow vertical scrolling

        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Color(signupScreenColor)),
              padding: const EdgeInsets.fromLTRB(35, 70, 24, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.signup,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15), // Use SizedBox for spacing
                  Row(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.alreadyHaveAnAccount}  ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.login,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Additional widgets added after the green color area
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 26, 24, 28),
                  child: SignupFormWidget(),
                ),
                Row(children: [
                  const Padding(padding: EdgeInsets.fromLTRB(35, 0, 0, 0)),
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(
                      AppLocalizations.of(context)!.orLoginUsing,
                      style: const TextStyle(
                        color: Color(0xFF1C1C28),
                        fontSize: 13,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 0, 35, 0)),
                ]),
                const Padding(padding: EdgeInsets.fromLTRB(0, 27, 0, 0)),
                const Center(
                  child: SocialLoginButtons(),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 60))
              ],
            )

            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}
