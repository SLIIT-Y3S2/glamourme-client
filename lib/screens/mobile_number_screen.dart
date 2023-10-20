import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MobileNumberScreen extends StatelessWidget {
  const MobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        appBar: AppBar(
          leadingWidth: 65,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.enterMobileNumber,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1C1C28),
                    fontSize: 23,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: -0.46,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.phoneNumber,
                          style: const TextStyle(
                            color: Color(0xFF1C1C28),
                            fontSize: 12,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                            height: 0.16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(
                              8, 20, 8, 20), // Adjust the padding as needed
                          prefixIcon: Icon(
                            Icons.phone_android_outlined,
                            size: 40,
                          ),
                          hintText: '(+1) - 414 214124',
                          hintStyle: TextStyle(
                            color: Color(0xFFC7C8D8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        style: TextStyle(
                          color: Color(0xFF1C1C28),
                          fontSize: 15,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  )),
              (orientation == Orientation.portrait
                  ? const Padding(padding: EdgeInsets.fromLTRB(25, 497, 24, 20))
                  : const Padding(
                      padding: EdgeInsets.fromLTRB(25, 80, 24, 20))),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF05A560),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      AppLocalizations.of(context)!.sendOTP,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              )
            ]),
          )
        ]));
  }
}
