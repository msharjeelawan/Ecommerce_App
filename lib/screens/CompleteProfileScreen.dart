import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saraa_kuch/controller/LoginSignUpController.dart';
import 'package:saraa_kuch/helper/helper.dart';
import 'package:saraa_kuch/screens/OtpScreen.dart';
import 'package:saraa_kuch/widgets/FormError.dart';

import '../constants.dart';
import 'HomeScreen.dart';

class CompleteProfileScreen extends StatefulWidget {
  int id;
  CompleteProfileScreen({Key key, this.id}) : super(key: key);


  @override
  _CompleteProfileScreenState createState() {
    return _CompleteProfileScreenState();
  }
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  LoginSignupBloc loginSignupbloc = LoginSignupBloc();
  final _formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String address = "";
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: width * 0.2,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 17,
                      color: Color.fromRGBO(25, 25, 25, 1),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: width * 0.6,
                  child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color.fromRGBO(139, 139, 139, 1)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "Complete Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Text(
                        "Complete your details or skip",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(139, 139, 139, 1)),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) =>
                          firstName = newValue.toString().trim(),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          labelText: "First Name",
                          hintText: "Enter your first name",
                          suffixIcon: Icon(Icons.account_circle_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) =>
                          lastName = newValue.toString().trim(),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          labelText: "Last Name",
                          hintText: "Enter your last name",
                          suffixIcon: Icon(Icons.account_circle_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      onSaved: (newValue) =>
                          phoneNumber = newValue.toString().trim(),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          labelText: "Phone Number",
                          hintText: "Enter your phone number",
                          suffixIcon: Icon(Icons.smartphone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (newValue) =>
                          address = newValue.toString().trim(),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          labelText: "Address",
                          hintText: "Enter your address",
                          suffixIcon: Icon(Icons.location_on_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    StreamBuilder(
                        stream: loginSignupbloc.validateStream,
                        initialData: errors,
                        builder: (context, snapshot) {
                          return snapshot.data != ""
                              ? FormError(errors: snapshot.data)
                              : Container();
                        }),
                    StreamBuilder(
                        stream: loginSignupbloc.progressStream,
                        initialData: false,
                        builder: (context, snapshot) {
                          return snapshot.data == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container();
                        }),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          /*var route = MaterialPageRoute(
                                  builder: (BuildContext context){
                                    return OtpScreen();
                                  }
                              );
                              Navigator.push(context, route);
                              */
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            // if all are valid then go to success screen
                            KeyboardUtil.hideKeyboard(context);
                            loginSignupbloc.validateProfileErrors(
                                firstName, lastName, phoneNumber,address,widget.id.toString(),context);
                          }
                        },
                        child: Text("Continue"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(gold),
                            fixedSize: MaterialStateProperty.all(
                                Size(width * 0.88, 45)),
                            // backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))))),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                          "By continuing your confirm that you agree with our Term and Condition",
                          maxLines: 2,
                        )),
                        TextButton(
                            child: Text(
                              "Skip",
                              style: TextStyle(color: gold),
                            ),
                            onPressed: () {

                              var route = MaterialPageRoute(builder: (BuildContext context) {
                                return HomeScreen();
                              });
                              Navigator.push(context, route);
                            })
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
