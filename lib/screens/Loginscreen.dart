import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:taxiapp/screens/otpVerification.dart';
import 'package:taxiapp/widget/LoginWidget.dart';
import 'package:taxiapp/widget/greenintroWidget.dart';

import '../widget/custombutton.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final countryPicker = const FlCountryCodePicker();
  CountryCode countryCode =
      CountryCode(name: 'Pakistan', code: 'PK', dialCode: '+92');
  onsubmit(String? input) {
    Get.to(() => OtpVerification(
          Phonenumber: countryCode.dialCode + input!,
        ));
    print(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              greenintroWidget(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: loginWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 1,
                    //       child: InkWell(
                    //         child: Container(
                    //           child: Row(
                    //             children: [
                    //               Expanded(
                    //                 child: Container(
                    //                   child: countryCode.flagImage(),
                    //                 ),
                    //               ),
                    //               textWidget(text: countryCode.dialCode)
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       color: Colors.black12,
                    //       width: 2,
                    //       height: 22,
                    //     ),
                    //     Expanded(
                    //       flex: 3,
                    //       child: Container(
                    //         child: TextField(
                    //           decoration: InputDecoration(
                    //               hintText: 'Enter Phone number',
                    //               border: InputBorder.none),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      initialCountryCode: 'PK',
                      onSubmitted: (input) => onsubmit(input),
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                    SizedBox(height: 16.0),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  'By creating an account, you agree to our '),
                          TextSpan(
                            text: 'Terms of Service and Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              customButton(
                text: 'Continue',
              )
            ],
          ),
        ),
      ),
    );
  }
}
