import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex_test/screens/verification_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

const registerMutation = r'''

mutation($email:String! , $password:String! , $username:String!, $country:String!, $currency:String!, $phonenumber:String!, $referralCode:String!){
 register(data:{email:$email,password:$password,username:$username, country:$country, currency:$currency, phonenumber:$phonenumber , referralCode: $referralCode}){
    user{
      _id
    }
  }
  
}

''';

class SignupScreen extends StatefulWidget {
  static final id = "SignupScreen";

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final referralController = TextEditingController();
  String country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.3),
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                  onPressed: () {}),
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60),
                    Text(
                      "Create a new account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    CustomInputField(
                      text: "Email Address",
                      controller: emailController,
                    ),
                    CustomInputField(
                      text: "Password (Min 8 characters)",
                      controller: passwordController,
                    ),
                    CustomInputField(
                      text: "Create a username",
                      controller: usernameController,
                    ),
                    InternationalPhoneNumberInput(
                      textFieldController: phoneController,
                      selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                      onInputChanged: (PhoneNumber phone) {
                        country = phone.isoCode;
                      },
                    ),
                    CustomInputField(
                      text: "Referral code (optional)",
                      controller: referralController,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "By signing in you agree to HaggleX terms and privacy policy",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Mutation(
                          options: MutationOptions(
                            document: gql(registerMutation),
                          ),
                          builder:
                              (RunMutation runMutation, QueryResult result) {
                            return TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).canvasColor)),
                              onPressed: () {
                                runMutation({
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                  "username": usernameController.text,
                                  "phonenumber": phoneController.text,
                                  "referralCode": referralController.text,
                                  "country": country,
                                  "currency": "USD"
                                });
                                log(result.data.toString());
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return VerificationScreen(
                                      email: emailController.text);
                                }));
                              },
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final text;
  final color;
  final controller;

  CustomInputField({this.color = Colors.black, this.text, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: color),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color)),
        ),
      ),
    );
  }
}
