// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var otpController = TextEditingController();
  _launchURL() async {
    const url = 'https://github.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchWhatsApp({
    required String phone,
    required String message,
  }) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://api.whatsapp.com/send/?phone=$phone&text&app_absent=0";
        //"https://api.whatsapp.com/send/?phone=$phone&text}";
        //https://api.whatsapp.com/send?text=Hello there! // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   backgroundColor: Color(0XFF385277),
      //   centerTitle: true,
      //   title: Text("Blitz"),
      // ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 70.h),
                  Text(
                    "Say \"Hi\" To Anyone",
                    //"$RandomNumber",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "WhatsApp Text to Anyone",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),

                  //SvgPicture.asset('assets/icons/login.svg'),
                  Container(
                      height: 250.h,
                      child: Lottie.network(
                        'https://assets3.lottiefiles.com/dotlotties/dlf10_bofqdzza.lottie',
                        fit: BoxFit.cover,
                      )),

                  SizedBox(height: 10.h),

                  //===============================================================================================================
                  Form(
                    // key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFf0f0f0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.all(10.h),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),

                            ////////////////////////Enter email//////////////////////////////

                            child: TextFormField(
                              controller: otpController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 29.h),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText:
                                    "Phone number in international format",
                                hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4)),
                                //prefixIcon: Icon(Icons.mail,size: 13.0),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          // onTap: validate,
                          onTap: () {
                            if (otpController.text.isNotEmpty) {
                              try {
                                launchWhatsApp(
                                    phone: otpController.text, message: 'Hi..');
                              } catch (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Something wrong")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Something wrong")));
                            }
                            //_launchURL();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 56.h,
                            margin: const EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            //  height: blockSizeVertical*7.5,
                            //  width: blockSizeHorizontal*60,
                            // margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0XFF385277)),
                            child: Text(
                              'PROCEED',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          // color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  //NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
