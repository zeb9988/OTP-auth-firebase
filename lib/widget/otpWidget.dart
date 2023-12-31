import 'package:flutter/material.dart';

Widget otpWidget() {
  return Container(
    child: OtpLoginWidget(),
  );
}

Widget OtpLoginWidget() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget(text: 'Hello Nice to meet you', fontSize: 16),
        SizedBox(
          height: 20,
        ),
        textWidget(
            text: 'Get Moving With Go Cabs',
            fontSize: 30,
            fontWeight: FontWeight.bold),
        SizedBox(
          height: 10,
        ),
      ],
    )),
  );
}

Widget textWidget(
    {required String text,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}
