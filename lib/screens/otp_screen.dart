import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/otp_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              AppLocalizations.of(context)!.verifyOTP,
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
              Text('${AppLocalizations.of(context)!.didntReceiveTheCode}  '),
              GestureDetector(
                onTap: () {
                  // Handle resend action
                },
                child: Text(
                  AppLocalizations.of(context)!.resend,
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
              AppLocalizations.of(context)!.verifyOTP,
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
