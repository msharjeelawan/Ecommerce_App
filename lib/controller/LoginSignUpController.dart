import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/models/Customer.dart';
import 'package:saraa_kuch/models/EventActionEnum.dart';
import 'package:saraa_kuch/models/login_response.dart';
import 'package:saraa_kuch/screens/CompleteProfileScreen.dart';
import 'package:saraa_kuch/screens/ConfirmPassword.dart';
import 'package:saraa_kuch/screens/HomeScreen.dart';
import 'package:saraa_kuch/screens/OtpScreen.dart';
import 'package:saraa_kuch/services/LoginSignUpService.dart';
import 'package:saraa_kuch/services/ResetPassword.dart';
import 'dart:io' show Platform;
import '../constants.dart';
import '../services/HomeService.dart';

class LoginSignupBloc {
  //context for navigation
  BuildContext context;

  //login,validation controller
  StreamController<bool> _loginResponseController = new StreamController<bool>();
  StreamSink _progressSink;
  Stream progressStream;
  StreamController<List<String>> _validationResponse = new StreamController<List<String>>();
  StreamSink _validateSink;
  Stream validateStream;

  StreamController<String> _secondResponse = new StreamController<String>();
  StreamSink _secondSink;
  Stream secondStream;
  Timer _timer;
  List<String> errors = [];
  final _googleSignIn = GoogleSignIn();


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
// second timer
    _secondSink = _secondResponse.sink;
    secondStream = _secondResponse.stream;

