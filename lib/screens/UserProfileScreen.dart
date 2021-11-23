import 'dart:convert';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saraa_kuch/SharedPref/SharedPrefren.dart';
import 'package:saraa_kuch/controller/LoginSignUpController.dart';
import 'package:saraa_kuch/helper/helper.dart';
import 'package:saraa_kuch/models/Customer.dart';
import 'package:saraa_kuch/screens/RatingScreen.dart';
import 'package:saraa_kuch/widgets/FormError.dart';

import '../constants.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() {
    return _UserProfileScreenState();
  }
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  LoginSignupBloc loginSignupbloc = LoginSignupBloc();
  File image;
  final _formKey = GlobalKey<FormState>();
  String customerid = "";
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String address = "";
  String postalCode = "";
  List<String> errors = [];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  Customer customer = Customer();
  Customer customer2 = Customer();

  @override
  void initState() {
    super.initState();
    getCustomerDetail();
  }
  Future pickImage(ImageSource source)async{
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      setState(() {
        this.image = File(image.path);
      });
    }on PlatformException catch(e)
    {
      print("Failed to pick Image"+e.message);
    }

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Icon(Icons.arrow_back_ios,color:Colors.black)),
                      Expanded(child: SizedBox(width: 1,),),
                      Text(
                        "User Profile",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: SizedBox(width: 1,),),
                      Expanded(child: SizedBox(width: 1,),),
                      Expanded(child: SizedBox(width: 1,),),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // GestureDetector(
                  //   child: Stack(
                  //     children: [
                  //       Container(
                  //         width: width * 0.35,
                  //         height: width * 0.35,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           image: new DecorationImage(
                  //               image: image==null? Image.asset("assets/images/profileImage.png",).image:
                  //               new FileImage(image),
                  //               fit: BoxFit.fill
                  //           ),
                  //           boxShadow: <BoxShadow>[
                  //             BoxShadow(
                  //                 color: Colors.black12,
                  //                 spreadRadius: 1,
                  //                 blurRadius: 4)
                  //           ],
                  //           borderRadius: BorderRadius.circular(100),
                  //         ),
                  //
                  //         /*     child: image != null
                  //               ? Image.file(
                  //             image,
                  //               fit: BoxFit.fill,
                  //           )
                  //               : Container(
                  //             child: Icon(
                  //               Icons.camera_alt,
                  //               color: Colors.grey[800],
                  //             ),
                  //           ),*/
                  //       ),
                  //       Positioned(
                  //           bottom: 0,
                  //           right: 0,
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //               color: Color.fromRGBO(241, 241, 241, 1),
                  //               borderRadius: BorderRadius.circular(20),
                  //               // boxShadow: [
                  //               //   BoxShadow(
                  //               //     color: Colors.black12,
                  //               //     spreadRadius: 1,
                  //               //     blurRadius: 8,
                  //               //   )
                  //               // ]
                  //             ),
                  //             child: SizedBox(
                  //               child: Icon(Icons.photo_camera_sharp,
                  //                   color: Color.fromRGBO(136, 136, 137, 1)),
                  //               width: 40,
                  //               height: 40,
                  //             ),
                  //           ))
                  //     ],
                  //   ),
                  //   onTap: () {
                  //     _showPicker(context);
                  //   },
                  // ),
                  // SizedBox(height: 30,),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        //mainAxisSize: MainAxisSize.max,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: _firstNameController,
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) =>
                            firstName = newValue.toString().trim(),
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 25),
                                suffixIcon:
                                Icon(Icons.account_circle_outlined),
                                labelText: "First Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(width: 4))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _lastNameController,
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) =>
                            lastName = newValue.toString().trim(),
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 25),
                                suffixIcon:
                                Icon(Icons.account_circle_outlined),
                                labelText: "Last Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            onSaved: (newValue) =>
                            phoneNumber = newValue.toString().trim(),
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 25),
                                suffixIcon: Icon(Icons.smartphone),
                                labelText: "Phone Number",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _addressController,
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) =>
                            address = newValue.toString().trim(),
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 25),
                                suffixIcon: Icon(Icons.location_on_outlined),
                                labelText: "Address",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _postalCodeController,
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) =>
                            postalCode = newValue.toString().trim(),
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 25),
                                suffixIcon: Icon(Icons.location_on_outlined),
                                labelText: "Postal Code",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                          SizedBox(
                            height: 25,
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
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  // if all are valid then go to success screen
                                  KeyboardUtil.hideKeyboard(context);
                                  loginSignupbloc.validateProfileErrors(
                                      firstName,
                                      lastName,
                                      phoneNumber,
                                      address,
                                      customerid,
                                      postalCode,
                                      context);
                                }
                                /*    var route = MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RatingScreen();
                                });
                            Navigator.push(context, route);*/
                              },
                              child: Text("Save Changes"),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(gold),
                                  fixedSize: MaterialStateProperty.all(
                                      Size(width * 0.9, 50)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(30))))),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void getCustomerDetail() async {
    final result = await SharedPref.getCustomerDetail();
    if (result.isNotEmpty) {
      customer = Customer.fromJson(jsonDecode(result));
      if (customer != null) {
        _firstNameController.text =
        customer.firstName != null ? customer.firstName : "";
        _lastNameController.text =
        customer.lastName != null ? customer.lastName : "";
        if (customer.shipping != null) {
          customerid = customer.id.toString();
          _phoneController.text =
          customer.shipping.phone != null ? customer.shipping.phone : "";
          _addressController.text =
          customer.shipping.address1 != null ? customer.shipping.address1 : "";
          _postalCodeController.text =
          customer.shipping.postcode != null ? customer.shipping.postcode : "";
        }
      }
    }
  }



  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}