import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 4,
      borderColor: const Color(0xFFC7C8D8),
      focusedBorderColor: const Color(0xFF39D98A),
      borderRadius: BorderRadius.circular(8),
      fieldWidth: 55,
      //set to true to show as box or false to show as dash
      showFieldAsBox: true,
      onCodeChanged: (String code) {
        // runs when a code is typed in
        //handle validation or checks here
      },
      onSubmit: (String verificationCode) {
        // TODO Do something when every text field is filled
      }, // end onSubmit
    );
  }
}
