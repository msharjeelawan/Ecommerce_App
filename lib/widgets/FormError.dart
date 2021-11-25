import 'package:flutter/material.dart';
import 'package:saraa_kuch/controller/LoginSignUpController.dart';
import 'package:saraa_kuch/models/EventActionEnum.dart';


import '../constants.dart';


class FormError extends StatelessWidget {
   FormError({
    Key key,
    this.errors,
  }) : super(key: key);

  final List<String> errors;
  LoginSignupBloc loginSignupbloc = LoginSignupBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({String error}) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Text(error,
            style: TextStyle(color: gold)),
      ],
    );
  }
}
