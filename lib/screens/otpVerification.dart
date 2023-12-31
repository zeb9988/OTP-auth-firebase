import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pinput/pinput.dart';
import 'package:taxiapp/controller/auth_controller.dart';
import 'package:taxiapp/widget/greenintroWidget.dart';
import 'package:taxiapp/widget/otpWidget.dart';
import 'package:taxiapp/widget/pinput.dart';

class OtpVerification extends StatefulWidget {
  String? Phonenumber;
  OtpVerification({super.key, required this.Phonenumber});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    print(PhoneNumber);
    authController.phoneAuth(widget.Phonenumber!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Stack(
            children: [
              // Text(widget.Phonenumber!),
              greenintroWidget(),
              Positioned(
                top: 60,
                left: 20,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: otpWidget(),
          ),
          PinputExample(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    children: [
                      TextSpan(text: 'Resend Code in '),
                      TextSpan(
                          text: '10 Seconds',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ])),
          )
        ]),
      ),
    );
  }
}
