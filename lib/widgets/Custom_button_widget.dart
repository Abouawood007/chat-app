import 'package:flutter/material.dart';

import 'constant_widget.dart';

// ignore: non_constant_identifier_names
Widget CustomButton({@required VoidCallback? onPressed, String? buttonName}) =>
    SizedBox(height: 50,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)))),
          child: Text(
            buttonName!,
            style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 22),
          )),
    );
