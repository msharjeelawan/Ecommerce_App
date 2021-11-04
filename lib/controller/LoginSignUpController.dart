import 'dart:async';
import 'package:flutter/material.dart';
import 'package:saraa_kuch/models/Customer.dart';
import 'package:saraa_kuch/models/EventActionEnum.dart';
import 'package:saraa_kuch/models/login_response.dart';
import 'package:saraa_kuch/screens/CompleteProfileScreen.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';
import 'package:saraa_kuch/services/LoginSignUpService.dart';

import '../constants.dart';
import '../services/HomeService.dart';

class LoginSignupBloc {
  //login,validation controller
  StreamController<bool> _loginResponseController =
      new StreamController<bool>();
  StreamSink _progressSink;
  Stream progressStream;
  StreamController<List<String>> _validationResponse =
      new StreamController<List<String>>();
  StreamSink _validateSink;
  Stream validateStream;
  List<String> errors = [];

/*
  final _eventStreamController = StreamController<EventAction>();
  StreamSink<EventAction> get eventSink => _eventStreamController.sink;
  Stream<EventAction> get _eventStream => _eventStreamController.stream;*/

  LoginSignupBloc() {
    //validation stream
    _validateSink = _validationResponse.sink;
    validateStream = _validationResponse.stream;
    //login  stream & sink
    _progressSink = _loginResponseController.sink;
    progressStream = _loginResponseController.stream;

    _progressSink.add(false);
    _validateSink.add(errors);

    //this method will get products from api as json
    //  getProductsFromApi();

    // stream = controller.stream;
    // sink = controller.sink;
    // stream.listen((event) { p(event);});
    //
    // stream1 = controller1.stream;
    // sink1 = controller1.sink;

    /*  _eventStream.listen((event) {
      if (event == EventAction.clearErrors)
       {
         errors=[];
         _validateSink.add(errors);

       }


    });*/
  }

  void loginCustomer(email, password) async {
    _progressSink.add(true);

    final results = await LoginSignupScreen.loginCustomer(email, password);
    // _controller.sink.add(results);
    if (results.token != null) {
      _progressSink.add(false);

      print("objects" + results.toJson().toString());
    } else {
      print("Empty" + results.toJson().toString());
      _progressSink.add(false);
      errors = [];
      addError(error: notvalidateEmailorPassword);
    }
  }

  void RegisterCustomer(email, password, context) async {
    _progressSink.add(true);

    final results = await LoginSignupScreen.RegisterCustomer(email, password);
    // _controller.sink.add(results);
    if (results.id != null) {
      _progressSink.add(false);

      print("objects" + results.toJson().toString());
      var route = MaterialPageRoute(builder: (BuildContext context) {
        return CompleteProfileScreen(id:results.id);
      });
      Navigator.push(context, route);
    } else {
      //   print("Empty"+results.toJson().toString());
      _progressSink.add(false);
      errors = [];
      if (results.firstName != null) {
        if (results.firstName == "400") {
          addError(error: messagealreadyexist);
        } else {
          addError(error: conectivityConnection);
        }
      } else {
        addError(error: notvalidateEmailorPassword);
      }
    }
  }

  void completeProfile(
      firstName, lastName, phoneNumber, address,id, context) async {
    _progressSink.add(true);
    Ing shipping = Ing(
        firstName: firstName.toString(),
        lastName: lastName.toString(),
        phone: phoneNumber.toString(),
        address1: address.toString());
    Ing billing = Ing();
    Customer customer = Customer(firstName: firstName.toString(), lastName: lastName.toString());

    final results = await LoginSignupScreen.updateCustomerProfile(customer,shipping,billing,id);
    // _controller.sink.add(results);
    if (results.id != null) {
      _progressSink.add(false);

      print("completeProfile" + results.toJson().toString());
      var route = MaterialPageRoute(builder: (BuildContext context) {
        return HomeScreen();
      });
      Navigator.push(context, route);
    } else {
      //   print("Empty"+results.toJson().toString());
      _progressSink.add(false);
      errors = [];
      if (results.firstName != null) {
        print("Customer id" + id);

        if (results.firstName == "400") {
          addError(error: conectivityConnection);
        } else {
          addError(error: conectivityConnection);
        }
      } else {
        addError(error: notvalidateEmailorPassword);
      }
    }
  }

  String validateErrors(email, password) {
    errors = [];
    _validateSink.add(errors);

    if (email.isEmpty) {
      addError(error: kEmailNullError);
      return "";
    } else if (!emailValidatorRegExp.hasMatch(email)) {
      addError(error: kInvalidEmailError);
      return "";
    }
    if (password.isEmpty) {
      addError(error: kPassNullError);
      return "";
    } else if (password.length < 6) {
      addError(error: kShortPassError);
      return "";
    }
    loginCustomer(email, password);
  }

  String validateSignupErrors(email, password, password2, context) {
    errors = [];
    _validateSink.add(errors);
//Email Validation
    if (email.isEmpty) {
      addError(error: kEmailNullError);
      return "";
    } else if (!emailValidatorRegExp.hasMatch(email)) {
      addError(error: kInvalidEmailError);
      return "";
    }
    //password validation

    if (password.isEmpty) {
      addError(error: kPassNullError);
      return "";
    } else if (password.length < 6) {
      addError(error: kShortPassError);
      return "";
    }
    if (password2.isEmpty) {
      addError(error: kPassNullError2);
      return "";
    } else if (password.length < 6) {
      addError(error: kShortPassError2);
      return "";
    }
    if (password != password2) {
      addError(error: kMatchPassError);
      return "";
    }
    RegisterCustomer(email, password, context);
  }

  String validateProfileErrors(firstName, lastname, phone, address,id ,context) {
    errors = [];
    _validateSink.add(errors);
//Email Validation
    if (firstName.isEmpty) {
      addError(error: firstnameEnter);
      return "";
    }
    //password validation

    if (lastname.isEmpty) {
      addError(error: lastnameEnter);
      return "";
    }
    if (phone.isEmpty) {
      addError(error: phoneEnter);
      return "";
    }
    if (address.isEmpty) {
      addError(error: addressEnter);
      return "";
    }
print("id id id "+id.toString());
    completeProfile(firstName, lastname, phone, address,id,context);
  }

  void addError({String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
      _validateSink.add(errors);
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
      _validateSink.add(errors);
    }
  }
}
