///
/// This is the payment screen
///

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

class PaymentScreen extends StatelessWidget {
  // Initialize a logger for this class
  final Logger logger = Logger('PaymentScreen');

  // The payment object
  final Map<String, dynamic> _paymentObject = const {
    "sandbox": true, // true if using Sandbox Merchant ID
    "merchant_id": "1222623",
    "merchant_secret":
        "MTU3ODI1NTEwNTMwMjE5NTM0NzAxODE0NTY1MDAxMjg2NzIzMDIxNg==", // See step 4e
    "notify_url": "http://sample.com/notify",
    "order_id": "ItemNo12345",
    "items": "Hello from Flutter!",
    "amount": 50.00,
    "currency": "LKR",
    "first_name": "Saman",
    "last_name": "Perera",
    "email": "samanp@gmail.com",
    "phone": "0771234567",
    "address": "No.1, Galle Road",
    "city": "Colombo",
    "country": "Sri Lanka",
    "delivery_address": "No. 46, Galle road, Kalutara South",
    "delivery_city": "Kalutara",
    "delivery_country": "Sri Lanka",
    "custom_1": "",
    "custom_2": ""
  };

  PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: ElevatedButton(
          onPressed: makePayment,
          child: const Text('PAY'),
        ));
  }

  // Method to initiate a one-time payment
  void makePayment() {
    PayHere.startPayment(_paymentObject, (paymentId) {
      logger.info('One Time Payment Success. Payment Id: $paymentId');
    }, (error) {
      logger.severe('One Time Payment Failed. Error: $error');
    }, () {
      logger.info('One Time Payment Dismissed');
    });
  }
}
