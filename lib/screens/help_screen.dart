import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height+20,
          child: Column(
            children: <Widget>[
              Row(

                children: [
                  TextButton(
                    child: Icon(Icons.arrow_back_ios,color:Colors.black),
                    onPressed: (){
                      Navigator.pop(context);
                      },
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    //top: MediaQuery.of(context).padding.top,
                    left: 16,
                    right: 16),
                child: Image.asset('assets/images/help.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: const Text(
                  'How can we help you?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: const Text(
                  'It looks like you are experiencing problems\nwith our sign up process. We are here to\nhelp so please get in touch with us',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                            color: gold,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _telePhoneLanucher();
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: SvgPicture.asset(
                                        'assets/svgImages/Call.svg',
                                        height: 20.0,
                                        width: 30.0,
                                        color: Colors.black,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        'Contact Us',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          width: 230,
                          height: 40,
                          decoration: BoxDecoration(
                            color: gold,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  offset: const Offset(4, 4),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _whatsAppLauncher();
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: SvgPicture.asset(
                                        'assets/svgImages/whatsapp.svg',
                                        height: 30.0,
                                        width: 30.0,
                                        color: Colors.black,
                                        allowDrawingOutsideViewBox: true,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        'Chat with Us via WhatsApp',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
    // return SafeArea(
    //   top: false,
    //   child: ,
    // );
  }

}

_whatsAppLauncher() async {
  String whatsAppurl="https://wa.me/923251177772?text=Hi!";
  String whatsappmessage="?text=Your Message here";
  var encoded = Uri.encodeFull(whatsAppurl);

  if (await canLaunch(encoded)) {
    await launch(encoded);
  } else {
    throw 'Could not launch $encoded';
  }
}

_telePhoneLanucher() async {

  if (await canLaunch("tel://03251177772")) {
    await launch("tel://03251177772");
  } else {
    throw 'Could not launch ';
  }
}
