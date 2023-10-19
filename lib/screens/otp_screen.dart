import 'package:flutter/material.dart';
import 'package:flutter_app/app_locale.dart';
import 'package:flutter_app/widgets/otp_widget.dart';
import 'package:flutter_localization/flutter_localization.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocale.verifyOTP.getString(context),
              style: const TextStyle(
                color: Color(0xFF1C1C28),
                fontSize: 23,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const OtpWidget(),
          const SizedBox(height: 32),
          Row(
            children: [
              Text('${AppLocale.didntReceiveTheCode.getString(context)}  '),
              GestureDetector(
                onTap: () {
                  // Handle resend action
                },
                child: Text(
                  AppLocale.resend.getString(context),
                  style: const TextStyle(color: Color(0xFF05A560)),
                ),
              ),
            ],
          ),
          (orientation == Orientation.portrait
              ? const SizedBox(height: 500)
              : const SizedBox(height: 70)),
          ElevatedButton(
            onPressed: () {
              // Handle Verify OTP action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF05A560),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              AppLocale.verifyOTP.getString(context),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