    _progressSink.add(false);
    _validateSink.add(errors);
    _secondSink.add("60");

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
    final result2 = await LoginSignupScreen.GetCustomerResponse(email);
    // _controller.sink.add(results);
    if (result2.id != null) {
      await SharedPref.addCustomerDetail(jsonEncode(result2));
      print("Customer Login Response" +
          result2.email +
          "id " +
          result2.id.toString());
    } else {
      print("Customer Login Response" +
          result2.firstName +
          "id " +
          result2.id.toString());
    }
    if (results.statusCode == 200) {
      _progressSink.add(false);
      await SharedPref.addLoginDetail(jsonEncode(results));
      //login success now go back to previous screen
      Navigator.pop(context,true);
      print("objects" + results.toJson().toString());
    } else {
      _progressSink.add(false);
      errors = [];
      addError(error: results.message);
    }
  }

  void RegisterCustomer(email, password, context) async {
    _progressSink.add(true);

    final results = await LoginSignupScreen.RegisterCustomer(email, password);
    // _controller.sink.add(results);
    if (results.id != null) {
      _progressSink.add(false);
      await SharedPref.addCustomerDetail(jsonEncode(results));

      print("objects" + results.toJson().toString());
      var route = MaterialPageRoute(builder: (BuildContext context) {
        return CompleteProfileScreen(id: results.id);
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

  void completeProfile(firstName, lastName, phoneNumber, address, id, postalCode, context) async {
    bool isroutehome = false;
    if (postalCode == "completeprofile") {
      postalCode = "";
      isroutehome = true;
    }
    _progressSink.add(true);
    Ing shipping = Ing(
      firstName: firstName.toString(),
      lastName: lastName.toString(),
      phone: phoneNumber.toString(),
      address1: address.toString(),
      postcode: postalCode.toString(),
    );
    Ing billing = Ing();
    Customer customer = Customer(
        firstName: firstName.toString(), lastName: lastName.toString());

    final results = await LoginSignupScreen.updateCustomerProfile(
        customer, shipping, billing, id);
    // _controller.sink.add(results);
    if (results.id != null) {
      _progressSink.add(false);
      await SharedPref.addCustomerDetail(jsonEncode(results));
      print("completeProfile" + results.toJson().toString());
      if (isroutehome) {
        var route = MaterialPageRoute(builder: (BuildContext context) {
          return HomeScreen();
        });
        Navigator.push(context, route);
      } else {
        Navigator.pop(context);
      }
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

  void resetPasssword(email, context, type) async {
    _progressSink.add(true);
    errors = [];
    _validateSink.add(errors);
    final results = await ResetPasswordAPi.getResetPassword(email);
    _progressSink.add(false);
    if (results != null) {
      if (results.data.status == 200) {
        if (type == "send") {
          var route = MaterialPageRoute(builder: (BuildContext context) {
            return OtpScreen(email: email);
          });
          Navigator.push(context, route);
        } else {
          //this is not errors, it is only message otp has been sent to
          secondfunction();
          addError(error: resentOtpMessage);
        }
      } else {
        addError(error: nouserFound);
      }
    } else {
      addError(error: conectivityConnection);
    }
  }

  void verifySecurityCode(String securitycode, email, context) async {
    _progressSink.add(true);
    errors = [];
    _validateSink.add(errors);
    final results =
    await ResetPasswordAPi.verificationPassword(email, securitycode);
    _progressSink.add(false);
    if (results != null) {
      if (results.data.status == 200) {
        var route = MaterialPageRoute(builder: (BuildContext context) {
          return ConfirmPassword(email: email, securityCode: securitycode);
        });
        Navigator.push(context, route);

        //this is not errors, it is only message otp has been sent to

      } else {
        addError(error: results.message);
      }
    } else {
      addError(error: conectivityConnection);
    }
  }

  void changePassword(email, securitycode, password, context) async {
    print("emai" +
        email +
        "\n password" +
        password +
        "\n securityCode" +
        securitycode);

    _progressSink.add(true);
    errors = [];
    _validateSink.add(errors);
    final results =
    await ResetPasswordAPi.savePassword(email, password, securitycode);
    _progressSink.add(false);
    if (results != null) {
      print("change password response" + results.toJson().toString());
      if (results.data.status == 200) {
        /*   var route = MaterialPageRoute(builder: (BuildContext context) {
          return ConfirmPassword(email:email);
        });
        Navigator.push(context, route);*/

        //this is not errors, it is only message otp has been sent to

        addError(error: results.message);
      } else {
        addError(error: results.message);
      }
    } else {
      addError(error: conectivityConnection);
    }
  }

  Future<GoogleSignInAccount> googleLogin() async {
    await _googleSignIn.signOut();
    GoogleSignInAccount user = await _googleSignIn.signIn();
    if (user == null) {
      print("Not Login user");
    } else {
      print("User Email Id user" + user.email);
      googleLoginCustomer(user.email);
    }

  }
  Future facebookLogin(BuildContext context)
  async {
    await FacebookAuth.instance.logOut();

    if (Platform.isAndroid) {
      print("Android Platform ");
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: [
          'email',
          'public_profile',
          'user_birthday',
          'user_friends',
          'user_gender',
          'user_link'
        ],
      );
      if (result.status == LoginStatus.success) {
        // you are logged

        final requestData = await FacebookAuth.instance.getUserData(
          fields: "name,email,picture.width(200),birthday,friends,gender,link",
        );
        print("request from Facebook data" + requestData.toString());
        print("requestData name Facebook data" + requestData["name"].toString());
        if(requestData["email"]==null)
        {
          print("Email is not public. please set public email or login through another method  +.toString()");
          await FacebookAuth.instance.logOut();
          showAlertDialog(context,facebookLoginemail.toString());



        }else{
          googleLoginCustomer(requestData["email"]);

        }

      } else {
        print("request from Facebook data result.status" +
            result.status.toString());
        print("request from Facebook data result.message" + result.message);
        showAlertDialog(context,facebookLogin.toString());

      }

    } else if (Platform.isIOS) {
      print("IOS Platform ");
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // you are logged

        final requestData = await FacebookAuth.instance.getUserData(
          fields: "name,email,picture.width(200),birthday,friends,gender,link",
        );
        print("request from Facebook data" + requestData.toString());
        print("requestData name Facebook data" + requestData["name"].toString());
        if(requestData["email"]==null)
        {
          print("Email is not public. please set public email or login through another method  +.toString()");
          await FacebookAuth.instance.logOut();
          showAlertDialog(context,facebookLoginemail.toString());



        }else{
          googleLoginCustomer(requestData["email"]);

        }

      } else {
        print("request from Facebook data result.status" +
            result.status.toString());
        print("request from Facebook data result.message" + result.message);
        showAlertDialog(context,facebookLogin.toString());

      }

      // iOS-specific code
    }else{
      showAlertDialog(context,plaformlogin.toString());

    }


  }

  void googleLoginCustomer(email) async {
    _progressSink.add(true);

    final results = await LoginSignupScreen.SocialMediaustomer(email);
    final result2 = await LoginSignupScreen.GetCustomerResponse(email);
    // _controller.sink.add(results);
    if (result2.id != null) {
      await SharedPref.addCustomerDetail(jsonEncode(result2));
      print("Customer Login Response" +
          result2.email +
          "id " +
          result2.id.toString());
    } else {
      print("Customer Login Response" +
          result2.firstName +
          "id " +
          result2.id.toString());
    }
    if (results.statusCode == 200) {
      _progressSink.add(false);
      await SharedPref.addLoginDetail(jsonEncode(results));

      print("objects" + results.toJson().toString());
    } else {
      _progressSink.add(false);
      errors = [];
      addError(error: results.message);
    }
  }

// Validations
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

  String validateProfileErrors(firstName, lastname, phone, address, id,postalCode, context) {
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
    //detection from where postalcode come

    print("id id id " + id.toString());
    completeProfile(
        firstName, lastname, phone, address, id, postalCode, context);
  }

  String validateEmailErrors(email, context) {
    errors = [];
    _validateSink.add(errors);

    if (email.isEmpty) {
      addError(error: kEmailNullError);
      return "";
    } else if (!emailValidatorRegExp.hasMatch(email)) {
      addError(error: kInvalidEmailError);
      return "";
    }

    resetPasssword(email, context, "send");
  }

  String validateOtpErrors(otp1, otp2, otp3, otp4, email, context) {
    errors = [];
    _validateSink.add(errors);

    if (otp1.isEmpty || otp2.isEmpty || otp3.isEmpty || otp4.isEmpty) {
      addError(error: otp);
      return "";
    } else if (otp1.length > 1) {
      addError(error: kInvalidEmailError);
      return "";
    }
    String securitycode = otp1 + otp2 + otp3 + otp4;

    verifySecurityCode(securitycode, email, context);
  }

  String validateChangePasswordErrors(email, securitycode, password, password2, context) {
    errors = [];
    _validateSink.add(errors);
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
    print("securityCode:...." + securitycode);

    changePassword(email, securitycode, password, context);
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

// second functions
  void secondfunction() {
    int _start = 60;
    _secondSink.add(_start.toString());
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (_start < 1) {
        _secondSink.add(_start.toString());
        errors = [];
        _validateSink.add(errors);
        timer.cancel();
      } else {
        _secondSink.add(_start.toString());
        _start = _start - 1;
      }
    });
  }

  void closeStream() {
    _loginResponseController.close();
    _validationResponse.close();
    _secondResponse.close();
  }
}
void showAlertDialog(context, description) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Alert',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: (){


            Navigator.pop(context, 'No');

          },

          child: const Text('Cancel',
            style: TextStyle(fontWeight: FontWeight.bold,color: gold),
          ),
        ),
        TextButton(
          onPressed: () async{
            final result=await SharedPref.removeLoginDetail();
            final result2=await SharedPref.removeCustomerDetail();

            Navigator.pop(context, 'Yes');


          },
          child: const Text('OK',
            style: TextStyle(fontWeight: FontWeight.bold,color: gold),
          ),
        ),
      ],
    ),
  );
  print('Doing Something...'); // Print to console.
}